import 'package:flutter_test/flutter_test.dart';
import 'package:local/converters/pokemon_local_converter.dart';
import 'package:repository/models/local/pokemon_local_model.dart';
import 'package:local/database_constants.dart';

import '../mocks/mock_pokemon.dart';

void main() {
  late PokemonLocalConverter converter;

  setUp(() {
    converter = PokemonLocalConverter();
  });

  test('converts valid PokemonLocalModel', () {
    final result = converter.convertToDatabase(MockLocalPokemon.pokemon);

    expect(result, {
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
    });
  });

  test('converts a PokemonLocalModel with null values', () {
    final result = converter.convertToDatabase(MockLocalPokemon.pokemonNullValues);

    expect(result, {
      DatabaseColumnNames.id: MockLocalPokemon.pokemonId,
      DatabaseColumnNames.name: MockLocalPokemon.pokemonName,
      DatabaseColumnNames.types: null,
      DatabaseColumnNames.frontSpriteUrl: null,
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
    });
  });

  test('converts a PokemonLocalModel with empty types', () {
    final result = converter.convertToDatabase(MockLocalPokemon.pokemonEmptyTypes);

    expect(result, {
      DatabaseColumnNames.id: MockLocalPokemon.pokemonId,
      DatabaseColumnNames.name: MockLocalPokemon.pokemonName,
      DatabaseColumnNames.types: '',
      DatabaseColumnNames.frontSpriteUrl: MockLocalPokemon.pokemonFrontSpriteUrl,
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
    });
  });
}
