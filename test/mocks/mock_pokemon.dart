import 'package:local/database_constants.dart';
import 'package:repository/models/local/pokemon_local_model.dart';
import 'mock_pokedex.dart';

class MockLocalPokemon {
  static const int pokemonId = 101;
  static const int pokemonId2 = 102;
  static const String pokemonName = "Sample Pokemon";
  static const String pokemonName2 = "Sample Pokemon 2";
  static const String pokemonType1 = "grass";
  static const String pokemonType2 = "poison";
  static const String pokemonType3 = "flying";
  static const List<String> pokemonTypes = [pokemonType1, pokemonType2];
  static const String pokemonTypesAsString = "grass,poison";
  static const String pokemonFrontSpriteUrl = "https://example.com/example.png";
  static const String artworkUrl = "https://example.com/example-artwork.png";
  static const int pokedexEntryNumber1 = 5;
  static const pokedexEntryNumber2 = 6;
  static const Map<int, int> pokedexEntryNumbers = {
    MockLocalPokedex.pokedexId1: pokedexEntryNumber1
  };
  static const Map<int, int> pokedexEntryNumbersMultiple = {
    MockLocalPokedex.pokedexId1: pokedexEntryNumber1,
    MockLocalPokedex.pokedexId2: pokedexEntryNumber2
  };
  static const int baseStatHp = 11;
  static const int statEffortHp = 1;
  static const int baseStatAttack = 12;
  static const int statEffortAttack = 0;
  static const int baseStatDefense = 13;
  static const int statEffortDefense = 0;
  static const int baseStatSpecialAttack = 14;
  static const int statEffortSpecialAttack = 0;
  static const int baseStatSpecialDefense = 15;
  static const int statEffortSpecialDefense = 0;
  static const int baseStatSpeed = 16;
  static const int statEffortSpeed = 0;

  static const PokemonLocalModel pokemon = PokemonLocalModel(
    id: pokemonId,
    name: pokemonName,
    types: pokemonTypes,
    frontSpriteUrl: pokemonFrontSpriteUrl,
    artworkUrl: artworkUrl,
    pokedexEntryNumbers: pokedexEntryNumbers,
    hp: baseStatHp,
    attack: baseStatAttack,
    defense: baseStatDefense,
    specialAttack: baseStatSpecialAttack,
    specialDefense: baseStatSpecialDefense,
    speed: baseStatSpeed,
    hpEvYield: statEffortHp,
    attackEvYield: statEffortAttack,
    defenseEvYield: statEffortDefense,
    specialAttackEvYield: statEffortSpecialAttack,
    specialDefenseEvYield: statEffortSpecialDefense,
    speedEvYield: statEffortSpeed,
  );

  static const PokemonLocalModel pokemon2 = PokemonLocalModel(
    id: pokemonId2,
    name: pokemonName2,
    types: [pokemonType3],
    frontSpriteUrl: null,
    pokedexEntryNumbers: {MockLocalPokedex.pokedexId1: pokedexEntryNumber2},
  );

  static const pokemonNullValues = PokemonLocalModel(
    id: pokemonId,
    name: pokemonName,
  );

  static const pokemonEmptyTypes = PokemonLocalModel(
    id: MockLocalPokemon.pokemonId,
    name: MockLocalPokemon.pokemonName,
    types: [],
    frontSpriteUrl: MockLocalPokemon.pokemonFrontSpriteUrl,
    pokedexEntryNumbers: MockLocalPokemon.pokedexEntryNumbers,
  );

  static const pokemonNullFrontSpriteUrl = PokemonLocalModel(
    id: MockLocalPokemon.pokemonId,
    name: MockLocalPokemon.pokemonName,
    types: pokemonTypes,
    frontSpriteUrl: null,
    pokedexEntryNumbers: MockLocalPokemon.pokedexEntryNumbers,
  );

