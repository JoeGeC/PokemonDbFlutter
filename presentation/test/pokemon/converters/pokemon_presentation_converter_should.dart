import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/pokedex/models/pokedex_pokemon_presentation_model.dart';
import 'package:presentation/pokedex/converters/pokedex_pokemon_presentation_converter_impl.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter_impl.dart';

import '../../model_mocks.dart';

void main() {
  late PokemonPresentationConverterImpl converter;

  setUp(() {
    converter = PokemonPresentationConverterImpl();
  });

  test('convert pokemon', () {
    var result = converter.convert(pokemonModel);

    expect(result, pokemonPresentationModel);
  });

}
