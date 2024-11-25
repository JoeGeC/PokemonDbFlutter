import 'package:equatable/equatable.dart';

class PokemonModel extends Equatable {
  final int id;
  final Map<int, int>? pokedexEntryNumbers;
  final String name;
  final String? imageUrl;
  final List<String>? types;

  const PokemonModel({
    required this.id,
    required this.name,
    this.pokedexEntryNumbers,
    this.imageUrl,
    this.types,
  });

  @override
  List<Object?> get props => [id, pokedexEntryNumbers, name, imageUrl, types];

}