import 'package:dartz/dartz.dart';

import '../../models/Failure.dart';
import '../../models/pokemon_model.dart';

abstract class PokemonRepository {
  Future<Either<Failure, PokemonModel>> getPokemon(int id);
}