import 'package:dartz/dartz.dart';
import 'package:data/data/base_data.dart';
import 'package:repository/boundary/remote/pokedex_list_data.dart';
import 'package:repository/models/data/pokedex_list/pokedex_list_data_model.dart';
import 'package:repository/models/data_failure.dart';

class PokedexListDataImpl extends BaseData<PokedexListDataModel>
    implements PokedexListData {
  PokedexListDataImpl(super.dio);

  @override
  Future<Either<DataFailure, PokedexListDataModel>> getAll() =>
      fetch(
          endpoint: "/pokedex",
          queryParameters: {limitQuery: '9999'},
          fromJson: PokedexListDataModel.fromJson,
      );
}
