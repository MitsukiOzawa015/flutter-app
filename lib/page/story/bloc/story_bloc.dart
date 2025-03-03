import 'package:bloc/bloc.dart';
import 'package:practice_app/entity/story.dart';
import 'package:practice_app/gateway/story_model.dart';
import 'package:practice_app/page/post/bloc/post_event.dart';
import 'package:practice_app/page/story/bloc/story_event.dart';
import 'package:practice_app/page/story/bloc/story_state.dart';
import 'package:practice_app/use_case/story_use_case.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  final StoryUseCase? storyUseCase;

  StoryBloc({required this.storyUseCase}) : super(InitialStoryState());

  @override
  Stream<StoryState> mapEventToState(StoryEvent event) async* {
    if (event is LoadStoryEvent) {
      yield* _mapLoadingStory();
      yield* _mapLoadStory();
    }
  }

  Stream<StoryState> _mapLoadingStory() async* {
    yield StoryLoading();
  }

  Stream<StoryState> _mapLoadStory() async* {
    StoryListResponse? storyListResponse = await storyUseCase?.getStory();
    var StoryResponseList2 = storyListResponse?.storyResponseList ?? [];
    yield StoryLoaded(
        storyList:
            storyListResponse?.storyResponseList?.map((e) =>
                Story(
                    icon: e.icon,
                    userName: e.userName,
                    stories :e.stories,
                )).toList(),);
  }

}
