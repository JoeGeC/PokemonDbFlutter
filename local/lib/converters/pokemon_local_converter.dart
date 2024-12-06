import 'package:repository/models/local/pokemon_local_model.dart';

import '../database_constants.dart';

class PokemonLocalConverter{
  Map<String, dynamic> convertToDatabase(PokemonLocalModel pokemon) => {
    DatabaseColumnNames.id: pokemon.id,
    DatabaseColumnNames.name: pokemon.name,
    DatabaseColumnNames.types: pokemon.types?.join(','),
    DatabaseColumnNames.frontSpriteUrl: pokemon.frontSpriteUrl,
    DatabaseColumnNames.artworkUrl: pokemon.artworkUrl,
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

  PokemonLocalModel convertFromDatabase(
      Map<String, Object?> pokemon, Map<int, int> entryNumbers) =>
      PokemonLocalModel(
        id: pokemon[DatabaseColumnNames.pokemonId] as int,
        name: pokemon[DatabaseColumnNames.pokemonName] as String,
        types: (pokemon[DatabaseColumnNames.pokemonTypes] as String?)?.split(','),
        frontSpriteUrl: pokemon[DatabaseColumnNames.frontSpriteUrl] as String?,
        artworkUrl: pokemon[DatabaseColumnNames.artworkUrl] as String?,
        pokedexEntryNumbers: entryNumbers,
        hp: pokemon[DatabaseColumnNames.hp] as int?,
        attack: pokemon[DatabaseColumnNames.attack] as int?,
        defense: pokemon[DatabaseColumnNames.defense] as int?,
        specialAttack: pokemon[DatabaseColumnNames.specialAttack] as int?,
        specialDefense: pokemon[DatabaseColumnNames.specialDefense] as int?,
        speed: pokemon[DatabaseColumnNames.speed] as int?,
        hpEvYield: pokemon[DatabaseColumnNames.hpEvYield] as int?,
        attackEvYield: pokemon[DatabaseColumnNames.attackEvYield] as int?,
        defenseEvYield: pokemon[DatabaseColumnNames.defenseEvYield] as int?,
        specialAttackEvYield: pokemon[DatabaseColumnNames.specialAttackEvYield] as int?,
        specialDefenseEvYield: pokemon[DatabaseColumnNames.specialDefenseEvYield] as int?,
        speedEvYield: pokemon[DatabaseColumnNames.speedEvYield] as int?,
      );

}