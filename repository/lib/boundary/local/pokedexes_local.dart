import 'package:dartz/dartz.dart';

import '../../models/data_failure.dart';
import '../../models/local/pokedex_local_model.dart';

abstract class PokedexesLocal{
  Future<void> store(List<PokedexLocalModel> models);
  Future<Either<DataFailure, List<PokedexLocalModel>>> getAll();
}