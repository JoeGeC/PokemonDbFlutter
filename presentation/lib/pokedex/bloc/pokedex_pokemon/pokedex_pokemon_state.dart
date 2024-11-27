part of 'pokedex_pokemon_bloc.dart';

abstract class PokedexPokemonState{
  const PokedexPokemonState();
}

class PokedexPokemonInitialState extends PokedexPokemonState {}

class PokedexPokemonLoadingState extends PokedexPokemonState {
  final int pokemonId;

  const PokedexPokemonLoadingState({required this.pokemonId});
}

class PokedexPokemonErrorState extends PokedexPokemonState {
  final int pokemonId;
  final String? errorMessage;

  const PokedexPokemonErrorState(this.pokemonId, this.errorMessage);
}

class PokedexPokemonSuccessState extends PokedexPokemonState {
  final PokedexPokemonPresentationModel pokemon;

  PokedexPokemonSuccessState(this.pokemon);
}