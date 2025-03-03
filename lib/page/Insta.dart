import 'package:flutter/material.dart';
import 'package:practice_app/page/post/post.dart';
import 'package:practice_app/page/story/story.dart';

class Insta extends StatelessWidget {
  const Insta({Key? key});

  @override
  Widget build(BuildContext context) {
    // final list = [Story(), Post()];
    return Scaffold(
        appBar: AppBar(title: const Text("Insta"), automaticallyImplyLeading: false),
        // body: ListView.builder(
        //   shrinkWrap: true,
        //   physics: const NeverScrollableScrollPhysics(),
        //   itemBuilder: (_, index) => list[index],
        //   itemCount: 2,
        // ));
        body: const SingleChildScrollView(
          child: Column(
            children: [Story(), Post()],
          ),
        )
      // body: Post(),
    );
  }
}
