import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:repository/boundary/remote/pokedex_data.dart';
import 'package:repository/models/data/data_failure.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';

import '../api/api_response.dart';

class PokedexDataImpl implements PokedexData {
  final Dio dio;

  PokedexDataImpl(this.dio);

  @override
  Future<Either<DataFailure, PokedexDataModel>> get(int id) async {
    try {
      final result = (await dio.get("/pokedex/$id/"));
      if (result.data == null) {
        return Left(DataFailure("ServerError"));
      }
      var response = ApiResponse.fromJson<PokedexDataModel>(
          result.data, PokedexDataModel.fromJson);
      if(response.results == null){
        return Left(DataFailure("ParsingError"));
      }
      return Right(response.results!);
    } on DioException catch (e) {
      return Left(DataFailure(e.message ?? ""));
    }
  }
}
