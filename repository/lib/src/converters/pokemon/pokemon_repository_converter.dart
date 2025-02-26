import 'package:domain/domain.dart';
import 'package:repository/src/models/local/pokemon_local_model.dart';

import '../../models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import '../../models/data/pokemon/pokemon_data_model.dart';

abstract class PokemonRepositoryConverter {
  PokemonModel convertToDomain(PokemonLocalModel pokemon);
  PokemonLocalModel? convertToLocal(PokemonDataModel pokemon);
  List<PokemonModel> convertListToDomain(List<PokemonLocalModel>? pokemon);
  List<PokemonLocalModel>? convertPokedexListToLocal(
      List<PokedexPokemonDataModel>? pokemon, int pokedexId);
}
