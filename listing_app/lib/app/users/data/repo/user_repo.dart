import 'package:dio/dio.dart';
import 'package:listing_app/constants/app_urls.dart';

class UserRepo{

  final dio = Dio();

  Future<Response> getUsers() async => await dio.get(AppUrls.users);
}