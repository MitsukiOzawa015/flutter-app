import 'dart:convert';

import 'package:html_unescape/html_unescape.dart';
import 'package:http/http.dart' as http;
import 'package:practice_app/gateway/story_model.dart';

class StoryUseCase{
  // final UserClien

  Future<StoryListResponse?> getStory() async {
    final url = "http://192.168.1.25:8000/story";
    // final runner = () =>
    http.Client client = http.Client();
    final http.Response response =
      await client.get(Uri.parse(url));

    final String jsonString = HtmlUnescape().convert(
        utf8.decode(response.bodyBytes).replaceAll(RegExp("&#34;"), "”"));

    final dynamic result = jsonDecode(jsonString);

    return StoryListResponse.fromJson(result);
  }
}