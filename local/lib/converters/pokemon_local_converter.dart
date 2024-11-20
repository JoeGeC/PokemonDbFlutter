import 'package:repository/models/local/pokemon_local_model.dart';

import '../database_constants.dart';

class PokemonLocalConverter{
  Map<String, dynamic> convert(PokemonLocalModel pokemon) => {
    DatabaseColumnNames.id: pokemon.id,
    DatabaseColumnNames.name: pokemon.name,
    DatabaseColumnNames.types: pokemon.types?.join(','),
    DatabaseColumnNames.frontSpriteUrl: pokemon.frontSpriteUrl,
  };

}