part of 'pokedex_pokemon_bloc.dart';

abstract class PokedexPokemonState{
  const PokedexPokemonState();
}

class PokedexPokemonLoadingState extends PokedexPokemonState {}

class PokedexPokemonErrorState extends PokedexPokemonState {
  final String errorMessage;

  PokedexPokemonErrorState(this.errorMessage);
}

class PokedexPokemonSuccessState extends PokedexPokemonState {
  final PokedexPokemonPresentationModel pokemon;

  PokedexPokemonSuccessState(this.pokemon);
}