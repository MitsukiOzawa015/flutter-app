import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/page/post/bloc/post_bloc.dart';
import 'package:practice_app/page/post/bloc/post_event.dart';
import 'package:practice_app/page/post/bloc/post_state.dart';
import 'package:practice_app/page/post/post_images.dart';
import 'package:practice_app/page/post/post_like.dart';

class Post extends StatefulWidget {
  const Post({Key? key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  // List<Post> postList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<PostBloc>(context).add(LoadPostEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
        builder: (context, postState) {
          if (postState is PostLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              ),
            );
          } else if (postState is PostLoaded) {
            var postList = postState.postList ?? [];
            return ListView.builder(
              itemCount: postList.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    GestureDetector(
                        child: Row(
                          children: [
                            Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(
                                            postList[index].icon ?? "")))),
                            Text(postList[index].userName ?? "")
                          ],
                        )),
                    PostImages(imageList: postList[index].images ?? []),
                    // GestureDetector(
                    //   child: Container(
                    //       alignment: Alignment.centerLeft,
                    //       child: Text(
                    //         postList[index].isLike! ? "Like" : "Not Like",
                    //       )),
                    //   onTap: () =>
                    //   {
                    //     // postList[index].isLike = !postList[index]["isLike"],
                    //     setState(() {})
                    //   },
                    // ),
                    Container(alignment: Alignment.topLeft,child: PostLike(isLike: postList[index].isLike, postId: postList[index].postId,)),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          postList[index].text!,
                        )),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                );
              },
            );
          } else {
            return Container(child: Text("failed"),);
          }
        }
    );
  }
}
