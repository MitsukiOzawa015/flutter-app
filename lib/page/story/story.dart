import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/page/story/bloc/story_event.dart';
import 'package:practice_app/page/story/bloc/story_state.dart';
import 'package:practice_app/page/story/story_content.dart';

import 'bloc/story_bloc.dart';

class Story extends StatefulWidget {
  const Story({super.key});

  @override
  State<Story> createState() => _StoryState();
}

class _StoryState extends State<Story> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<StoryBloc>(context).add(LoadStoryEvent());
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<StoryBloc, StoryState>(
      builder: (context, storyState) {
        if (storyState is StoryLoaded) {
          var storyList = storyState.storyList ?? [];
        return Container(
          height: 100,
          child: ListView.builder(
            itemCount: storyList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(child: story(
                  storyList[index].icon ?? "", storyList[index].userName ?? "",
                  storyList[index].stories ?? []), onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => StoryContent(imageList: storyList[index].stories ?? []))),);
            },
          ),
        );} else {return Container();}
      }
    );
  }

  Widget story(String image, String userName, List<dynamic> stories) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                    border: stories.isNotEmpty ? Border.all(
                        color: Colors.red, width: 3.0) : null,
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.fill, image: AssetImage(image)))),
            Text(userName),
          ],
        ),
        const SizedBox(
          width: 10,
        )
      ],
    );
  }
}
