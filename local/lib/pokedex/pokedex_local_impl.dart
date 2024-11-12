import 'package:dartz/dartz.dart';
import 'package:repository/boundary/local/pokedex_local.dart';
import 'package:repository/models/local/pokedex_local_model.dart';
import 'package:repository/models/data_failure.dart';

class PokedexLocalImpl implements PokedexLocal{
  @override
  Future<Either<DataFailure, PokedexLocalModel>> get(int id) async {
    return Left(DataFailure(""));
  }

  @override
  void store(PokedexLocalModel model) {
  }

}