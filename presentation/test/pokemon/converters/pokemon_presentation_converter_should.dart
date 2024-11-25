import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/pokedex/models/pokedex_pokemon_presentation_model.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter_impl.dart';

void main() {
  late PokedexPokemonPresentationConverterImpl converter;
  late PokemonModel pokemonModel;
  late PokedexPokemonPresentationModel pokemonLocalModel;

  const int pokedexId = 11;

  setUp(() {
    converter = PokedexPokemonPresentationConverterImpl();
    pokemonModel = PokemonModel(
      id: 1,
      name: "pokemon",
      pokedexEntryNumbers: {pokedexId : 2, 12: 1},
      imageUrl: "url/asd/asd/asd/",
      types: ["grass", "flying"],
    );
    pokemonLocalModel = PokedexPokemonPresentationModel(
        id: 1,
        nationalDexNumber: "0001",
        pokedexEntryNumber: "002",
        name: "Pokemon",
        imageUrl: "url/asd/asd/asd/",
        types: ["Grass", "Flying"]
    );
  });

  test('convert pokemon', () {
    var result = converter.convert(pokemonModel, pokedexId);

    expect(result, pokemonLocalModel);
  });

  test('convert list of pokemon', () {
    var pokemonModelList = [pokemonModel, pokemonModel];
    var pokemonLocalModelList = [pokemonLocalModel, pokemonLocalModel];

    var result = converter.convertList(pokemonModelList, pokedexId);

    expect(result, pokemonLocalModelList);
  });
}
