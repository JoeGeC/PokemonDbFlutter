import 'package:dartz/dartz.dart';

import '../../models/Failure.dart';
import '../../models/pokedex.dart';

abstract class PokedexRepository {
  Future<Either<Failure, Pokedex>> getPokedex(int id);
}