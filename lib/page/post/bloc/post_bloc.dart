import 'package:bloc/bloc.dart';
import 'package:practice_app/entity/post.dart';
import 'package:practice_app/gateway/post_model.dart';
import 'package:practice_app/page/post/bloc/post_event.dart';
import 'package:practice_app/page/post/bloc/post_state.dart';
import 'package:practice_app/use_case/post_use_case.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostUseCase? postUseCase;

  PostBloc({required this.postUseCase}) : super(InitialPostState());

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is LoadPostEvent) {
      yield* _mapLoadingPost();
      yield* _mapLoadPost();
    } else if (event is ChangePostLikeEvent) {
      yield* _mapChangePostLike(event.postId);
    }
  }

  Stream<PostState> _mapLoadingPost() async* {
    yield PostLoading();
  }

  Stream<PostState> _mapLoadPost() async* {
    PostListResponse? postListResponse = await postUseCase?.getPost();
    var postResponseList2 = postListResponse?.postResponseList ?? [];
    yield PostLoaded(
        postList:
            postListResponse?.postResponseList?.map((e) =>
                Post(
                  postId: e.postId,
                  userName: e.userName,
                    icon: e.icon,
                    images :e.images,
                    text: e.text,
                    isLike:e.isLike
                )).toList(),);
  }

  Stream<PostState> _mapChangePostLike(String postId) async* {
    await postUseCase?.changePostList(postId);

    yield state;
  }
}
