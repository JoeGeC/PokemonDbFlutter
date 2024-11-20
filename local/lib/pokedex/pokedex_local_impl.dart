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
  final Database database;
  final PokemonLocalConverter pokemonConverter;
  final PokedexLocalConverter pokedexConverter;

  PokedexLocalImpl(this.database, this.pokedexConverter, this.pokemonConverter);

  @override
  Future<Either<DataFailure, PokedexLocalModel>> get(int pokedexId) async {
    final pokedexQuery = await database.query(
      DatabaseTableNames.pokedex,
      where: '${DatabaseColumnNames.id} = ?',
      whereArgs: [pokedexId],
    );

    if (pokedexQuery.isEmpty) return Left(DataFailure("No data"));

    final pokedexRow = pokedexQuery.first;
    final pokedexName = pokedexRow[DatabaseColumnNames.name] as String? ?? "";

    // Fetch all pokemon for this pokedex
    final pokemonQuery = await database.rawQuery('''
    SELECT pokemon.${DatabaseColumnNames.id} AS pokemonId,
           pokemon.${DatabaseColumnNames.name} AS pokemonName,
           pokemon.${DatabaseColumnNames.types} AS pokemonTypes,
           pokemon.${DatabaseColumnNames.frontSpriteUrl} AS frontSpriteUrl,
           pokedexEntry.${DatabaseColumnNames.pokedexName} AS pokedexName,
           pokedexEntry.${DatabaseColumnNames.entryNumber} AS entryNumber
    FROM ${DatabaseTableNames.pokemon} pokemon
    LEFT JOIN ${DatabaseTableNames.pokedexEntryNumbers} pokedexEntry
    ON pokemon.${DatabaseColumnNames.id} = pokedexEntry.${DatabaseColumnNames.pokemonId}
    WHERE pokedexEntry.${DatabaseColumnNames.pokedexName} = ?
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
      pokedexRow[DatabaseColumnNames.id] as int,
      pokedexRow[DatabaseColumnNames.name] as String,
      pokemonMap.values.toList(),
    ));
  }

  @override
  Future<void> store(PokedexLocalModel pokedex) async {
    insertPokedex(database, pokedex);
    insertPokemon(database, pokedex);
  }

  void insertPokedex(Database database, PokedexLocalModel pokedex) {
    database.insert(
      DatabaseTableNames.pokedex,
      pokedexConverter.convert(pokedex),
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
      DatabaseTableNames.pokemon,
      pokemonConverter.convert(pokemon),
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
      DatabaseTableNames.pokedexEntryNumbers,
      {
        DatabaseColumnNames.pokemonId: pokemon.id,
        DatabaseColumnNames.pokedexName: pokedexName,
        DatabaseColumnNames.entryNumber: entryNumber,
      },
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

}