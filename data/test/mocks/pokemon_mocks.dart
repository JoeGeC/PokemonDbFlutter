import 'package:repository/src/models/data/pokemon/pokemon_data_model.dart';
import 'package:repository/src/models/data/stat/pokemon_stat_data_model.dart';

class PokemonDataMocks {
  static final int pokemonId = 1;
  static final String pokemonName = "Sample Pokemon";
  static final String pokemonType1 = "Grass";
  static final String pokemonType2 = "Poison";
  static final List<String> pokemonTypes = [pokemonType1, pokemonType2];
  static final String frontSpriteUrl = "https://sample/pokemon-sprite.png";
  static final String artworkUrl = "https://sample/pokemon-artwork.png";
  static final int baseStat1 = 45;
  static final int statEffort1 = 1;
  static final String statName1 = "hp";
  static final String statUrl1 = "https://pokeapi.co/api/v2/stat/1/";
  static final int baseStat2 = 49;
  static final int statEffort2 = 0;
  static final String statName2 = "attack";
  static final String statUrl2 = "https://pokeapi.co/api/v2/stat/2/";

  static final PokemonStatDataModel stat1 =
      PokemonStatDataModel(baseStat1, statEffort1, statName1, statUrl1);
  static final PokemonStatDataModel stat2 =
      PokemonStatDataModel(baseStat2, statEffort2, statName2, statUrl2);
  static final List<PokemonStatDataModel> pokemonStats = [stat1, stat2];

  static final PokemonDataModel pokemonDataModel = PokemonDataModel(
    id: pokemonId,
    name: pokemonName,
    types: pokemonTypes,
    frontSpriteUrl: frontSpriteUrl,
    stats: pokemonStats,
    artworkUrl: artworkUrl,
  );

  static Map<String, dynamic> pokemonJson = {
    "id": pokemonId,
    "species": {
      "name": pokemonName,
    },
    "sprites": {
      "front_default": frontSpriteUrl,
      "other": {
        "official-artwork": {
          "front_default": artworkUrl,
          "front_shiny": "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/132.png"
        },
      },
    },
    "stats": [
      {
        "base_stat": baseStat1,
        "effort": statEffort1,
        "stat": {"name": statName1, "url": statUrl1}
      },
      {
        "base_stat": baseStat2,
        "effort": statEffort2,
        "stat": {"name": statName2, "url": statUrl2}
      },
    ],
    "types": [
      {
        "slot": 1,
        "type": {"name": pokemonType1, "url": ""}
      },
      {
        "slot": 2,
        "type": {"name": pokemonType2, "url": ""}
      },
    ],
  };
}
