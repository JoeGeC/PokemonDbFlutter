import 'package:dartz/dartz.dart';
import 'package:domain/src/models/failure.dart';

import '../boundary/repository/pokedex_repository.dart';
import '../models/pokedex_model.dart';

class PokedexUseCase {
  final PokedexRepository _repository;

  PokedexUseCase(this._repository);

  Future<Either<Failure, PokedexModel>> getPokedex(int id) async =>
      await _repository.getPokedex(id);
}
