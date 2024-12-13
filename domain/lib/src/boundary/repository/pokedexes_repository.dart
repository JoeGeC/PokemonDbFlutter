import 'package:dartz/dartz.dart';

import 'package:domain/src/models/failure.dart';
import 'package:domain/src/models/pokedex_model.dart';

abstract class PokedexListRepository {
  Stream<Either<Failure, List<PokedexModel>>> getAllPokedexes();
}