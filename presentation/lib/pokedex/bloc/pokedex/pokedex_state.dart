part of 'pokedex_bloc.dart';

abstract class PokedexState{
  const PokedexState();
}

class PokedexLoadingState extends PokedexState{}

class PokedexErrorState extends PokedexState {
  final String? errorMessage;

  PokedexErrorState(this.errorMessage);

  @override
  bool operator ==(Object other) {
    return other is PokedexErrorState && errorMessage == other.errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

class PokedexSuccessState extends PokedexState {
  final PokedexPresentationModel pokedex;

  PokedexSuccessState(this.pokedex);

  @override
  bool operator ==(Object other) {
    return other is PokedexSuccessState && pokedex == other.pokedex;
  }

  @override
  int get hashCode => pokedex.hashCode;
}