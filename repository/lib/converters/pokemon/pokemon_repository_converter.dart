import 'package:domain/models/pokemon_model.dart';
import 'package:repository/models/local/pokedex_pokemon_local.dart';

import '../../models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';

abstract class PokemonRepositoryConverter {
  List<PokemonModel> convertToDomain(List<PokedexPokemonLocalModel> pokemon);

  List<PokedexPokemonLocalModel> convertToLocal(
      List<PokedexPokemonDataModel> pokemon, String pokedexName);
}
