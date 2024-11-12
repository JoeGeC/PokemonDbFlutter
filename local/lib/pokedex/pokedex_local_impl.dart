import 'package:dartz/dartz.dart';
import 'package:local/converters/pokemon_local_converter.dart';
import 'package:local/database_initializer.dart';
import 'package:local/database_constants.dart';
import 'package:repository/boundary/local/pokedex_local.dart';
import 'package:repository/models/local/pokedex_local_model.dart';
import 'package:repository/models/data_failure.dart';
import 'dart:async';

import 'package:repository/models/local/pokemon_local_model.dart';
import 'package:sqflite/sqflite.dart';

import '../converters/pokedex_local_converter.dart';

class PokedexLocalImpl implements PokedexLocal{
  PokemonLocalConverter pokemonConverter = PokemonLocalConverter();
  PokedexLocalConverter pokedexConverter = PokedexLocalConverter();

  @override
  Future<Either<DataFailure, PokedexLocalModel>> get(int pokedexId) async {
    final Database database = await DatabaseInitializer.instance.database;
    final pokedexQuery = await database.query(
      DatabaseConstants.pokedexTableName,
      where: '${DatabaseConstants.columnId} = ?',
      whereArgs: [pokedexId],
    );

    if (pokedexQuery.isEmpty) return Left(DataFailure("No data"));

    final pokedexRow = pokedexQuery.first;
    final pokedexName = pokedexRow[DatabaseConstants.columnName] as String? ?? "";

    // Fetch all pokemon for this pokedex
    final pokemonQuery = await database.rawQuery('''
    SELECT pokemon.${DatabaseConstants.columnId} AS pokemonId,
           pokemon.${DatabaseConstants.columnName} AS pokemonName,
           pokemon.${DatabaseConstants.columnTypes} AS pokemonTypes,
           pokemon.${DatabaseConstants.columnFrontSpriteUrl} AS frontSpriteUrl,
           pokedexEntry.${DatabaseConstants.columnPokedexName} AS pokedexName,
           pokedexEntry.${DatabaseConstants.columnEntryNumber} AS entryNumber
    FROM ${DatabaseConstants.pokemonTableName} pokemon
    LEFT JOIN ${DatabaseConstants.pokedexEntryNumbersTableName} pokedexEntry
    ON pokemon.${DatabaseConstants.columnId} = pokedexEntry.${DatabaseConstants.columnPokemonId}
    WHERE pokedexEntry.${DatabaseConstants.columnPokedexName} = ?
  ''', [pokedexName]);

    // Map each Pokemon to its pokedex entry numbers
    final Map<int, PokemonLocalModel> pokemonMap = {};

    for (final pokemonRow in pokemonQuery) {
      final pokemonId = pokemonRow['pokemonId'] as int;
      final entryNumber = pokemonRow['entryNumber'] as int?;
      final pokedexEntryNumbers = pokemonMap[pokemonId]?.pokedexEntryNumbers ?? {};

      if (entryNumber != null) {
        pokedexEntryNumbers[pokedexName] = entryNumber;
      }

      if (!pokemonMap.containsKey(pokemonId)) {
        pokemonMap[pokemonId] = PokemonLocalModel(
          id: pokemonId,
          name: pokemonRow['pokemonName'] as String,
          types: (pokemonRow['pokemonTypes'] as String?)?.split(','),
          frontSpriteUrl: pokemonRow['frontSpriteUrl'] as String?,
          pokedexEntryNumbers: pokedexEntryNumbers,
        );
      }
    }

    return Right(PokedexLocalModel(
      pokedexRow[DatabaseConstants.columnId] as int,
      pokedexRow[DatabaseConstants.columnName] as String,
      pokemonMap.values.toList(),
    ));
  }




  @override
  Future<void> store(PokedexLocalModel pokedex) async {
    final Database database = await DatabaseInitializer.instance.database;
    insertPokedex(database, pokedex);
    insertPokemon(database, pokedex);
  }

  void insertPokedex(Database database, PokedexLocalModel pokedex) {
    database.insert(
      DatabaseConstants.pokedexTableName,
      pokedexConverter.toMap(pokedex),
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  insertPokemon(Database database, PokedexLocalModel pokedex) {
    final batch = database.batch();
    for(var pokemon in pokedex.pokemon) {
      insertPokemonData(batch, pokemon);
      insertPokedexEntryNumbers(pokemon, batch);
    }
    batch.commit(noResult: true);
  }

  void insertPokemonData(Batch batch, PokemonLocalModel pokemon) {
    batch.insert(
      DatabaseConstants.pokemonTableName,
      pokemonConverter.toMap(pokemon),
      conflictAlgorithm: ConflictAlgorithm.ignore
    );
  }

  void insertPokedexEntryNumbers(PokemonLocalModel pokemon, Batch batch) {
    pokemon.pokedexEntryNumbers?.forEach((pokedexName, entryNumber) {
      insertPokedexEntryNumber(batch, pokemon, pokedexName, entryNumber);
    });
  }

  void insertPokedexEntryNumber(Batch batch, PokemonLocalModel pokemon, String pokedexName, int entryNumber) {
    batch.insert(
      DatabaseConstants.pokedexEntryNumbersTableName,
      {
        DatabaseConstants.columnPokemonId: pokemon.id,
        DatabaseConstants.columnPokedexName: pokedexName,
        DatabaseConstants.columnEntryNumber: entryNumber,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

}