part of 'pokedex_pokemon_bloc.dart';

abstract class PokedexPokemonEvent {
  const PokedexPokemonEvent();
}

class GetPokedexPokemonEvent extends PokedexPokemonEvent {
  final bool isLoading;

  GetPokedexPokemonEvent({ this.isLoading = true });
}