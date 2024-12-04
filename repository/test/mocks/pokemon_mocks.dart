import 'package:domain/models/pokemon_model.dart';
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/models/data/pokemon/pokemon_data_model.dart';
import 'package:repository/models/data/stat/pokemon_stat_data_model.dart';
import 'package:repository/models/local/pokemon_local_model.dart';

class PokemonRepoMocks {
  static final int pokedexId = 5;
  static final int pokemonId = 1;
  static final int pokemonEntryId = 2;
  static final String pokemonName = "Sample Pokemon";
  static final String pokemonType1 = "Grass";
  static final String pokemonType2 = "Poison";
  static final List<String> pokemonTypes = [pokemonType1, pokemonType2];
  static final String frontSpriteUrl = "https://sample/pokemon.png";
  static final String pokemonUrl =
      "https://pokeapi.co/api/v2/pokemon-species/$pokemonId/";
  static final Map<int, int> pokedexEntryNumbers = {pokedexId: pokemonEntryId};

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

  static final PokemonLocalModel undetailedPokedexPokemonLocalModel =
      PokemonLocalModel(
    id: pokemonId,
    pokedexEntryNumbers: {pokedexId: pokemonEntryId},
    name: pokemonName,
  );

  static final PokemonLocalModel detailedPokedexPokemonLocalModel =
      PokemonLocalModel(
    id: pokemonId,
    pokedexEntryNumbers: {pokedexId: pokemonEntryId},
    name: pokemonName,
    types: pokemonTypes,
    frontSpriteUrl: frontSpriteUrl,
  );

  static final PokemonLocalModel pokemonLocalModelNoEntryNumbers =
      PokemonLocalModel(
    id: pokemonId,
    name: pokemonName,
    types: pokemonTypes,
    frontSpriteUrl: frontSpriteUrl,
  );

  static final PokemonLocalModel pokemonLocalModelWithEntryNumbers =
      PokemonLocalModel(
    id: pokemonId,
    name: pokemonName,
    types: pokemonTypes,
    frontSpriteUrl: frontSpriteUrl,
    pokedexEntryNumbers: pokedexEntryNumbers,
  );

  static final PokemonLocalModel pokemonLocalModelUndetailed =
      PokemonLocalModel(
    id: pokemonId,
    name: pokemonName,
    pokedexEntryNumbers: pokedexEntryNumbers,
  );

  static final PokemonModel pokemonDomainModel = PokemonModel(
    id: pokemonId,
    name: pokemonName,
    pokedexEntryNumbers: pokedexEntryNumbers,
    types: pokemonTypes,
    imageUrl: frontSpriteUrl,
  );

  static final PokemonModel pokemonDomainModelUndetailed = PokemonModel(
    id: pokemonId,
    name: pokemonName,
    pokedexEntryNumbers: pokedexEntryNumbers,
  );

  static final PokemonDataModel pokemonDataModel = PokemonDataModel(
    id: pokemonId,
    name: pokemonName,
    types: pokemonTypes,
    frontSpriteUrl: frontSpriteUrl,
    stats: pokemonStats,
  );

  static final PokedexPokemonDataModel pokedexPokemonDataModel =
      PokedexPokemonDataModel(
    pokemonEntryId,
    pokemonName,
    pokemonUrl,
  );

  static final PokedexPokemonDataModel pokedexPokemonNullIdModel =
      PokedexPokemonDataModel(
    null,
    pokemonName,
    pokemonUrl,
  );

  static final List<PokedexPokemonDataModel> dataPokemonList = [
    pokedexPokemonDataModel
  ];

  static final PokemonDataModel nullIdPokemonDataModel = PokemonDataModel(
    id: null,
    name: pokemonName,
    types: [pokemonType1],
    frontSpriteUrl: frontSpriteUrl,
    stats: pokemonStats,
  );

  static final PokemonDataModel nullNamePokemonDataModel = PokemonDataModel(
    id: pokemonId,
    name: null,
    types: [pokemonType1],
    frontSpriteUrl: frontSpriteUrl,
    stats: pokemonStats,
  );

  static final List<PokemonModel> pokemonDomainList = [pokemonDomainModel];

  static final List<PokemonLocalModel> detailedPokedexPokemonLocalList = [
    detailedPokedexPokemonLocalModel
  ];

  static final List<PokemonLocalModel> undetailedPokedexPokemonLocalList = [
    undetailedPokedexPokemonLocalModel
  ];
}
