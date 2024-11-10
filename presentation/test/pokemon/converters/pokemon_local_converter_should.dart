import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:presentation/pokedex/models/pokemon_local_model.dart';
import 'package:presentation/pokemon/converters/pokemon_local_converter_impl.dart';

void main() {
  late PokedexPokemonLocalConverterImpl converter;
  late PokemonModel pokemonModel;
  late PokedexPokemonLocalModel pokemonLocalModel;
  late String pokedexName;

  setUp(() {
    converter = PokedexPokemonLocalConverterImpl();
    pokedexName = "johto-original";
    pokemonModel = PokemonModel(
      id: 1,
      name: "pokemon",
      pokedexEntryNumbers: {pokedexName: 2, "kanto": 1},
      imageUrl: "url/asd/asd/asd/",
      types: ["grass", "flying"],
    );
    pokemonLocalModel = PokedexPokemonLocalModel(
        id: 1,
        nationalDexNumber: "0001",
        pokedexEntryNumber: "002",
        name: "Pokemon",
        imageUrl: "url/asd/asd/asd/",
        types: ["Grass", "Flying"]
    );
  });

  test('convert pokemon', () {
    var result = converter.convert(pokemonModel, pokedexName);

    expect(result, pokemonLocalModel);
  });

  test('convert list of pokemon', () {
    var pokemonModelList = [pokemonModel, pokemonModel];
    var pokemonLocalModelList = [pokemonLocalModel, pokemonLocalModel];

    var result = converter.convertList(pokemonModelList, pokedexName);

    expect(result, pokemonLocalModelList);
  });
}
