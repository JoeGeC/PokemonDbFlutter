import 'package:domain/models/pokemon_model.dart';
import 'package:equatable/equatable.dart';

class PokedexModel extends Equatable {
  int id;
  String name;
  List<PokemonModel> pokemon;

  PokedexModel({required this.id, required this.name, required this.pokemon});

  @override
  List<Object?> get props => [id, name, pokemon];
}
