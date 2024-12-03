part of 'pokedex_pokemon_bloc.dart';

abstract class PokedexPokemonState {
  const PokedexPokemonState();
}

class PokedexPokemonInitialState extends PokedexPokemonState {}

class PokedexPokemonLoadingState extends PokedexPokemonState {}

class PokedexPokemonErrorState extends PokedexPokemonState {
  final int pokemonId;
  final String? errorMessage;

  const PokedexPokemonErrorState(this.pokemonId, this.errorMessage);

  @override
  bool operator ==(Object other) {
    return other is PokedexPokemonErrorState &&
        pokemonId == other.pokemonId &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode => Object.hash(pokemonId, errorMessage);
}

class PokedexPokemonSuccessState extends PokedexPokemonState {
  final PokedexPokemonPresentationModel pokemon;

  PokedexPokemonSuccessState(this.pokemon);

  @override
  bool operator ==(Object other) {
    return other is PokedexPokemonSuccessState && pokemon == other.pokemon;
  }

  @override
  int get hashCode => pokemon.hashCode;
}
