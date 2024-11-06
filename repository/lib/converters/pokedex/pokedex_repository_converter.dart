import 'package:domain/models/pokedex.dart';
import 'package:repository/models/local/pokedex_local.dart';

import '../../models/data/pokedex_data.dart';

abstract class PokedexRepositoryConverter{
  Pokedex convertToDomain(PokedexLocalModel pokedexLocal);
  PokedexLocalModel convertToLocal(PokedexDataModel pokedexData);
}