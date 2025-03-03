import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

@immutable
class Story extends Equatable {
  const Story({
    required this.icon,
    required this.userName,
    required this.stories,
});
  final String? userName;
  final String? icon;
  final List<String>? stories;

  @override
  List<Object?> get props => [
    userName,
    icon,
    stories,
  ];
}