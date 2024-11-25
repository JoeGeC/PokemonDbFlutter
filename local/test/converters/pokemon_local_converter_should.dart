import 'package:flutter_test/flutter_test.dart';
import 'package:local/converters/pokemon_local_converter.dart';
import 'package:repository/models/local/pokemon_local_model.dart';
import 'package:local/database_constants.dart';

void main() {
  late PokemonLocalConverter converter;
  const int pokemonId = 1;
  const int pokedexId = 2;
  const String pokemonName = "Sample Pokemon";
  const List<String> pokemonTypes = ["Grass", "Poison"];
  const String pokemonTypesAsString = "Grass,Poison";
  const String pokemonFrontSpriteUrl = "https://example.com/example.png";
  const Map<int, int> pokedexEntryNumbers = {pokedexId: 5};

  setUp(() {
    converter = PokemonLocalConverter();
  });

  test('converts valid PokemonLocalModel', () {
    final pokemon = PokemonLocalModel(
      id: pokemonId,
      name: pokemonName,
      types: pokemonTypes,
      frontSpriteUrl: pokemonFrontSpriteUrl,
      pokedexEntryNumbers: pokedexEntryNumbers,
    );

    final result = converter.convert(pokemon);

    expect(result, {
      DatabaseColumnNames.id: pokemonId,
      DatabaseColumnNames.name: pokemonName,
      DatabaseColumnNames.types: pokemonTypesAsString,
      DatabaseColumnNames.frontSpriteUrl: pokemonFrontSpriteUrl,
    });
  });

  test('converts a PokemonLocalModel with null types', () {
    final pokemon = PokemonLocalModel(
      id: pokemonId,
      name: pokemonName,
      types: null,
      frontSpriteUrl: pokemonFrontSpriteUrl,
      pokedexEntryNumbers: pokedexEntryNumbers,
    );

    final result = converter.convert(pokemon);

    expect(result, {
      DatabaseColumnNames.id: pokemonId,
      DatabaseColumnNames.name: pokemonName,
      DatabaseColumnNames.types: null,
      DatabaseColumnNames.frontSpriteUrl: pokemonFrontSpriteUrl,
    });
  });

  test('converts a PokemonLocalModel with empty types', () {
    final pokemon = PokemonLocalModel(
      id: pokemonId,
      name: pokemonName,
      types: [],
      frontSpriteUrl: pokemonFrontSpriteUrl,
      pokedexEntryNumbers: pokedexEntryNumbers,
    );

    final result = converter.convert(pokemon);

    expect(result, {
      DatabaseColumnNames.id: pokemonId,
      DatabaseColumnNames.name: pokemonName,
      DatabaseColumnNames.types: '',
      DatabaseColumnNames.frontSpriteUrl: pokemonFrontSpriteUrl,
    });
  });

  test('converts a PokemonLocalModel with null frontSpriteUrl', () {
    final pokemon = PokemonLocalModel(
      id: pokemonId,
      name: pokemonName,
      types: pokemonTypes,
      frontSpriteUrl: null,
      pokedexEntryNumbers: pokedexEntryNumbers,
    );

    final result = converter.convert(pokemon);

    expect(result, {
      DatabaseColumnNames.id: pokemonId,
      DatabaseColumnNames.name: pokemonName,
      DatabaseColumnNames.types: pokemonTypesAsString,
      DatabaseColumnNames.frontSpriteUrl: null,
    });
  });
}
