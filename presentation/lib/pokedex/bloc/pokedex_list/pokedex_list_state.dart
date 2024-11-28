part of 'pokedex_list_bloc.dart';

abstract class PokedexListState{
  const PokedexListState();
}

class PokedexListLoadingState extends PokedexListState {}

class PokedexListErrorState extends PokedexListState {
  final String? errorMessage;

  PokedexListErrorState(this.errorMessage);
}

class PokedexListSuccessState extends PokedexListState {
  final List<PokedexGroupPresentationModel> pokedexGroups;

  PokedexListSuccessState(this.pokedexGroups);
}