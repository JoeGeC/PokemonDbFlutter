import 'package:equatable/equatable.dart';

class PokemonPresentationModel extends Equatable {
  final int id;
  final String nationalDexNumber;
  final String name;
  final String? imageUrl;
  final List<String> types;

  const PokemonPresentationModel({
    required this.id,
    required this.nationalDexNumber,
    required this.name,
    this.imageUrl,
    required this.types,
  });

  @override
  List<Object?> get props =>
      [id, nationalDexNumber, name, imageUrl, types];

  bool get hasPokedexDetails => imageUrl != null && types.isNotEmpty;
}
