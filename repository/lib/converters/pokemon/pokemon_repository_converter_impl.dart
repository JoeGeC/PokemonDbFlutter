import 'package:domain/models/pokemon_model.dart';
import 'package:repository/converters/BaseRepositoryConverter.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/models/data/pokemon/pokemon_data_model.dart';
import 'package:repository/models/exceptions/NullException.dart';
import 'package:repository/models/local/pokemon_local_model.dart';

import '../../models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';

class PokemonRepositoryConverterImpl extends BaseRepositoryConverter
    implements PokemonRepositoryConverter {
  @override
  List<PokemonModel> convertListToDomain(
          List<PokemonLocalModel>? localPokemonList) =>
      localPokemonList?.map(convertToDomain).toList() ?? [];

  @override
  PokemonModel convertToDomain(PokemonLocalModel pokemon) => PokemonModel(
      id: pokemon.id,
      name: pokemon.name,
      pokedexEntryNumbers: pokemon.pokedexEntryNumbers,
      types: pokemon.types,
      imageUrl: pokemon.frontSpriteUrl);

  @override
  PokemonLocalModel? convertToLocal(PokemonDataModel pokemon) {
    try {
      return PokemonLocalModel(
        id: getPokemonId(pokemon.id),
        name: getPokemonName(pokemon.name),
        types: pokemon.types,
        frontSpriteUrl: pokemon.frontSpriteUrl,
      );
    } catch (e) {
      return null;
    }
  }

  int getPokemonId(int? id) => id ?? (throw NullException(NullType.id));

  @override
  List<PokemonLocalModel>? convertPokedexListToLocal(
      List<PokedexPokemonDataModel>? dataPokemonList, int pokedexId) {
    return dataPokemonList
        ?.map((pokemon) {
          try {
            return PokemonLocalModel(
                id: getIdFromUrl(pokemon.url),
                pokedexEntryNumbers:
                    getEntryNumberAsMap(pokemon.entryNumber, pokedexId),
                name: getPokemonName(pokemon.name));
          } catch (e) {
            return null;
          }
        })
        .whereType<PokemonLocalModel>()
        .toList();
  }

  Map<int, int> getEntryNumberAsMap(int? entryNumber, int pokedexId) =>
      {pokedexId: entryNumber ?? (throw NullException(NullType.entryNumber))};

  String getPokemonName(String? pokemonName) =>
      pokemonName ?? (throw NullException(NullType.name));
}
