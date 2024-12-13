import 'package:dartz/dartz.dart';

import 'package:domain/src/models/failure.dart';
import 'package:domain/src/models/pokemon_model.dart';

abstract class PokemonRepository {
  Future<Either<Failure, PokemonModel>> getPokemon(int id);
}
