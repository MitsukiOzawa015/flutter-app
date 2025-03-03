import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practice_app/page/post/bloc/post_bloc.dart';
import 'package:practice_app/page/post/bloc/post_event.dart';

class PostLike extends StatefulWidget {
  // const PostLike({Key? key}) : super(key: key);
  final bool? isLike;
  final String? postId;
  const PostLike({super.key, this.isLike, this.postId});

  @override
  State<PostLike> createState() => _PostLikeState();
}

class _PostLikeState extends State<PostLike> {
  bool isLike = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLike = widget.isLike ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: ()=> {
      setState(() {
        BlocProvider.of<PostBloc>(context).add(ChangePostLikeEvent(widget.postId!));
        isLike = !isLike;
      })
    },child: isLike ? Icon(Icons.favorite, color: Colors.pink,) : Icon(Icons.favorite_border),) ;
  }
}
