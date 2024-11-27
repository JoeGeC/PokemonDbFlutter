import 'package:dartz/dartz.dart';

import '../../models/Failure.dart';
import '../../models/pokedexes_model.dart';

abstract class PokedexesRepository {
  Future<Either<Failure, PokedexesModel>> getPokedexes();
}