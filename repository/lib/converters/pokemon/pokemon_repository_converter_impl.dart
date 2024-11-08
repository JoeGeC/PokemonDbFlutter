import 'package:domain/models/pokemon_model.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/models/local/pokedex_pokemon_local.dart';

abstract class PokemonRepositoryConverter {
  List<PokemonModel> convertToDomain(List<PokedexPokemonLocalModel> pokemon);

  List<PokedexPokemonLocalModel> convertToLocal(
      List<PokedexPokemonDataModel> pokemon, String pokedexName);
}
