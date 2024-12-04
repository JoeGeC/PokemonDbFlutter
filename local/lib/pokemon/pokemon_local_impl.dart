import 'package:dartz/dartz.dart';
import 'package:local/database_constants.dart';
import 'package:local/sql_commands.dart';
import 'package:repository/boundary/local/pokemon_local.dart';
import 'package:repository/models/data_failure.dart';
import 'package:repository/models/local/pokemon_local_model.dart';
import 'package:sqflite/sqflite.dart';

import '../converters/pokemon_local_converter.dart';

class PokemonLocalImpl implements PokemonLocal {
  final Database database;
  final PokemonLocalConverter pokemonConverter;

  PokemonLocalImpl(this.database, this.pokemonConverter);

  @override
  Future<Either<DataFailure, PokemonLocalModel>> get(int id) async {
    var pokemonFromDatabase = await _getPokemonFromDatabase(id);
    if (pokemonFromDatabase.isEmpty) return Left(DataFailure("No data"));
    var entryNumbers = _extractEntryNumbers(pokemonFromDatabase);
    var result = pokemonConverter.convertFromDatabase(
        pokemonFromDatabase.first, entryNumbers);
    return Right(result);
  }

  Future<List<Map<String, Object?>>> _getPokemonFromDatabase(int id) async =>
      await database.rawQuery('''
        ${SqlCommands.selectPokemonWithEntryNumbers}
        WHERE ${DatabaseColumnNames.id} = ?
      ''', [id]);

  Map<int, int> _extractEntryNumbers(
      List<Map<String, Object?>> pokemonFromDatabase) {
    final pokedexEntryNumbers = <int, int>{};
    for (final pokemon in pokemonFromDatabase) {
      final pokedexId = pokemon[DatabaseColumnNames.pokedexId] as int?;
      final entryNumber = pokemon[DatabaseColumnNames.entryNumber] as int?;
      if (pokedexId != null && entryNumber != null) {
        pokedexEntryNumbers[pokedexId] = entryNumber;
      }
    }
    return pokedexEntryNumbers;
  }

  @override
  Future store(PokemonLocalModel pokemonModel) async {
    var pokemonMap = pokemonConverter.convertToDatabase(pokemonModel);
    upsertPokemon(pokemonMap);
  }

  Future<void> upsertPokemon(Map<String, dynamic> pokemonData) async {
    await database.rawInsert('''
    INSERT INTO ${DatabaseTableNames.pokemon} (
      ${DatabaseColumnNames.id}, 
      ${DatabaseColumnNames.name}, 
      ${DatabaseColumnNames.types}, 
      ${DatabaseColumnNames.frontSpriteUrl},
      ${DatabaseColumnNames.hp},
      ${DatabaseColumnNames.attack},
      ${DatabaseColumnNames.defense},
      ${DatabaseColumnNames.specialAttack},
      ${DatabaseColumnNames.specialDefense},
      ${DatabaseColumnNames.speed},
      ${DatabaseColumnNames.hpEvYield},
      ${DatabaseColumnNames.attackEvYield},
      ${DatabaseColumnNames.defenseEvYield},
      ${DatabaseColumnNames.specialAttackEvYield},
      ${DatabaseColumnNames.specialDefenseEvYield},
      ${DatabaseColumnNames.speedEvYield}
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
    ON CONFLICT(${DatabaseColumnNames.id}) DO UPDATE SET
      ${DatabaseColumnNames.name} = excluded.${DatabaseColumnNames.name},
      ${DatabaseColumnNames.types} = excluded.${DatabaseColumnNames.types},
      ${DatabaseColumnNames.frontSpriteUrl} = excluded.${DatabaseColumnNames.frontSpriteUrl},
      ${DatabaseColumnNames.hp} = excluded.${DatabaseColumnNames.hp},
      ${DatabaseColumnNames.attack} = excluded.${DatabaseColumnNames.attack},
      ${DatabaseColumnNames.defense} = excluded.${DatabaseColumnNames.defense},
      ${DatabaseColumnNames.specialAttack} = excluded.${DatabaseColumnNames.specialAttack},
      ${DatabaseColumnNames.specialDefense} = excluded.${DatabaseColumnNames.specialDefense},
      ${DatabaseColumnNames.speed} = excluded.${DatabaseColumnNames.speed},
      ${DatabaseColumnNames.hpEvYield} = excluded.${DatabaseColumnNames.hpEvYield},
      ${DatabaseColumnNames.attackEvYield} = excluded.${DatabaseColumnNames.attackEvYield},
      ${DatabaseColumnNames.defenseEvYield} = excluded.${DatabaseColumnNames.defenseEvYield},
      ${DatabaseColumnNames.specialAttackEvYield} = excluded.${DatabaseColumnNames.specialAttackEvYield},
      ${DatabaseColumnNames.specialDefenseEvYield} = excluded.${DatabaseColumnNames.specialDefenseEvYield},
      ${DatabaseColumnNames.speedEvYield} = excluded.${DatabaseColumnNames.speedEvYield};
  ''', [
      pokemonData[DatabaseColumnNames.id],
      pokemonData[DatabaseColumnNames.name],
      pokemonData[DatabaseColumnNames.types],
      pokemonData[DatabaseColumnNames.frontSpriteUrl],
      pokemonData[DatabaseColumnNames.hp],
      pokemonData[DatabaseColumnNames.attack],
      pokemonData[DatabaseColumnNames.defense],
      pokemonData[DatabaseColumnNames.specialAttack],
      pokemonData[DatabaseColumnNames.specialDefense],
      pokemonData[DatabaseColumnNames.speed],
      pokemonData[DatabaseColumnNames.hpEvYield],
      pokemonData[DatabaseColumnNames.attackEvYield],
      pokemonData[DatabaseColumnNames.defenseEvYield],
      pokemonData[DatabaseColumnNames.specialAttackEvYield],
      pokemonData[DatabaseColumnNames.specialDefenseEvYield],
      pokemonData[DatabaseColumnNames.speedEvYield],
    ]);
  }
}
