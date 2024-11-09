part of 'pokedex_bloc.dart';

abstract class PokedexEvent {
  const PokedexEvent();
}

class GetPokedexEvent extends PokedexEvent {
  final bool isLoading;

  GetPokedexEvent({ this.isLoading = true });
}