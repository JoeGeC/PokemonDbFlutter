import 'package:dartz/dartz.dart';
import '../../models/Failure.dart';
import '../../models/pokemon.dart';

abstract class PokedexRepository {
  Future<Either<Failure, List<Pokemon>>> getPokedex();
}