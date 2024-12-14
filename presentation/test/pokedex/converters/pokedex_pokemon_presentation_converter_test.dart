import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/presentation.dart';
import 'package:presentation/src/pokedex/converters/pokedex_pokemon_presentation_converter_impl.dart';

import '../../model_mocks.dart';
import 'pokedex_pokemon_presentation_converter_test.mocks.dart';

@GenerateMocks([PresentationLocalizations])
void main() {
  late PokedexPokemonPresentationConverterImpl converter;
  late MockPresentationLocalizations mockLocalizations;

  setUp(() {
    mockLocalizations = MockPresentationLocalizations();
    converter = PokedexPokemonPresentationConverterImpl(mockLocalizations);

    when(mockLocalizations.grass).thenReturn("Grass");
    when(mockLocalizations.psychic).thenReturn("Psychic");
    when(mockLocalizations.fire).thenReturn("Fire");
    when(mockLocalizations.fighting).thenReturn("Fighting");
  });

  test('convert pokemon', () {
    var result = converter.convertPokedexPokemon(pokemonModel, pokedexId1);

    expect(result, pokedexPokemonPresentationModel);
  });

  test('convert list of pokemon', () {
    var result = converter.convertList(pokemonModelList, pokedexId1);

    expect(result, pokedexPokemonPresentationModelList);
  });
}
