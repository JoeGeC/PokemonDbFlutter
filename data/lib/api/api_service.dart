import 'package:data/constants.dart';
import 'package:dio/dio.dart';

class ApiService {
  ApiService.singleton();

  static final ApiService instance = ApiService.singleton();
  late Dio dio;

  void initDio() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      contentType: contentType,
    ));
  }
}
