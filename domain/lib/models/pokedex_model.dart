import 'package:domain/models/pokemon_model.dart';
import 'package:equatable/equatable.dart';

class PokedexModel extends Equatable {
  final int id;
  final String name;
  final List<PokemonModel> pokemon;

  const PokedexModel({required this.id, required this.name, required this.pokemon});

  @override
  List<Object?> get props => [id, name, pokemon];
}
