import 'package:equatable/equatable.dart';

class PokemonPresentationModel extends Equatable {
  final int id;
  final String nationalDexNumber;
  final String name;
  final String? spriteUrl;
  final String? artworkUrl;
  final List<String> types;
  final int? hp;
  final int? attack;
  final int? defense;
  final int? specialAttack;
  final int? specialDefense;
  final int? speed;
  final int? hpEvYield;
  final int? attackEvYield;
  final int? defenseEvYield;
  final int? specialAttackEvYield;
  final int? specialDefenseEvYield;
  final int? speedEvYield;

  const PokemonPresentationModel({
    required this.id,
    required this.nationalDexNumber,
    required this.name,
    this.spriteUrl,
    this.artworkUrl,
    required this.types,
    this.hp,
    this.attack,
    this.defense,
    this.specialAttack,
    this.specialDefense,
    this.speed,
    this.hpEvYield,
    this.attackEvYield,
    this.defenseEvYield,
    this.specialAttackEvYield,
    this.specialDefenseEvYield,
    this.speedEvYield,
  });

  @override
  List<Object?> get props => [
        id,
        nationalDexNumber,
        name,
        spriteUrl,
        artworkUrl,
        types,
        hp,
        attack,
        defense,
        specialAttack,
        specialDefense,
        speed,
        hpEvYield,
        attackEvYield,
        defenseEvYield,
        specialAttackEvYield,
        specialDefenseEvYield,
        speedEvYield,
      ];

  bool get hasPokedexDetails => spriteUrl != null && types.isNotEmpty;

  bool get statsNotNull =>
      hp != null ||
      attack != null ||
      defense != null ||
      specialAttack != null ||
      specialDefense != null ||
      speed != null;
}
