import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/presentation.dart';
import 'package:presentation/src/pokemon/converters/pokemon_presentation_converter_impl.dart';

import '../../model_mocks.dart';
import 'pokemon_presentation_converter_test.mocks.dart';

@GenerateMocks([PresentationLocalizations])
void main() {
  late PokemonPresentationConverterImpl converter;
  late MockPresentationLocalizations mockLocalizations;

  setUp(() {
    mockLocalizations = MockPresentationLocalizations();
    converter = PokemonPresentationConverterImpl(mockLocalizations);

    when(mockLocalizations.grass).thenReturn("Grass");
    when(mockLocalizations.psychic).thenReturn("Psychic");
    when(mockLocalizations.fire).thenReturn("Fire");
    when(mockLocalizations.fighting).thenReturn("Fighting");
  });

  test('convert pokemon', () {
    var result = converter.convert(pokemonModel);

    expect(result, pokemonPresentationModel);
  });

}
