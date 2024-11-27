import 'package:dartz/dartz.dart';

import '../boundary/repository/pokedexes_repository.dart';
import '../models/Failure.dart';
import '../models/pokedex_model.dart';

class PokedexesUseCase {
  final PokedexListRepository _repository;

  PokedexesUseCase(this._repository);

  Stream<Either<Failure, List<PokedexModel>>> getAllPokedexes()  {
    return _repository.getAllPokedexes();
  }
}