  static const pokemonWithMultiplePokedexEntries = PokemonLocalModel(
    id: pokemonId,
    name: pokemonName,
    types: pokemonTypes,
    frontSpriteUrl: pokemonFrontSpriteUrl,
    artworkUrl: artworkUrl,
    pokedexEntryNumbers: pokedexEntryNumbersMultiple,
    hp: baseStatHp,
    attack: baseStatAttack,
    defense: baseStatDefense,
    specialAttack: baseStatSpecialAttack,
    specialDefense: baseStatSpecialDefense,
    speed: baseStatSpeed,
    hpEvYield: statEffortHp,
    attackEvYield: statEffortAttack,
    defenseEvYield: statEffortDefense,
    specialAttackEvYield: statEffortSpecialAttack,
    specialDefenseEvYield: statEffortSpecialDefense,
    speedEvYield: statEffortSpeed,
  );

  static const Map<String, dynamic> pokemonMap = {
    DatabaseColumnNames.id: MockLocalPokemon.pokemonId,
    DatabaseColumnNames.name: MockLocalPokemon.pokemonName,
    DatabaseColumnNames.types: MockLocalPokemon.pokemonTypesAsString,
    DatabaseColumnNames.frontSpriteUrl: MockLocalPokemon.pokemonFrontSpriteUrl,
    DatabaseColumnNames.artworkUrl: MockLocalPokemon.artworkUrl,
    DatabaseColumnNames.hp: MockLocalPokemon.baseStatHp,
    DatabaseColumnNames.attack: MockLocalPokemon.baseStatAttack,
    DatabaseColumnNames.defense: MockLocalPokemon.baseStatDefense,
    DatabaseColumnNames.specialAttack: MockLocalPokemon.baseStatSpecialAttack,
    DatabaseColumnNames.specialDefense: MockLocalPokemon.baseStatSpecialDefense,
    DatabaseColumnNames.speed: MockLocalPokemon.baseStatSpeed,
    DatabaseColumnNames.hpEvYield: MockLocalPokemon.statEffortHp,
    DatabaseColumnNames.attackEvYield: MockLocalPokemon.statEffortAttack,
    DatabaseColumnNames.defenseEvYield: MockLocalPokemon.statEffortDefense,
    DatabaseColumnNames.specialAttackEvYield: MockLocalPokemon.statEffortSpecialAttack,
    DatabaseColumnNames.specialDefenseEvYield: MockLocalPokemon.statEffortSpecialDefense,
    DatabaseColumnNames.speedEvYield: MockLocalPokemon.statEffortSpeed,
  };

  static const undetailedPokemonMap = {
    DatabaseColumnNames.id: pokemonId,
    DatabaseColumnNames.name: pokemonName,
    DatabaseColumnNames.types: "$pokemonType1,$pokemonType2",
    DatabaseColumnNames.frontSpriteUrl: pokemonFrontSpriteUrl,
    DatabaseColumnNames.artworkUrl: null,
    DatabaseColumnNames.hp: null,
    DatabaseColumnNames.attack: null,
    DatabaseColumnNames.defense: null,
    DatabaseColumnNames.specialAttack: null,
    DatabaseColumnNames.specialDefense: null,
    DatabaseColumnNames.speed: null,
    DatabaseColumnNames.hpEvYield: null,
    DatabaseColumnNames.attackEvYield: null,
    DatabaseColumnNames.defenseEvYield: null,
    DatabaseColumnNames.specialAttackEvYield: null,
    DatabaseColumnNames.specialDefenseEvYield: null,
    DatabaseColumnNames.speedEvYield: null,
  };

  static const undetailedPokemonMap2 = {
    DatabaseColumnNames.id: pokemonId2,
    DatabaseColumnNames.name: pokemonName2,
    DatabaseColumnNames.types: pokemonType3,
  };

  static const pokedexEntryMap = {
    DatabaseColumnNames.pokemonId: pokemonId,
    DatabaseColumnNames.pokedexId: MockLocalPokedex.pokedexId1,
    DatabaseColumnNames.entryNumber: pokedexEntryNumber1,
  };

}
