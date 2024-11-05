import 'package:domain/models/pokedex_pokemon.dart';

class Pokedex {
  int id;
  String name;
  List<PokedexPokemon> pokemon;

  Pokedex(this.id, this.name, this.pokemon);
}
