import 'package:equatable/equatable.dart';
abstract class PostEvent extends Equatable {}

class LoadPostEvent extends PostEvent {
  LoadPostEvent();

  @override
  get props => [];
}

class ChangePostLikeEvent extends PostEvent {
  String postId;
  ChangePostLikeEvent(this.postId);

  @override
  get props => [postId];
}
