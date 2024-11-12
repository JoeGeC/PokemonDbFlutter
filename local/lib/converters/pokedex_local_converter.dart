import 'package:repository/models/local/pokedex_local_model.dart';

import '../database_constants.dart';

class PokedexLocalConverter{
  Map<String, dynamic> toMap(PokedexLocalModel pokedex) => {
    DatabaseConstants.columnId: pokedex.id,
    DatabaseConstants.columnName: pokedex.name,
  };
}