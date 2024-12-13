import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:repository/repository.dart';

import '../api/api_response.dart';

abstract class BaseData<T> {
  final Dio dio;
  final String limitQuery = "limit";

  BaseData(this.dio);

  Future<Either<DataFailure, T>> fetch({
    required String endpoint,
    Map<String, String>? queryParameters,
    required T Function(Map<String, dynamic>) fromJson,
  }) async {
    try {
      final response = await dio.get(
          endpoint,
          queryParameters: queryParameters
      );
      final data = response.data;

      if (data == null) {
        return Left(DataFailure("ServerError"));
      }

      final apiResponse = ApiResponse.fromJson<T>(data, fromJson);

      if (apiResponse.results == null) {
        return Left(DataFailure("ParsingError"));
      }

      return Right(apiResponse.results as T);
    } on DioException catch (e) {
      return Left(DataFailure(e.message ?? "Unknown error"));
    }
  }

}
