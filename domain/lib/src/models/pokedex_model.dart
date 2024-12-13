import 'package:domain/src/models/pokedex_constants/pokedex_name.dart';
import 'package:domain/src/models/pokemon_model.dart';
import 'package:domain/src/models/pokedex_constants/pokemon_region.dart';
import 'package:domain/src/models/pokedex_constants/pokemon_version.dart';
import 'package:equatable/equatable.dart';

class PokedexModel extends Equatable {
  final int id;
  final PokedexName? name;
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
