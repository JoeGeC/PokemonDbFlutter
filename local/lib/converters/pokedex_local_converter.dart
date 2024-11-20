import 'package:repository/models/local/pokedex_local_model.dart';

import '../database_constants.dart';

class PokedexLocalConverter{
  Map<String, dynamic> convert(PokedexLocalModel pokedex) => {
    DatabaseColumnNames.id: pokedex.id,
    DatabaseColumnNames.name: pokedex.name,
  };
}