part of 'pokedex_list_bloc.dart';

abstract class PokedexListEvent {
  const PokedexListEvent();
}

class GetPokedexListEvent extends PokedexListEvent {}