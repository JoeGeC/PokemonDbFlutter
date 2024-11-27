import 'package:dartz/dartz.dart';

import '../../models/data_failure.dart';
import '../../models/data/pokedex/pokedex_data_model.dart';

abstract class PokedexData{
  Future<Either<DataFailure, PokedexDataModel>> get(int id);
  Future<Either<DataFailure, List<PokedexDataModel>>> getALl();
}