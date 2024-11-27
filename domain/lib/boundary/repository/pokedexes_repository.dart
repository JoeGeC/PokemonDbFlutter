import 'package:dartz/dartz.dart';

import '../../models/Failure.dart';
import '../../models/pokedex_model.dart';

abstract class PokedexesRepository {
  Stream<Either<Failure, List<PokedexModel>>> getAllPokedexes();
}