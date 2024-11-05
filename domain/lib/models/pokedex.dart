import 'package:domain/models/pokemon.dart';

class Pokedex {
  int id;
  String name;
  List<Pokemon> pokemon;

  Pokedex(this.id, this.name, this.pokemon);
}
