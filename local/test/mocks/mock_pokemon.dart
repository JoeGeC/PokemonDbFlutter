import 'package:repository/models/local/pokemon_local_model.dart';

class MockLocalPokemon {
  static final int pokemonId = 1;
  static final int pokedexId = 2;
  static final String pokemonName = "Sample Pokemon";
  static final List<String> pokemonTypes = ["Grass", "Poison"];
  static final String pokemonTypesAsString = "Grass,Poison";
  static final String pokemonFrontSpriteUrl = "https://example.com/example.png";
  static final Map<int, int> pokedexEntryNumbers = {pokedexId: 5};
  static final int baseStatHp = 11;
  static final int statEffortHp = 1;
  static final int baseStatAttack = 12;
  static final int statEffortAttack = 0;
  static final int baseStatDefense = 13;
  static final int statEffortDefense = 0;
  static final int baseStatSpecialAttack = 14;
  static final int statEffortSpecialAttack = 0;
  static final int baseStatSpecialDefense = 15;
  static final int statEffortSpecialDefense = 0;
  static final int baseStatSpeed = 16;
  static final int statEffortSpeed = 0;

  static final PokemonLocalModel pokemon = PokemonLocalModel(
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

  static final pokemonNullValues = PokemonLocalModel(
    id: pokemonId,
    name: pokemonName,
  );

  static final pokemonEmptyTypes = PokemonLocalModel(
    id: MockLocalPokemon.pokemonId,
    name: MockLocalPokemon.pokemonName,
    types: [],
    frontSpriteUrl: MockLocalPokemon.pokemonFrontSpriteUrl,
    pokedexEntryNumbers: MockLocalPokemon.pokedexEntryNumbers,
  );

  static final pokemonNullFrontSpriteUrl = PokemonLocalModel(
    id: MockLocalPokemon.pokemonId,
    name: MockLocalPokemon.pokemonName,
    types: pokemonTypes,
    frontSpriteUrl: null,
    pokedexEntryNumbers: MockLocalPokemon.pokedexEntryNumbers,
  );
}