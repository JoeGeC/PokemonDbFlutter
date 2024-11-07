import 'package:dartz/dartz.dart';

import '../../models/Failure.dart';
import '../../models/pokedex_model.dart';

abstract class PokedexRepository {
  Future<Either<Failure, PokedexModel>> getPokedex(int id);
}