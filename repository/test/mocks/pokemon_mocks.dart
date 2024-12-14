import 'package:domain/domain.dart';
import 'package:repository/src/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/src/models/data/pokemon/pokemon_data_model.dart';
import 'package:repository/src/models/local/pokemon_local_model.dart';

import 'stat_mocks.dart';

class PokemonRepoMocks {
  static final int pokedexId = 5;
  static final int pokemonId = 1;
  static final int pokemonEntryId = 2;
  static final String pokemonName = "Sample Pokemon";
  static final String pokemonTypeString1 = "grass";
  static final String pokemonTypeString2 = "poison";
  static final PokemonType pokemonType1 = PokemonType.grass;
  static final PokemonType pokemonType2 = PokemonType.poison;
  static final List<String> pokemonTypeStrings = [pokemonTypeString1, pokemonTypeString2];
  static final List<PokemonType> pokemonTypes = [pokemonType1, pokemonType2];
  static final String frontSpriteUrl = "https://sample/pokemon-sprite.png";
  static final String artworkUrl = "https://sample/pokemon-artwork.png";
  static final String pokemonUrl =
      "https://pokeapi.co/api/v2/pokemon-species/$pokemonId/";
  static final Map<int, int> pokedexEntryNumbers = {pokedexId: pokemonEntryId};

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
    types: pokemonTypeStrings,
    frontSpriteUrl: frontSpriteUrl,
  );

  static final PokemonLocalModel pokemonLocalModelNoEntryNumbers =
      PokemonLocalModel(
    id: pokemonId,
    name: pokemonName,
    types: pokemonTypeStrings,
    frontSpriteUrl: frontSpriteUrl,
    artworkUrl: artworkUrl,
    hp: StatRepoMocks.baseStatHp,
    attack: StatRepoMocks.baseStatAttack,
    defense: StatRepoMocks.baseStatDefense,
    specialAttack: StatRepoMocks.baseStatSpecialAttack,
    specialDefense: StatRepoMocks.baseStatSpecialDefense,
    speed: StatRepoMocks.baseStatSpeed,
    hpEvYield: StatRepoMocks.statEffortHp,
    attackEvYield: StatRepoMocks.statEffortAttack,
    defenseEvYield: StatRepoMocks.statEffortDefense,
    specialAttackEvYield: StatRepoMocks.statEffortSpecialAttack,
    specialDefenseEvYield: StatRepoMocks.statEffortSpecialDefense,
    speedEvYield: StatRepoMocks.statEffortSpeed,
  );

  static final PokemonLocalModel pokemonLocalModelWithEntryNumbers =
      PokemonLocalModel(
    id: pokemonId,
    name: pokemonName,
    types: pokemonTypeStrings,
    frontSpriteUrl: frontSpriteUrl,
    artworkUrl: artworkUrl,
    pokedexEntryNumbers: pokedexEntryNumbers,
    hp: StatRepoMocks.baseStatHp,
    attack: StatRepoMocks.baseStatAttack,
    defense: StatRepoMocks.baseStatDefense,
    specialAttack: StatRepoMocks.baseStatSpecialAttack,
    specialDefense: StatRepoMocks.baseStatSpecialDefense,
    speed: StatRepoMocks.baseStatSpeed,
    hpEvYield: StatRepoMocks.statEffortHp,
    attackEvYield: StatRepoMocks.statEffortAttack,
    defenseEvYield: StatRepoMocks.statEffortDefense,
    specialAttackEvYield: StatRepoMocks.statEffortSpecialAttack,
    specialDefenseEvYield: StatRepoMocks.statEffortSpecialDefense,
    speedEvYield: StatRepoMocks.statEffortSpeed,
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
    spriteUrl: frontSpriteUrl,
    artworkUrl: artworkUrl,
    hp: StatRepoMocks.baseStatHp,
    attack: StatRepoMocks.baseStatAttack,
    defense: StatRepoMocks.baseStatDefense,
    specialAttack: StatRepoMocks.baseStatSpecialAttack,
    specialDefense: StatRepoMocks.baseStatSpecialDefense,
    speed: StatRepoMocks.baseStatSpeed,
    hpEvYield: StatRepoMocks.statEffortHp,
    attackEvYield: StatRepoMocks.statEffortAttack,
    defenseEvYield: StatRepoMocks.statEffortDefense,
    specialAttackEvYield: StatRepoMocks.statEffortSpecialAttack,
    specialDefenseEvYield: StatRepoMocks.statEffortSpecialDefense,
    speedEvYield: StatRepoMocks.statEffortSpeed,
  );

  static final PokemonModel pokemonDomainModelUndetailed = PokemonModel(
    id: pokemonId,
    name: pokemonName,
    pokedexEntryNumbers: pokedexEntryNumbers,
  );

  static final PokemonModel pokemonDomainModelPokedexDetail = PokemonModel(
    id: pokemonId,
    name: pokemonName,
    pokedexEntryNumbers: pokedexEntryNumbers,
    spriteUrl: frontSpriteUrl,
    types: pokemonTypes,
  );

  static final PokemonDataModel pokemonDataModel = PokemonDataModel(
    id: pokemonId,
    name: pokemonName,
    types: pokemonTypeStrings,
    frontSpriteUrl: frontSpriteUrl,
    artworkUrl: artworkUrl,
    stats: StatRepoMocks.pokemonStats,
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
    types: [pokemonTypeString1],
    frontSpriteUrl: frontSpriteUrl,
    artworkUrl: artworkUrl,
    stats: StatRepoMocks.pokemonStats,
  );

  static final PokemonDataModel nullNamePokemonDataModel = PokemonDataModel(
    id: pokemonId,
    name: null,
    types: [pokemonTypeString1],
    frontSpriteUrl: frontSpriteUrl,
    artworkUrl: artworkUrl,
    stats: StatRepoMocks.pokemonStats,
  );

  static final List<PokemonModel> pokemonPokedexDetailDomainList = [
    pokemonDomainModelPokedexDetail
  ];

  static final List<PokemonLocalModel> detailedPokedexPokemonLocalList = [
    detailedPokedexPokemonLocalModel
  ];

  static final List<PokemonLocalModel> undetailedPokedexPokemonLocalList = [
    undetailedPokedexPokemonLocalModel
  ];
}
