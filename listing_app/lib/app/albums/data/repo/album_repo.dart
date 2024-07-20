import 'package:dio/dio.dart';
import 'package:listing_app/constants/app_urls.dart';
import 'package:listing_app/utils/local_storage_utils.dart';

class AlbumRepo {
  final dio = Dio();

  Future<Response> fetchAlbums() async {
    int userId = await LocalStorageUtils.getUserId();
    return await dio.get(AppUrls.userAlbums(userId: userId));
  }

  Future<Response> fetchAlbumPhotos(int albumId) async =>
      await dio.get(AppUrls.albumPhotos(albumId: albumId));
}
