part of 'pokedex_bloc.dart';

abstract class PokedexEvent {
  const PokedexEvent();
}

class GetPokedexEvent extends PokedexEvent {
  final bool isLoading;
  final int id;

  GetPokedexEvent(this.id, { this.isLoading = true });
}