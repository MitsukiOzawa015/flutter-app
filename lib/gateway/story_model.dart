import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:practice_app/entity/story.dart';

class StoryListResponse {
  List<StoryResponse>? storyResponseList;

  StoryListResponse(this.storyResponseList);
  StoryListResponse.fromJson(Map<String, dynamic> json) {
    storyResponseList = [];
    json["storyList"].forEach((element) {
      storyResponseList?.add(StoryResponse.fromJson(element));
    });
  }
}

class StoryResponse extends Equatable {

  final String? icon;
  final String? userName;
  final List<String>? stories;

  StoryResponse({
    this.icon,
    this.userName,
    this.stories,
});

  factory StoryResponse.fromJson(Map<String, dynamic> json) {
    return StoryResponse(
      icon: json["icon"],
      userName: json["userName"],
      stories: json["stories"].cast<String>() ?? [],
    );
  }

  @override
  List<Object?> get props => [
    this.icon,
    this.userName,
    this.stories,
  ];

  @override
  String toString() => props.toString();
}