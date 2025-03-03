import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Post extends Equatable {
  const Post({
    required this.postId,
    required this.userName,
    required this.icon,
    required this.images,
    required this.text,
    required this.isLike
});
  final String? postId;
  final String? userName;
  final String? icon;
  final List<String>? images;
  final String? text;
  final bool? isLike;

  @override
  List<Object?> get props => [
    postId,
    userName,
    icon,
    images,
    text,
    isLike
  ];
}