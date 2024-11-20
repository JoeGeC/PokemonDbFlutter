import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:local/converters/pokemon_local_converter.dart';
import 'package:local/database_constants.dart';
import 'package:repository/boundary/local/pokedex_local.dart';
import 'package:repository/models/data_failure.dart';
import 'package:repository/models/local/pokedex_local_model.dart';
import 'package:repository/models/local/pokemon_local_model.dart';
import 'package:sqflite/sqflite.dart';

import '../converters/pokedex_local_converter.dart';

class PokedexLocalImpl implements PokedexLocal {
  final Database database;
  final PokemonLocalConverter pokemonConverter;
  final PokedexLocalConverter pokedexConverter;

  PokedexLocalImpl(this.database, this.pokedexConverter, this.pokemonConverter);

  @override
  Future<Either<DataFailure, PokedexLocalModel>> get(int pokedexId) async {
    List<Map<String, Object?>> pokedexMapFromDatabase = await getPokedexOf(pokedexId);
    if (pokedexMapFromDatabase.isEmpty) return Left(DataFailure("No data"));
    return await buildPokedexLocalModel(pokedexMapFromDatabase);
  }

  Future<List<Map<String, Object?>>> getPokedexOf(int pokedexId) async =>
      await database.query(
        DatabaseTableNames.pokedex,
        where: '${DatabaseColumnNames.id} = ?',
        whereArgs: [pokedexId],
      );

  Future<Right<DataFailure, PokedexLocalModel>> buildPokedexLocalModel(
      List<Map<String, Object?>> pokedexListFromDatabase) async {
    final pokedexFromDatabase = pokedexListFromDatabase.first;
    final pokedexName =
        pokedexFromDatabase[DatabaseColumnNames.name] as String? ?? "";
    List<Map<String, Object?>> pokemonFromDatabase =
        await getAllPokemonInPokedex(pokedexName);
    Map<int, PokemonLocalModel> pokemonMap =
        assignPokedexEntryNumbersToPokemon(pokemonFromDatabase, pokedexName);

    return Right(PokedexLocalModel(
      pokedexFromDatabase[DatabaseColumnNames.id] as int,
      pokedexFromDatabase[DatabaseColumnNames.name] as String,
      pokemonMap.values.toList(),
    ));
  }

  Future<List<Map<String, Object?>>> getAllPokemonInPokedex(
          String pokedexName) async => await database.rawQuery('''
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

  Map<int, PokemonLocalModel> assignPokedexEntryNumbersToPokemon(
      List<Map<String, Object?>> pokemonFromDatabase, String pokedexName) {
    final Map<int, PokemonLocalModel> result = {};
    for (final pokemon in pokemonFromDatabase) {
      final pokemonId = pokemon['pokemonId'] as int;
      final entryNumber = pokemon['entryNumber'] as int?;
      final pokedexEntryNumbers = result[pokemonId]?.pokedexEntryNumbers ?? {};
      assignEntryNumberTo(pokedexEntryNumbers, pokedexName, entryNumber);
      addPokemonTo(result, pokemonId, pokemon, pokedexEntryNumbers);
    }
    return result;
  }

  void assignEntryNumberTo(Map<String, int> pokedexEntryNumbers,
      String pokedexName, int? entryNumber) {
    if (entryNumber == null) return;
    pokedexEntryNumbers[pokedexName] = entryNumber;
  }

  void addPokemonTo(Map<int, PokemonLocalModel> pokemonMap, int pokemonId,
      Map<String, Object?> pokemon, Map<String, int> pokedexEntryNumbers) {
    if (pokemonMap.containsKey(pokemonId)) return;
    pokemonMap[pokemonId] = PokemonLocalModel(
      id: pokemonId,
      name: pokemon['pokemonName'] as String,
      types: (pokemon['pokemonTypes'] as String?)?.split(','),
      frontSpriteUrl: pokemon['frontSpriteUrl'] as String?,
      pokedexEntryNumbers: pokedexEntryNumbers,
    );
  }

  @override
  Future<void> store(PokedexLocalModel pokedex) async {
    insertPokedex(database, pokedex);
    insertPokemon(database, pokedex);
  }

  void insertPokedex(Database database, PokedexLocalModel pokedex) {
    database.insert(
        DatabaseTableNames.pokedex, pokedexConverter.convert(pokedex),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  insertPokemon(Database database, PokedexLocalModel pokedex) {
    final batch = database.batch();
    for (var pokemon in pokedex.pokemon) {
      insertPokemonData(batch, pokemon);
      insertPokedexEntryNumbers(pokemon, batch);
    }
    batch.commit(noResult: true);
  }

  void insertPokemonData(Batch batch, PokemonLocalModel pokemon) {
    batch.insert(DatabaseTableNames.pokemon, pokemonConverter.convert(pokemon),
        conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  void insertPokedexEntryNumbers(PokemonLocalModel pokemon, Batch batch) {
    pokemon.pokedexEntryNumbers?.forEach((pokedexName, entryNumber) {
      insertPokedexEntryNumber(batch, pokemon, pokedexName, entryNumber);
    });
  }

  void insertPokedexEntryNumber(Batch batch, PokemonLocalModel pokemon,
      String pokedexName, int entryNumber) {
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
