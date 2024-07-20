import 'package:dio/dio.dart';
import 'package:listing_app/constants/app_urls.dart';
import 'package:listing_app/utils/local_storage_utils.dart';

class PostRepo {
  final dio = Dio();

  Future<Response> getPosts() async => await dio.get(AppUrls.posts);

  Future<Response> getUserPosts() async {
    int userId = await LocalStorageUtils.getUserId();
    return await dio.get(AppUrls.userPosts(userId: userId));
  }

  Future<Response> getPostComment(int postId) async =>
    await dio.get(AppUrls.comments(postId: postId));
  

}