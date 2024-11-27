import 'package:dartz/dartz.dart';
import 'package:repository/models/local/pokedex_local_model.dart';

import '../../models/data_failure.dart';

abstract class PokedexLocal{
  void store(PokedexLocalModel model);
  Future<void> storeList(List<PokedexLocalModel> models);
  Future<Either<DataFailure, PokedexLocalModel>> get(int id);
  Future<Either<DataFailure, List<PokedexLocalModel>>> getAll();
}