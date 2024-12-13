import 'package:domain/models/pokemon_model.dart';
import 'package:presentation/src/pokedex/models/pokedex_pokemon_presentation_model.dart';

abstract class PokedexPokemonPresentationConverter{
  List<PokedexPokemonPresentationModel> convertList(List<PokemonModel> pokemonList, int pokedexId);
  PokedexPokemonPresentationModel convertPokedexPokemon(PokemonModel pokemon, int pokedexId);
}