import 'package:dartz/dartz.dart';
import 'package:repository/repository.dart';

import 'base_data.dart';

class PokedexDataImpl extends BaseData<PokedexDataModel>
    implements PokedexData {
  PokedexDataImpl(super.dio);

  @override
  Future<Either<DataFailure, PokedexDataModel>> get(int id) =>
      fetch(endpoint: "/pokedex/$id/", fromJson: PokedexDataModel.fromJson);
}
