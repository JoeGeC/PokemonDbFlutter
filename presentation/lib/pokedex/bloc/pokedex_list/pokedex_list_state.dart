part of 'pokedex_list_bloc.dart';

abstract class PokedexListState{
  const PokedexListState();
}

class PokedexListInitialState extends PokedexListState {}

class PokedexListLoadingState extends PokedexListState {}

class PokedexListErrorState extends PokedexListState {
  final String? errorMessage;

  PokedexListErrorState(this.errorMessage);
}

class PokedexListSuccessState extends PokedexListState {
  final Map<String, List<PokedexPresentationModel>> pokedexMap;

  PokedexListSuccessState(this.pokedexMap);
}