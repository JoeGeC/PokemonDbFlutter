import 'package:dartz/dartz.dart';

import '../boundary/repository/pokedexes_repository.dart';
import '../models/Failure.dart';
import '../models/pokedexes_model.dart';

class PokedexesUseCase {
  final PokedexesRepository _repository;

  PokedexesUseCase(this._repository);

  Future<Either<Failure, PokedexesModel>> getPokedexes(int id) async =>
      await _repository.getPokedexes();
}
