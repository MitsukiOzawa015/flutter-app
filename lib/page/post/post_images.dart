import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

class PostImages extends StatefulWidget {
  final List<String> imageList;

  const PostImages({super.key, required this.imageList});

  @override
  State<PostImages> createState() => _State();
}

class _State extends State<PostImages> {
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: widget.imageList?.length ?? 0,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) =>
              Image.asset(widget.imageList[itemIndex]),
          options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: false,
              onPageChanged: (index, carouselPageChangedReason) =>
              {
                pageIndex = index,
                setState(() {})
              }),
        ),
        DotsIndicator(dotsCount: widget.imageList?.length ?? 0, position: pageIndex.toDouble())
      ],
    );
    // ListView.builder(itemBuilder: (index)),
  }
}
