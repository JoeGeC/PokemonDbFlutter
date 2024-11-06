import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import 'package:repository/models/local/pokedex_local.dart';

abstract class PokedexLocal{
  void store(PokedexLocalModel model);
  Future<Either<Failure, PokedexLocalModel>> get(int id);
}