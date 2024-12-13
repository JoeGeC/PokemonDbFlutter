part of 'pokedex_pokemon_bloc.dart';

abstract class PokedexPokemonEvent {
  const PokedexPokemonEvent();
}

class GetPokedexPokemonEvent extends PokedexPokemonEvent {
  final PokedexPokemonPresentationModel pokemon;
  final int pokedexId;

  GetPokedexPokemonEvent(this.pokemon, this.pokedexId);
}