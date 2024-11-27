import 'package:dartz/dartz.dart';
import 'package:repository/boundary/remote/pokemon_data.dart';
import 'package:repository/models/data/pokemon/pokemon_data_model.dart';
import 'package:repository/models/data_failure.dart';

import 'base_data.dart';

class PokemonDataImpl extends BaseData<PokemonDataModel>
    implements PokemonData {
  PokemonDataImpl(super.dio);

  @override
  Future<Either<DataFailure, PokemonDataModel>> get(int id) =>
      fetch(endpoint: "/pokemon/$id/", fromJson: PokemonDataModel.fromJson);
}
