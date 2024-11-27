import 'package:dartz/dartz.dart';

import '../../models/data/pokedex/pokedex_data_model.dart';
import '../../models/data_failure.dart';

abstract class PokedexesData{
  Future<Either<DataFailure, List<PokedexDataModel>>> getALl();
}