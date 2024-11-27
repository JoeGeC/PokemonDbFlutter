import 'package:domain/models/pokedex_model.dart';
import 'package:repository/models/local/pokedex_local_model.dart';

import '../../models/data/pokedex/pokedex_data_model.dart';

abstract class PokedexRepositoryConverter{
  PokedexModel convertToDomain(PokedexLocalModel pokedexLocal);
  List<PokedexModel> convertListToDomain(List<PokedexLocalModel> pokedexLocalList);
  PokedexLocalModel convertToLocal(PokedexDataModel pokedexData);
  List<PokedexLocalModel> convertListToLocal(List<PokedexDataModel> pokedexDataList);
}