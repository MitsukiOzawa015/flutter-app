import 'package:equatable/equatable.dart';
abstract class StoryEvent extends Equatable {}

class LoadStoryEvent extends StoryEvent {
  LoadStoryEvent();

  @override
  get props => [];
}
