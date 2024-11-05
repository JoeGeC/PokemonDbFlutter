import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import '../../models/pokedex_data.dart';

abstract class PokedexApi{
  Future<Either<Failure, PokedexData>> getPokedex(int id);
}