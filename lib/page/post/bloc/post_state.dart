import 'package:equatable/equatable.dart';
import 'package:practice_app/entity/post.dart';

abstract class PostState extends Equatable {
  const PostState({this.postList});

  final List<Post>? postList;
}

class InitialPostState extends PostState {
  @override
  get props => [];
}

class PostLoading extends PostState {
  @override
  get props => [];
}

class PostLoaded extends PostState {
   PostLoaded({
    List<Post>? postList
}) : super(postList: postList);

  @override
  List<Object?> get props => [postList];
}