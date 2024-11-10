import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/pokedex/models/pokemon_local_model.dart';
import 'package:presentation/pokemon/converters/pokemon_local_converter_impl.dart';

void main() {
  setUp(() {});

  test('convert pokedex', () {
    var converter = PokemonLocalConverterImpl();
    PokemonModel pokemonModel = PokemonModel(
      id: 1,
      name: "pokemon",
      pokedexEntryNumbers: {"johto-original": 2, "kanto": 1},
      imageUrl: "url/asd/asd/asd/",
      types: ["grass", "flying"],
    );
    PokemonLocalModel expected = PokemonLocalModel(
        id: 1,
        nationalDexNumber: "0001",
        pokedexEntryNumbers: {"johto-original": "002", "kanto": "001"},
        name: "Pokemon",
        imageUrl: "url/asd/asd/asd/",
        types: ["Grass", "Flying"]
    );

    var result = converter.convert(pokemonModel);

    expect(result, expected);
  });
}
