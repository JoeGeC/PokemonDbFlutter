import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/pokedex/converters/pokedex_local_converter_impl.dart';
import 'package:presentation/pokedex/models/pokedex_local_model.dart';
import 'package:presentation/pokedex/models/pokemon_local_model.dart';
import 'package:presentation/pokemon/converters/pokemon_local_converter.dart';

import 'pokedex_local_converter_should.mocks.dart';

@GenerateMocks([PokemonLocalConverter])
void main() {
  setUp(() {});

  test('convert pokedex', () {
    var mockPokemonConverter = MockPokemonLocalConverter();
    PokemonModel pokemonModel = PokemonModel(
      id: 1,
      name: "pokemon",
      pokedexEntryNumbers: {"johto-original": 2, "kanto": 1},
      imageUrl: "url/asd/asd/asd/",
      types: ["grass", "flying"],
    );
    PokemonLocalModel expectedPokemon = PokemonLocalModel(
        id: 1,
        nationalDexNumber: "0001",
        pokedexEntryNumbers: {"johto-original": "002", "kanto": "001"},
        name: "Pokemon",
        imageUrl: "url/asd/asd/asd/",
        types: ["Grass", "Flying"]);
    PokedexModel pokedexModel =
        PokedexModel(id: 2, name: "johto-original", pokemon: [pokemonModel]);
    PokedexLocalModel expected = PokedexLocalModel(
        id: 2, name: "Johto Original Pokedex", pokemon: [expectedPokemon]);
    var converter = PokedexLocalConverterImpl(mockPokemonConverter);

    when(mockPokemonConverter.convertList([pokemonModel]))
        .thenReturn([expectedPokemon]);
    var result = converter.convert(pokedexModel);

    expect(result, expected);
  });
}
