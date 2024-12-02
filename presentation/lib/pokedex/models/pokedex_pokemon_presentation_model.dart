import 'package:equatable/equatable.dart';

class PokedexPokemonPresentationModel extends Equatable {
  final int id;
  final String nationalDexNumber;
  final String pokedexEntryNumber;
  final String name;
  final String? imageUrl;
  final List<String> types;

  const PokedexPokemonPresentationModel({
    required this.id,
    required this.nationalDexNumber,
    required this.pokedexEntryNumber,
    required this.name,
    this.imageUrl,
    required this.types,
  });

  @override
  List<Object?> get props =>
      [id, nationalDexNumber, pokedexEntryNumber, name, imageUrl, types];

  bool get hasPokedexDetails => imageUrl != null && types.isNotEmpty;
}
