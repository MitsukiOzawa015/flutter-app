# BLoC Pattern Migration Guide

## Overview
This guide provides step-by-step instructions for migrating from the deprecated `mapEventToState` pattern to the new `on<Event>` pattern in Flutter BLoC.

## Why Migrate?
- `mapEventToState` is deprecated and will be removed in future versions
- New pattern provides better error handling
- Improved performance and debugging capabilities
- Better type safety and testability

## Migration Steps

### 1. PostBloc Migration

#### Current Implementation (Deprecated)
```dart
@override
Stream<PostState> mapEventToState(PostEvent event) async* {
  if (event is LoadPostEvent) {
    yield* _mapLoadingPost();
    yield* _mapLoadPost();
  } else if (event is ChangePostLikeEvent) {
    yield* _mapChangePostLike(event.postId);
  }
}
```

#### New Implementation
```dart
PostBloc({required this.postUseCase}) : super(InitialPostState()) {
  on<LoadPostEvent>(_onLoadPost);
  on<ChangePostLikeEvent>(_onChangePostLike);
}

Future<void> _onLoadPost(LoadPostEvent event, Emitter<PostState> emit) async {
  emit(PostLoading());
  
  try {
    PostListResponse? postListResponse = await postUseCase?.getPost();
    var postResponseList = postListResponse?.postResponseList ?? [];
    
    List<Post> postList = postResponseList.map((e) => Post(
      postId: e.postId,
      userName: e.userName,
      icon: e.icon,
      images: e.images,
      text: e.text,
      isLike: e.isLike
    )).toList();
    
    emit(PostLoaded(postList: postList));
  } catch (error) {
    emit(PostError(message: error.toString()));
  }
}

Future<void> _onChangePostLike(ChangePostLikeEvent event, Emitter<PostState> emit) async {
  try {
    await postUseCase?.changePostLike(event.postId);
    
    // Option 1: Reload all posts
    add(LoadPostEvent());
    
    // Option 2: Update specific post in current state
    // if (state is PostLoaded) {
    //   final currentState = state as PostLoaded;
    //   final updatedPosts = currentState.postList?.map((post) {
    //     if (post.postId == event.postId) {
    //       return post.copyWith(isLike: !post.isLike);
    //     }
    //     return post;
    //   }).toList();
    //   emit(PostLoaded(postList: updatedPosts));
    // }
  } catch (error) {
    emit(PostError(message: 'Failed to update like status'));
  }
}
```

### 2. StoryBloc Migration

#### Current Implementation (Deprecated)
```dart
@override
Stream<StoryState> mapEventToState(StoryEvent event) async* {
  if (event is LoadStoryEvent) {
    yield* _mapLoadingStory();
    yield* _mapLoadStory();
  }
}
```

#### New Implementation
```dart
StoryBloc({required this.storyUseCase}) : super(InitialStoryState()) {
  on<LoadStoryEvent>(_onLoadStory);
}

Future<void> _onLoadStory(LoadStoryEvent event, Emitter<StoryState> emit) async {
  emit(StoryLoading());
  
  try {
    StoryListResponse? storyListResponse = await storyUseCase?.getStory();
    var storyResponseList = storyListResponse?.storyResponseList ?? [];
    
    List<Story> storyList = storyResponseList.map((e) => Story(
      icon: e.icon,
      userName: e.userName,
      stories: e.stories,
    )).toList();
    
    emit(StoryLoaded(storyList: storyList));
  } catch (error) {
    emit(StoryError(message: error.toString()));
  }
}
```

### 3. Add Error States

#### PostState Addition
```dart
class PostError extends PostState {
  final String message;
  
  const PostError({required this.message});
  
  @override
  List<Object?> get props => [message];
}
```

#### StoryState Addition
```dart
class StoryError extends StoryState {
  final String message;
  
  const StoryError({required this.message});
  
  @override
  List<Object?> get props => [message];
}
```

### 4. Update UI to Handle Error States

#### In Post Widget
```dart
BlocBuilder<PostBloc, PostState>(
  builder: (context, state) {
    if (state is PostLoading) {
      return const CircularProgressIndicator();
    } else if (state is PostLoaded) {
      return PostListView(posts: state.postList);
    } else if (state is PostError) {
      return ErrorWidget(
        message: state.message,
        onRetry: () => context.read<PostBloc>().add(LoadPostEvent()),
      );
    }
    return const SizedBox.shrink();
  },
)
```

#### In Story Widget
```dart
BlocBuilder<StoryBloc, StoryState>(
  builder: (context, state) {
    if (state is StoryLoading) {
      return const CircularProgressIndicator();
    } else if (state is StoryLoaded) {
      return StoryListView(stories: state.storyList);
    } else if (state is StoryError) {
      return ErrorWidget(
        message: state.message,
        onRetry: () => context.read<StoryBloc>().add(LoadStoryEvent()),
      );
    }
    return const SizedBox.shrink();
  },
)
```

## Testing the Migration

### 1. Unit Test Updates

#### Old Test Pattern
```dart
blocTest<PostBloc, PostState>(
  'emits [PostLoading, PostLoaded] when LoadPostEvent is added',
  build: () => PostBloc(postUseCase: mockPostUseCase),
  act: (bloc) => bloc.add(LoadPostEvent()),
  expect: () => [PostLoading(), PostLoaded(postList: expectedPosts)],
);
```

#### New Test Pattern (Same)
The test syntax remains the same, but now you can test error scenarios more easily:

```dart
blocTest<PostBloc, PostState>(
  'emits [PostLoading, PostError] when LoadPostEvent fails',
  setUp: () {
    when(() => mockPostUseCase.getPost()).thenThrow(Exception('Network error'));
  },
  build: () => PostBloc(postUseCase: mockPostUseCase),
  act: (bloc) => bloc.add(LoadPostEvent()),
  expect: () => [
    PostLoading(),
    PostError(message: 'Exception: Network error'),
  ],
);
```

### 2. Integration Tests
Test the complete flow:
1. App startup
2. Story loading
3. Post loading
4. Like functionality
5. Error scenarios

## Common Issues and Solutions

### Issue 1: State Not Updating
**Problem**: UI doesn't update after emitting new state
**Solution**: Ensure you're calling `emit()` not `yield`

### Issue 2: Multiple Event Handlers
**Problem**: Need to handle the same event type differently
**Solution**: Use transformer or create specific event subclasses

### Issue 3: Async Event Handling
**Problem**: Events get mixed up when fired rapidly
**Solution**: Use `transformer: sequential()` in the `on<Event>` call

```dart
on<LoadPostEvent>(_onLoadPost, transformer: sequential());
```

### Issue 4: State Comparison
**Problem**: States not properly compared for changes
**Solution**: Ensure all state classes properly implement `props` getter

## Performance Considerations

1. **Event Throttling**: Use `debounce` transformer for search-like events
2. **Sequential Processing**: Use `sequential` transformer for order-dependent events
3. **State Optimization**: Only emit new states when data actually changes
4. **Memory Management**: Properly dispose of streams and subscriptions

## Best Practices

1. **Naming Convention**: Use verb-noun pattern for events (`LoadPost`, `UpdateUser`)
2. **Error Handling**: Always wrap async operations in try-catch
3. **State Immutability**: Never modify state objects directly
4. **Testing**: Write tests for both success and error scenarios
5. **Documentation**: Document complex event handling logic