import 'package:dio/dio.dart';
import 'package:listing_app/constants/app_urls.dart';
import 'package:listing_app/utils/local_storage_utils.dart';

class TodosRepo {
  final dio = Dio();

  Future<Response> getTodos() async {
    int userId = await LocalStorageUtils.getUserId();
    return await dio.get(AppUrls.userTodos(userId: userId));
  }
}
