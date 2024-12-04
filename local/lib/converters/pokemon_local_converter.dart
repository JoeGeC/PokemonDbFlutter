import 'package:repository/models/local/pokemon_local_model.dart';

import '../database_constants.dart';

class PokemonLocalConverter{
  Map<String, dynamic> convert(PokemonLocalModel pokemon) => {
    DatabaseColumnNames.id: pokemon.id,
    DatabaseColumnNames.name: pokemon.name,
    DatabaseColumnNames.types: pokemon.types?.join(','),
    DatabaseColumnNames.frontSpriteUrl: pokemon.frontSpriteUrl,
    DatabaseColumnNames.hp: pokemon.hp,
    DatabaseColumnNames.attack: pokemon.attack,
    DatabaseColumnNames.defense: pokemon.defense,
    DatabaseColumnNames.specialAttack: pokemon.specialAttack,
    DatabaseColumnNames.specialDefense: pokemon.specialDefense,
    DatabaseColumnNames.speed: pokemon.speed,
    DatabaseColumnNames.hpEvYield: pokemon.hpEvYield,
    DatabaseColumnNames.attackEvYield: pokemon.attackEvYield,
    DatabaseColumnNames.defenseEvYield: pokemon.defenseEvYield,
    DatabaseColumnNames.specialAttackEvYield: pokemon.specialAttackEvYield,
    DatabaseColumnNames.specialDefenseEvYield: pokemon.specialDefenseEvYield,
    DatabaseColumnNames.speedEvYield: pokemon.speedEvYield,
  };

}