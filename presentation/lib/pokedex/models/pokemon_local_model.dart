import 'package:equatable/equatable.dart';

class PokemonLocalModel extends Equatable {
  final int id;
  final String nationalDexNumber;
  final Map<String, String> pokedexEntryNumbers;
  final String name;
  final String? imageUrl;
  final List<String> types;

  const PokemonLocalModel({
    required this.id,
    required this.nationalDexNumber,
    required this.pokedexEntryNumbers,
    required this.name,
    this.imageUrl,
    required this.types,
  });

  @override
  List<Object?> get props =>
      [id, nationalDexNumber, pokedexEntryNumbers, name, imageUrl, types];
}
