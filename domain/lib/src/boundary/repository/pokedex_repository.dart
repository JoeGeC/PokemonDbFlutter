import 'package:dartz/dartz.dart';
import 'package:domain/src/models/failure.dart';
import 'package:domain/src/models/pokedex_model.dart';

abstract class PokedexRepository {
  Future<Either<Failure, PokedexModel>> getPokedex(int id);
}