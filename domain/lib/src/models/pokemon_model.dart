import 'package:domain/src/models/pokemon_constants/pokemon_types.dart';
import 'package:equatable/equatable.dart';

class PokemonModel extends Equatable {
  final int id;
  final Map<int, int>? pokedexEntryNumbers;
  final String name;
  final String? spriteUrl;
  final String? artworkUrl;
  final List<PokemonType>? types;
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

  const PokemonModel({
    required this.id,
    required this.name,
    this.pokedexEntryNumbers,
    this.spriteUrl,
    this.artworkUrl,
    this.types,
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
        pokedexEntryNumbers,
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
}
