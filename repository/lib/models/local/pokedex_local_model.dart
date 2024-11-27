import 'package:repository/models/local/pokemon_local_model.dart';
import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

class PokedexLocalModel extends Equatable {
  final int id;
  final String name;
  final List<PokemonLocalModel>? pokemon;

  const PokedexLocalModel({required this.id, required this.name, this.pokemon});

  @override
  List<Object?> get props => [
        id,
        name,
        pokemon == null
            ? null
            : const DeepCollectionEquality().equals(pokemon, pokemon)
      ];
}
