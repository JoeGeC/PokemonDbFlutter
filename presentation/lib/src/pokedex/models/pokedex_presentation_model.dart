import 'package:equatable/equatable.dart';
import 'package:presentation/src/pokedex/models/pokedex_pokemon_presentation_model.dart';

class PokedexPresentationModel extends Equatable {
  final int id;
  final String regionName;
  final String versionAbbreviation;
  final List<String> displayNames;
  final List<PokedexPokemonPresentationModel> pokemon;

  const PokedexPresentationModel({
    required this.id,
    required this.regionName,
    required this.versionAbbreviation,
    required this.displayNames,
    required this.pokemon,
  });

  @override
  List<Object?> get props => [id, regionName, versionAbbreviation, pokemon];
}
