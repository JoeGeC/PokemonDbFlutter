import 'package:domain/models/pokemon_model.dart';
import 'package:presentation/src/common/utils/extensions.dart';
import 'package:presentation/src/pokemon/converters/pokemon_presentation_converter.dart';
import '../models/pokemon_presentation_model.dart';

class PokemonPresentationConverterImpl implements PokemonPresentationConverter {
  @override
  PokemonPresentationModel convert(PokemonModel pokemon) {
    return PokemonPresentationModel(
      id: pokemon.id,
      nationalDexNumber: convertNationalDexNumber(pokemon.id),
      name: convertName(pokemon.name),
      spriteUrl: pokemon.spriteUrl,
      artworkUrl: pokemon.artworkUrl,
      types: convertTypes(pokemon.types),
      hp: pokemon.hp,
      attack: pokemon.attack,
      defense: pokemon.defense,
      specialAttack: pokemon.specialAttack,
      specialDefense: pokemon.specialDefense,
      speed: pokemon.speed,
      hpEvYield: pokemon.hpEvYield,
      attackEvYield: pokemon.attackEvYield,
      defenseEvYield: pokemon.defenseEvYield,
      specialAttackEvYield: pokemon.specialAttackEvYield,
      specialDefenseEvYield: pokemon.specialDefenseEvYield,
      speedEvYield: pokemon.speedEvYield,
    );
  }

  String convertNationalDexNumber(int id) => id.toString().padLeft(4, '0');

  String convertName(String name) => name.capitalise();

  List<String> convertTypes(List<String>? types) =>
      types?.map((type) => type.capitalise()).toList() ?? [];
}
