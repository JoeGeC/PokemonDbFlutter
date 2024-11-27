import 'package:dartz/dartz.dart';

import '../../models/data/pokedex_list/pokedex_list_data_model.dart';
import '../../models/data_failure.dart';

abstract class PokedexListData{
  Future<Either<DataFailure, PokedexListDataModel>> getAll();
}