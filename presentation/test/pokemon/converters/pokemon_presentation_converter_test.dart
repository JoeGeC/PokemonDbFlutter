import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/src/pokemon/converters/pokemon_presentation_converter_impl.dart';

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
