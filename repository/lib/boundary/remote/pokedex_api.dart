import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import '../../models/data/pokedex_data.dart';

abstract class PokedexApi{
  Future<Either<Failure, PokedexDataModel>> get(int id);
}