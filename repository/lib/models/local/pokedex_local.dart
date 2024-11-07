import 'package:repository/models/local/pokedex_pokemon_local.dart';
import 'package:equatable/equatable.dart';

class PokedexLocalModel extends Equatable {
  int id;
  String name;
  List<PokedexPokemonLocalModel> pokemon;

  PokedexLocalModel(this.id, this.name, this.pokemon);

  @override
  List<Object?> get props => [id, name, pokemon];
}