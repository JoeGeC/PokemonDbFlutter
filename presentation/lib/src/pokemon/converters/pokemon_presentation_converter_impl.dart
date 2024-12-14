import 'package:domain/domain.dart';
import 'package:presentation/presentation.dart';
import 'package:presentation/src/common/utils/extensions.dart';
import 'package:presentation/src/pokemon/converters/pokemon_presentation_converter.dart';
import '../models/pokemon_presentation_model.dart';

class PokemonPresentationConverterImpl implements PokemonPresentationConverter {
  late final PresentationLocalizations _localizations;

  PokemonPresentationConverterImpl(this._localizations);

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

  List<String> convertTypes(List<PokemonType>? types) {
    if (types == null) return [];
    return types.map((type) => convertType(type)).toList();
  }

  String convertType(PokemonType type) => switch (type) {
      PokemonType.normal => _localizations.normal,
      PokemonType.fighting => _localizations.fighting,
      PokemonType.flying => _localizations.flying,
      PokemonType.poison => _localizations.poison,
      PokemonType.ground => _localizations.ground,
      PokemonType.rock => _localizations.rock,
      PokemonType.bug => _localizations.bug,
      PokemonType.ghost => _localizations.ghost,
      PokemonType.steel => _localizations.steel,
      PokemonType.fire => _localizations.fire,
      PokemonType.water => _localizations.water,
      PokemonType.grass => _localizations.grass,
      PokemonType.electric => _localizations.electric,
      PokemonType.psychic => _localizations.psychic,
      PokemonType.ice => _localizations.ice,
      PokemonType.dragon => _localizations.dragon,
      PokemonType.dark => _localizations.dark,
      PokemonType.fairy => _localizations.fairy,
    };
}
