import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:practice_app/entity/post.dart';

class PostListResponse {
  List<PostResponse>? postResponseList;

  PostListResponse(this.postResponseList);
  PostListResponse.fromJson(Map<String, dynamic> json) {
    postResponseList = [];
    json["postList"].forEach((element) {
      postResponseList?.add(PostResponse.fromJson(element));
    });
  }
}

class PostResponse extends Equatable {

  final String? postId;
  final String? userName;
  final String? icon;
  final List<String>? images;
  final String? text;
  final bool? isLike;

  PostResponse({
    this.postId,
    this.userName,
    this.icon,
    this.images,
    this.text,
    this.isLike
});

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      postId: json["postId"],
      userName: json["userName"],
      icon: json["icon"],
      images: json["images"].cast<String>() ?? [],
      text: json["text"],
      isLike: json["isLike"]
    );
  }

  @override
  List<Object?> get props => [
    this.postId,
    this.userName,
    this.icon,
    this.images,
    this.text,
    this.isLike
  ];

  @override
  String toString() => props.toString();
}