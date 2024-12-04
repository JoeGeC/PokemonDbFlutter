part of 'pokemon_bloc.dart';

class PokemonSuccessState extends BaseState {
  final PokemonPresentationModel pokemon;

  PokemonSuccessState(this.pokemon);

  @override
  bool operator ==(Object other) {
    return other is PokemonSuccessState && pokemon == other.pokemon;
  }

  @override
  int get hashCode => pokemon.hashCode;
}
