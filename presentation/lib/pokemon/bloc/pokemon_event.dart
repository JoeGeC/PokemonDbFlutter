part of 'pokemon_bloc.dart';

abstract class PokemonEvent {
  const PokemonEvent();
}

class GetPokemonEvent extends PokemonEvent {
  final int pokemonId;

  GetPokemonEvent(this.pokemonId);
}

class GetExistingPokemonEvent extends PokemonEvent {
  final PokemonPresentationModel pokemon;

  GetExistingPokemonEvent(this.pokemon);
}