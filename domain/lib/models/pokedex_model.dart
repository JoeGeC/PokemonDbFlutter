import 'package:domain/models/pokemon_model.dart';
import 'package:domain/models/pokemon_region.dart';
import 'package:domain/models/pokemon_version.dart';
import 'package:equatable/equatable.dart';

class PokedexModel extends Equatable {
  final int id;
  final String name;
  final List<PokemonVersion> versions;
  final PokemonRegion? region;
  final List<PokemonModel> pokemon;

  const PokedexModel({
    required this.id,
    required this.name,
    required this.versions,
    required this.region,
    required this.pokemon,
  });

  @override
  List<Object?> get props => [id, name, pokemon];
}
