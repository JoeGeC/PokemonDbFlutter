import 'package:domain/models/pokedex_model.dart';
import 'package:repository/models/local/pokedex_local.dart';

import '../../models/data/pokedex/pokedex_data_model.dart';

abstract class PokedexRepositoryConverter{
  PokedexModel convertToDomain(PokedexLocalModel pokedexLocal);
  PokedexLocalModel convertToLocal(PokedexDataModel pokedexData);
}