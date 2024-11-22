import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:repository/boundary/remote/pokemon_data.dart';
import 'package:repository/models/data/pokemon/pokemon_data_model.dart';
import 'package:repository/models/data_failure.dart';

import '../api/api_response.dart';

class PokemonDataImpl implements PokemonData {
  final Dio dio;

  PokemonDataImpl(this.dio);

  @override
  Future<Either<DataFailure, PokemonDataModel>> get(int id) async {
    try {
      final result = (await dio.get("/pokemon/$id/"));
    if (result.data == null) {
    return Left(DataFailure("ServerError"));
    }
    var response = ApiResponse.fromJson<PokemonDataModel>(
    result.data, PokemonDataModel.fromJson);
    if(response.results == null){
    return Left(DataFailure("ParsingError"));
    }
    return Right(response.results!);
    } on DioException catch (e) {
    return Left(DataFailure(e.message ?? ""));
    }
  }

}