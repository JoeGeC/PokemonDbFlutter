import 'package:domain/models/pokemon_model.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter_impl.dart';
import 'package:repository/models/exceptions/NullException.dart';
import 'package:repository/models/local/pokedex_pokemon_local.dart';

import '../../models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';

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
        .map((pokemon) {
          try {
            return PokedexPokemonLocalModel(
                getPokemonId(pokemon.url),
                getEntryNumberAsMap(pokemon.entryNumber, pokedexName),
                getPokemonName(pokemon.name));
          } catch (e) {
            return null;
          }
        })
        .whereType<PokedexPokemonLocalModel>()
        .toList();
  }

  int getPokemonId(String? pokemonUrl) {
    if (pokemonUrl == null) throw NullException(NullType.id);
    RegExp regex = RegExp(r'(\d+)/$');
    final match = regex.firstMatch(pokemonUrl);
    if (match == null) {
      throw NullException(NullType.id);
    } else {
      return int.parse(match.group(1)!);
    }
  }

  Map<String, int> getEntryNumberAsMap(int? entryNumber, String pokedexName) {
    if (entryNumber == null) throw NullException(NullType.entryNumber);
    return {pokedexName: entryNumber};
  }

  String getPokemonName(String? pokemonName) {
    if (pokemonName == null) throw NullException(NullType.name);
    return pokemonName;
  }
}
