import 'package:repository/models/local/pokedex_pokemon_local.dart';

class PokedexLocalModel {
  int id;
  String name;
  List<PokedexPokemonLocalModel> pokemon;

  PokedexLocalModel(this.id, this.name, this.pokemon);
}