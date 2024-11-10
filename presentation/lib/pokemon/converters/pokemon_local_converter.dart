import 'package:domain/models/pokemon_model.dart';
import 'package:presentation/pokedex/models/pokemon_local_model.dart';

abstract class PokemonLocalConverter{
  PokemonLocalModel convert(PokemonModel pokemon);
}