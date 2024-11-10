import 'package:domain/models/pokemon_model.dart';
import 'package:presentation/pokedex/models/pokemon_local_model.dart';

abstract class PokemonLocalConverter{
  List<PokedexPokemonLocalModel> convertList(List<PokemonModel> pokemonList, String pokedexName);
  PokedexPokemonLocalModel convert(PokemonModel pokemon, String pokedexName);
}