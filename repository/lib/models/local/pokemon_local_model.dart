import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

class PokemonLocalModel extends Equatable {
  final int id;
  final Map<int, int>? pokedexEntryNumbers;
  final String name;
  final List<String>? types;
  final String? frontSpriteUrl;
  final String? artworkUrl;
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

  const PokemonLocalModel({
    required this.id,
    this.pokedexEntryNumbers,
    required this.name,
    this.types,
    this.frontSpriteUrl,
    this.artworkUrl,
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
        pokedexEntryNumbers == null
            ? null
            : const MapEquality()
                .equals(pokedexEntryNumbers, pokedexEntryNumbers),
        name,
        types == null ? null : const ListEquality().equals(types, types),
        frontSpriteUrl,
        artworkUrl,
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
}
