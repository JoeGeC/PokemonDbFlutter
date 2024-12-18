import 'package:domain/domain.dart';
import 'package:repository/src/models/local/pokedex_local_model.dart';

import '../../models/data/pokedex/pokedex_data_model.dart';
import '../../models/data/pokedex_list/pokedex_list_data_model.dart';

abstract class PokedexRepositoryConverter{
  PokedexModel convertToDomain(PokedexLocalModel pokedexLocal);
  List<PokedexModel> convertListToDomain(List<PokedexLocalModel> pokedexLocalList);
  PokedexLocalModel convertToLocal(PokedexDataModel pokedexData);
  List<PokedexLocalModel> convertListToLocal(PokedexListDataModel pokedexDataList);
}