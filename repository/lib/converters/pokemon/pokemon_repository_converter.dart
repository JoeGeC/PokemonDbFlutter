import 'package:domain/models/pokemon_model.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter_impl.dart';
import 'package:repository/models/data/pokedex_data.dart';
import 'package:repository/models/local/pokedex_pokemon_local.dart';

class PokemonRepositoryConverterImpl implements PokemonRepositoryConverter {
  @override
  List<PokemonModel> convertToDomain(
          List<PokedexPokemonLocalModel> localPokemonList) =>
      localPokemonList
          .map((pokemon) => PokemonModel(
                id: pokemon.id,
                name: pokemon.name,
                pokedexEntryNumbers: pokemon.pokedexEntryNumbers,
              ))
          .toList();

  @override
  List<PokedexPokemonLocalModel> convertToLocal(
      List<PokedexPokemonDataModel> dataPokemonList, String pokedexName) {
    return dataPokemonList
        .map((pokemon) => PokedexPokemonLocalModel(
            getPokemonId(pokemon.pokemonUrl),
            getEntryNumberAsMap(pokemon.entryNumber, pokedexName),
            pokemon.name))
        .toList();
  }

  int getPokemonId(String pokemonUrl) {
    RegExp regex = RegExp(r'(\d+)/$');
    final match = regex.firstMatch(pokemonUrl);
    if (match == null) {
      return 0;
    } else {
      return int.parse(match.group(1)!);
    }
  }

  Map<String, int> getEntryNumberAsMap(int entryNumber, String pokedexName) =>
      {pokedexName: entryNumber};
}
