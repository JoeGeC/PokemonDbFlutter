import 'package:repository/models/local/pokemon_local_model.dart';

import '../database_constants.dart';

class PokemonLocalConverter{
  Map<String, dynamic> toMap(PokemonLocalModel pokemon) => {
    DatabaseConstants.columnId: pokemon.id,
    DatabaseConstants.columnName: pokemon.name,
    DatabaseConstants.columnTypes: pokemon.types?.join(','),
    DatabaseConstants.columnFrontSpriteUrl: pokemon.frontSpriteUrl,
  };

}