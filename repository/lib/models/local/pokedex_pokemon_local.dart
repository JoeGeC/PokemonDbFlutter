import 'package:equatable/equatable.dart';

class PokedexPokemonLocalModel extends Equatable{
  int id;
  Map<String, int> pokedexEntryNumbers;
  String name;

  PokedexPokemonLocalModel(this.id, this.pokedexEntryNumbers, this.name);

  @override
  List<Object?> get props => [id, pokedexEntryNumbers, name];
}
