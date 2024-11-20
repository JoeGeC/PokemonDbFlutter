import 'package:equatable/equatable.dart';
import 'package:presentation/pokedex/models/pokedex_pokemon_presentation_model.dart';

class PokedexPresentationModel extends Equatable {
  final int id;
  final String name;
  final List<PokedexPokemonPresentationModel> pokemon;

  const PokedexPresentationModel(
      {required this.id, required this.name, required this.pokemon});

  @override
  List<Object?> get props => [id, name, pokemon];
}
