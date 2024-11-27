part of 'pokedex_bloc.dart';

abstract class PokedexState{
  const PokedexState();
}

class PokedexLoadingState extends PokedexState {}

class PokedexErrorState extends PokedexState {
  final String? errorMessage;

  PokedexErrorState(this.errorMessage);
}

class PokedexSuccessState extends PokedexState {
  final PokedexPresentationModel pokedex;

  PokedexSuccessState(this.pokedex);
}