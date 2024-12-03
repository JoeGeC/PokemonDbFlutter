part of 'pokedex_list_bloc.dart';

abstract class PokedexListState {
  const PokedexListState();
}

class PokedexListLoadingState extends PokedexListState {}

class PokedexListErrorState extends PokedexListState {
  final String? errorMessage;

  PokedexListErrorState(this.errorMessage);

  @override
  bool operator ==(Object other) {
    return other is PokedexListErrorState &&
        errorMessage == other.errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}

class PokedexListSuccessState extends PokedexListState {
  final List<PokedexGroupPresentationModel> pokedexGroups;

  PokedexListSuccessState(this.pokedexGroups);

  @override
  bool operator ==(Object other) {
    return other is PokedexListSuccessState &&
        pokedexGroups == other.pokedexGroups;
  }

  @override
  int get hashCode => pokedexGroups.hashCode;
}
