import 'package:equatable/equatable.dart';

class PokemonModel extends Equatable {
  int id;
  Map<String, int>? pokedexEntryNumbers;
  String name;
  String? imageUrl;
  List<String>? types;

  PokemonModel({
    required this.id,
    required this.name,
    this.pokedexEntryNumbers,
    this.imageUrl,
    this.types,
  });

  @override
  List<Object?> get props => [id, pokedexEntryNumbers, name, imageUrl, types];

}