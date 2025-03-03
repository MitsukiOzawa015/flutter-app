import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryContent extends StatefulWidget {
  const StoryContent({super.key, required this.imageList});

  final List<dynamic> imageList;

  @override
  State<StoryContent> createState() => _StoryContentState();
}

class _StoryContentState extends State<StoryContent> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => pageIndex == widget.imageList.length-1
            ? Navigator.pop(context)
            : setState(() {
                pageIndex++;
              }),
        child: Stack(children: [
          Expanded(
              child: Container(
            color: Colors.black,
          )),
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.scaleDown,
                      image: AssetImage(widget.imageList[pageIndex])))),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              // color: Colors.red,
              alignment: Alignment.topRight,
              padding: const EdgeInsets.all(20),
              child: const Text(
                "X",
                style: TextStyle(color: Colors.grey, fontSize: 40),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
