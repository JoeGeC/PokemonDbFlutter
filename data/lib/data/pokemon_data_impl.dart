import 'package:dartz/dartz.dart';
import 'package:repository/repository.dart';

import 'base_data.dart';

class PokemonDataImpl extends BaseData<PokemonDataModel>
    implements PokemonData {
  PokemonDataImpl(super.dio);

  @override
  Future<Either<DataFailure, PokemonDataModel>> get(int id) =>
      fetch(endpoint: "/pokemon/$id/", fromJson: PokemonDataModel.fromJson);
}
