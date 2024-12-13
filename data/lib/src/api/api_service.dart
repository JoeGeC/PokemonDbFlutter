import 'package:data/src/constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  ApiService.singleton();

  static final ApiService instance = ApiService.singleton();
  static late Dio dio;

  static void initDio() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      contentType: contentType,
    ));
  }
}
