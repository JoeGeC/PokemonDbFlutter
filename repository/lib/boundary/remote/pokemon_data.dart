import 'package:dartz/dartz.dart';

import '../../models/data/pokemon/pokemon_data_model.dart';
import '../../models/data_failure.dart';

abstract class PokemonData{
  Future<Either<DataFailure, PokemonDataModel>> get(int id);
}