import 'package:domain/models/pokemon_model.dart';
import 'package:equatable/equatable.dart';

class PokedexModel extends Equatable{
  int id;
  String name;
  List<PokemonModel> pokemon;

  PokedexModel(this.id, this.name, this.pokemon);

  @override
  List<Object?> get props => [id, name, pokemon];
}
