import 'package:dartz/dartz.dart';
import 'package:repository/boundary/remote/pokedex_data.dart';
import 'package:repository/models/data_failure.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';

import 'base_data.dart';

class PokedexDataImpl extends BaseData<PokedexDataModel>
    implements PokedexData {
  PokedexDataImpl(super.dio);

  @override
  Future<Either<DataFailure, PokedexDataModel>> get(int id) =>
      fetch("/pokedex/$id/", PokedexDataModel.fromJson);

  @override
  Future<Either<DataFailure, List<PokedexDataModel>>> getALl() {
    // TODO: implement getALl
    throw UnimplementedError();
  }
}
