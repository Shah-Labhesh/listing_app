import 'package:dio/dio.dart';
import 'package:listing_app/app/posts/data/model/comment.dart';
import 'package:listing_app/constants/app_urls.dart';

class PostRepo {
  final dio = Dio();

  Future<Response> getPosts() async => await dio.get(AppUrls.posts);

  Future<Response> getPostComment() async => await dio.get(AppUrls.comments);

  Future<Response> addComment(int postId, Comment comment) async =>
      await dio.post(
        AppUrls.addComments(postId: postId),
        data: {
          'postId': postId,
          'name': comment.name,
          'body': comment.body,
          'email': 'test@example.com'
        },
      );
}
