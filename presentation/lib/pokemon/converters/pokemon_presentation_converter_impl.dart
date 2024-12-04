import 'package:domain/models/pokemon_model.dart';
import 'package:presentation/common/utils/extensions.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter.dart';
import '../models/pokemon_presentation_model.dart';

class PokemonPresentationConverterImpl implements PokemonPresentationConverter {
  @override
  PokemonPresentationModel convert(PokemonModel pokemon) {
    return PokemonPresentationModel(
      id: pokemon.id,
      nationalDexNumber: convertNationalDexNumber(pokemon.id),
      name: convertName(pokemon.name),
      imageUrl: pokemon.imageUrl,
      types: convertTypes(pokemon.types),
    );
  }

  String convertNationalDexNumber(int id) => id.toString().padLeft(4, '0');

  String convertName(String name) => name.capitalise();

  List<String> convertTypes(List<String>? types) =>
      types?.map((type) => type.capitalise()).toList() ?? [];
}
