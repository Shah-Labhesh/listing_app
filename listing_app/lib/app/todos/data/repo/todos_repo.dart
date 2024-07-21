import 'package:dio/dio.dart';
import 'package:listing_app/constants/app_urls.dart';

class TodosRepo {
  final dio = Dio();

  Future<Response> getTodos() async => await dio.get(AppUrls.todos);
}
