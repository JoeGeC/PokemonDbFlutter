import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/pokedex/models/pokedex_pokemon_presentation_model.dart';
import 'package:presentation/pokedex/converters/pokedex_pokemon_presentation_converter_impl.dart';

void main() {
  late PokedexPokemonPresentationConverterImpl converter;
  late PokemonModel pokemonModel;
  late PokedexPokemonPresentationModel presentationPokemonModel;

  const int pokedexId = 11;

  setUp(() {
    converter = PokedexPokemonPresentationConverterImpl();
    pokemonModel = PokemonModel(
      id: 1,
      name: "pokemon",
      pokedexEntryNumbers: {pokedexId : 2, 12: 1},
      spriteUrl: "url/asd/asd/asd/",
      types: ["grass", "flying"],
    );
    presentationPokemonModel = PokedexPokemonPresentationModel(
        id: 1,
        nationalDexNumber: "0001",
        pokedexEntryNumber: "002",
        name: "Pokemon",
        imageUrl: "url/asd/asd/asd/",
        types: ["Grass", "Flying"]
    );
  });

  test('convert pokemon', () {
    var result = converter.convertPokedexPokemon(pokemonModel, pokedexId);

    expect(result, presentationPokemonModel);
  });

  test('convert list of pokemon', () {
    var pokemonModelList = [pokemonModel, pokemonModel];
    var pokemonLocalModelList = [presentationPokemonModel, presentationPokemonModel];

    var result = converter.convertList(pokemonModelList, pokedexId);

    expect(result, pokemonLocalModelList);
  });
}
