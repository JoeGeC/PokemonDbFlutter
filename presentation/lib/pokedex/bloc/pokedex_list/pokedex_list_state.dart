part of 'pokedex_list_bloc.dart';

class PokedexListSuccessState extends SuccessState {
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
