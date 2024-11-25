import 'package:equatable/equatable.dart';

class PokemonLocalModel extends Equatable {
  final int id;
  final Map<int, int>? pokedexEntryNumbers;
  final String name;
  final List<String>? types;
  final String? frontSpriteUrl;

  const PokemonLocalModel({
    required this.id,
    this.pokedexEntryNumbers,
    required this.name,
    this.types,
    this.frontSpriteUrl,
  });

  @override
  List<Object?> get props => [id, pokedexEntryNumbers, name];
}
