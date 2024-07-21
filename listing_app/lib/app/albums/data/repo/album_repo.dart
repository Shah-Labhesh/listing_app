import 'package:dio/dio.dart';
import 'package:listing_app/constants/app_urls.dart';

class AlbumRepo {
  final dio = Dio();

  Future<Response> fetchAlbums() async => await dio.get(AppUrls.albums);

  Future<Response> fetchAlbumPhotos() async => await dio.get(AppUrls.photos);
}
