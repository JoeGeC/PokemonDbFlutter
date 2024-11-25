part of 'pokedex_pokemon_bloc.dart';

abstract class PokedexPokemonEvent {
  const PokedexPokemonEvent();
}

class GetPokedexPokemonEvent extends PokedexPokemonEvent {
  final int pokemonId;
  final int pokedexId;

  GetPokedexPokemonEvent(this.pokemonId, this.pokedexId);
}