import 'package:equatable/equatable.dart';
import 'package:practice_app/entity/story.dart';

abstract class StoryState extends Equatable {
  const StoryState({this.storyList});

  final List<Story>? storyList;
}

class InitialStoryState extends StoryState {
  @override
  get props => [];
}

class StoryLoading extends StoryState {
  @override
  get props => [];
}

class StoryLoaded extends StoryState {
   StoryLoaded({
    List<Story>? storyList
}) : super(storyList: storyList);

  @override
  List<Object?> get props => [storyList];
}