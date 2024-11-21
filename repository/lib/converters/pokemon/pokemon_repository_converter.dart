import 'package:domain/models/pokemon_model.dart';
import 'package:repository/models/local/pokemon_local_model.dart';

import '../../models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import '../../models/data/pokemon/pokemon_data_model.dart';

abstract class PokemonRepositoryConverter {
  PokemonModel convertToDomain(PokemonLocalModel pokemon);
  PokemonLocalModel convertToLocal(PokemonDataModel pokemon);
  List<PokemonModel> convertListToDomain(List<PokemonLocalModel> pokemon);
  List<PokemonLocalModel> convertListToLocal(
      List<PokedexPokemonDataModel> pokemon, String pokedexName);
}
