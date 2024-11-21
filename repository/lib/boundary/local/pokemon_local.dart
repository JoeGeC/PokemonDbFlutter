import 'package:dartz/dartz.dart';

import '../../models/data_failure.dart';
import '../../models/local/pokemon_local_model.dart';

abstract class PokemonLocal{
  void store(PokemonLocalModel model);
  Future<Either<DataFailure, PokemonLocalModel>> get(int id);
}