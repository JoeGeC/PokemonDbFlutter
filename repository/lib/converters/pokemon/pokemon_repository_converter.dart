import 'package:domain/models/pokemon_model.dart';
import 'package:repository/models/local/pokemon_local_model.dart';

import '../../models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';

abstract class PokemonRepositoryConverter {
  List<PokemonModel> convertToDomain(List<PokemonLocalModel> pokemon);

  List<PokemonLocalModel> convertToLocal(
      List<PokedexPokemonDataModel> pokemon, String pokedexName);
}
