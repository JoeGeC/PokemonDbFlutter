part of 'pokedex_bloc.dart';

class PokedexSuccessState extends SuccessState {
  final PokedexPresentationModel pokedex;

  PokedexSuccessState(this.pokedex);

  @override
  bool operator ==(Object other) {
    return other is PokedexSuccessState && pokedex == other.pokedex;
  }

  @override
  int get hashCode => pokedex.hashCode;
}