import 'package:domain/models/pokemon_model.dart';
import 'package:presentation/pokedex/models/pokedex_pokemon_presentation_model.dart';

abstract class PokemonPresentationConverter{
  List<PokedexPokemonPresentationModel> convertList(List<PokemonModel> pokemonList, String pokedexName);
  PokedexPokemonPresentationModel convert(PokemonModel pokemon, String pokedexName);
}