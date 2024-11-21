import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter_impl.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';
import 'package:presentation/pokedex/models/pokedex_pokemon_presentation_model.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter.dart';

import 'pokedex_presentation_converter_should.mocks.dart';

@GenerateMocks([PokedexPokemonPresentationConverter])
void main() {
  setUp(() {});

  test('convert pokedex', () {
    var pokedexName = "original-johto";
    var mockPokemonConverter = MockPokemonLocalConverter();
    PokemonModel pokemonModel = PokemonModel(
      id: 1,
      name: "pokemon",
      pokedexEntryNumbers: {pokedexName: 2, "kanto": 1},
      imageUrl: "url/asd/asd/asd/",
      types: ["grass", "flying"],
    );
    PokedexPokemonPresentationModel expectedPokemon = PokedexPokemonPresentationModel(
        id: 1,
        nationalDexNumber: "0001",
        pokedexEntryNumber: "002",
        name: "Pokemon",
        imageUrl: "url/asd/asd/asd/",
        types: ["Grass", "Flying"]);
    PokedexModel pokedexModel =
        PokedexModel(id: 2, name: pokedexName, pokemon: [pokemonModel]);
    PokedexPresentationModel expected = PokedexPresentationModel(
        id: 2, name: "Original Johto", pokemon: [expectedPokemon]);
    var converter = PokedexPresentationConverterImpl(mockPokemonConverter);

    when(mockPokemonConverter.convertList([pokemonModel], pokedexName))
        .thenReturn([expectedPokemon]);
    var result = converter.convert(pokedexModel);

    expect(result, expected);
  });
}
