part of 'pokedex_pokemon_bloc.dart';

class PokedexPokemonInitialState extends BaseState {}

class PokedexPokemonSuccessState extends BaseState {
  final PokedexPokemonPresentationModel pokemon;

  PokedexPokemonSuccessState(this.pokemon);

  @override
  bool operator ==(Object other) {
    return other is PokedexPokemonSuccessState && pokemon == other.pokemon;
  }

  @override
  int get hashCode => pokemon.hashCode;
}
