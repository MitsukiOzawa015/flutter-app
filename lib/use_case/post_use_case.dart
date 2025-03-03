import 'dart:convert';

import 'package:html_unescape/html_unescape.dart';
import 'package:practice_app/gateway/post_model.dart';
import 'package:http/http.dart' as http;

class PostUseCase{
  // final UserClien

  Future<PostListResponse?> getPost() async {
    final url = "http://192.168.1.25:8000/post";
    // final runner = () =>
    http.Client client = http.Client();
    final http.Response response =
      await client.get(Uri.parse(url));

    final String jsonString = HtmlUnescape().convert(
        utf8.decode(response.bodyBytes).replaceAll(RegExp("&#34;"), "”"));

    final dynamic result = jsonDecode(jsonString);

    return PostListResponse.fromJson(result);
  }

  Future<void> changePostList(String postId) async {
    final url = "http://192.168.1.25:8000/post";
    // final runner = () =>
    http.Client client = http.Client();
    final http.Response response =
    await client.post(Uri.parse(url),body: {"postId": postId}, );

  }
}