// Example of migrating from deprecated mapEventToState to new on<Event> pattern
// This shows the required changes for PostBloc

import 'package:bloc/bloc.dart';
import 'package:practice_app/entity/post.dart';
import 'package:practice_app/gateway/post_model.dart';
import 'package:practice_app/page/post/bloc/post_event.dart';
import 'package:practice_app/page/post/bloc/post_state.dart';
import 'package:practice_app/use_case/post_use_case.dart';

class PostBlocMigrated extends Bloc<PostEvent, PostState> {
  final PostUseCase? postUseCase;

  PostBlocMigrated({required this.postUseCase}) : super(InitialPostState()) {
    // New pattern: Register event handlers in constructor
    on<LoadPostEvent>(_onLoadPost);
    on<ChangePostLikeEvent>(_onChangePostLike);
  }

  // New pattern: Use Future<void> methods with Emitter
  Future<void> _onLoadPost(LoadPostEvent event, Emitter<PostState> emit) async {
    // Emit loading state
    emit(PostLoading());
    
    try {
      // Get posts from use case
      PostListResponse? postListResponse = await postUseCase?.getPost();
      var postResponseList = postListResponse?.postResponseList ?? [];
      
      // Convert to domain entities
      List<Post> postList = postResponseList.map((e) => Post(
        postId: e.postId,
        userName: e.userName,
        icon: e.icon,
        images: e.images,
        text: e.text,
        isLike: e.isLike
      )).toList();
      
      // Emit loaded state
      emit(PostLoaded(postList: postList));
    } catch (error) {
      // Handle errors appropriately
      emit(PostError(message: error.toString()));
    }
  }

  Future<void> _onChangePostLike(ChangePostLikeEvent event, Emitter<PostState> emit) async {
    try {
      await postUseCase?.changePostList(event.postId);
      // Re-emit current state or refresh data
      // emit(state); // If you want to keep current state
      // Or reload the posts to get updated like status
      add(LoadPostEvent());
    } catch (error) {
      // Handle like toggle error
      emit(PostError(message: 'Failed to update like status'));
    }
  }
}

// You would need to add a PostError state to handle errors properly
class PostError extends PostState {
  final String message;
  
  const PostError({required this.message});
  
  @override
  List<Object?> get props => [message];
}