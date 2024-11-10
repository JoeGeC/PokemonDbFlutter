import 'package:equatable/equatable.dart';
import 'package:presentation/pokedex/models/pokemon_local_model.dart';

class PokedexLocalModel extends Equatable {
  final int id;
  final String name;
  final List<PokemonLocalModel> pokemon;

  const PokedexLocalModel(this.id, this.name, this.pokemon);

  @override
  List<Object?> get props => [id, name, pokemon];
}