import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';

import '../boundary/repository/pokemon_repository.dart';
import '../models/pokemon_model.dart';

class PokemonUseCase {
  final PokemonRepository _repository;

  PokemonUseCase(this._repository);

  Future<Either<Failure, PokemonModel>> getPokemon(int id) async =>
      await _repository.getPokemon(id);
}
