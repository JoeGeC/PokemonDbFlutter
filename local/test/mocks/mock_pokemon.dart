import 'package:local/database_constants.dart';
import 'package:repository/models/local/pokemon_local_model.dart';

class MockLocalPokemon {
  static const int pokemonId = 101;
  static const int pokedexId1 = 1;
  static const int pokedexId2 = 2;
  static const String pokemonName = "Sample Pokemon";
  static const String pokemonType1 = "grass";
  static const String pokemonType2 = "poison";
  static const List<String> pokemonTypes = [pokemonType1, pokemonType2];
  static const String pokemonTypesAsString = "grass,poison";
  static const String pokemonFrontSpriteUrl = "https://example.com/example.png";
  static const int pokedexEntryNumber1 = 5;
  static const pokedexEntryNumber2 = 6;
  static const Map<int, int> pokedexEntryNumbers = {
    pokedexId1: pokedexEntryNumber1
  };
  static const Map<int, int> pokedexEntryNumbersMultiple = {
    pokedexId1: pokedexEntryNumber1,
    pokedexId2: pokedexEntryNumber2
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
}
