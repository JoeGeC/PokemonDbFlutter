import 'package:dartz/dartz.dart';
import 'package:repository/models/local/pokedex_local.dart';

import '../../models/data_failure.dart';

abstract class PokedexLocal{
  void store(PokedexLocalModel model);
  Future<Either<DataFailure, PokedexLocalModel>> get(int id);
}