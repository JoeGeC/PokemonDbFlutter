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
    final pokedexMap = await _getPokedexById(pokedexId);
    if (pokedexMap.isEmpty) return Left(DataFailure("No data"));
    return await buildPokedexLocalModel(pokedexMap);
  }

  Future<List<Map<String, Object?>>> _getPokedexById(int pokedexId) async =>
      await database.query(
        DatabaseTableNames.pokedex,
        where: '${DatabaseColumnNames.id} = ?',
        whereArgs: [pokedexId],
      );

  Future<Right<DataFailure, PokedexLocalModel>> buildPokedexLocalModel(
      List<Map<String, Object?>> pokedexListMap) async {
    final pokedexMap = pokedexListMap.first;
    final pokedexName = pokedexMap[DatabaseColumnNames.name] as String? ?? "";
    List<Map<String, Object?>> pokemonFromDatabase =
        await _getPokemonInPokedex(pokedexName);
    Map<int, PokemonLocalModel> pokemonMap =
        _mapQueryResultsToPokemon(pokemonFromDatabase, pokedexName);

    return Right(PokedexLocalModel(
      pokedexMap[DatabaseColumnNames.id] as int,
      pokedexMap[DatabaseColumnNames.name] as String,
      pokemonMap.values.toList(),
    ));
  }

  Future<List<Map<String, Object?>>> _getPokemonInPokedex(
          String pokedexName) async =>
      await database.rawQuery('''
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

  Map<int, PokemonLocalModel> _mapQueryResultsToPokemon(
      List<Map<String, Object?>> pokemonFromDatabase, String pokedexName) {
    final Map<int, PokemonLocalModel> result = {};
    for (final pokemon in pokemonFromDatabase) {
      final pokemonId = pokemon['pokemonId'] as int;
      final entryNumber = pokemon['entryNumber'] as int?;
      final pokedexEntryNumbers = result[pokemonId]?.pokedexEntryNumbers ?? {};
      _assignEntryNumberTo(pokedexEntryNumbers, pokedexName, entryNumber);
      _addPokemonTo(result, pokemonId, pokemon, pokedexEntryNumbers);
    }
    return result;
  }

  void _assignEntryNumberTo(Map<String, int> pokedexEntryNumbers,
      String pokedexName, int? entryNumber) {
    if (entryNumber == null) return;
    pokedexEntryNumbers[pokedexName] = entryNumber;
  }

  void _addPokemonTo(Map<int, PokemonLocalModel> pokemonMap, int pokemonId,
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
    _insertPokedex(pokedex);
    _insertPokemon(pokedex);
  }

  Future<void> _insertPokedex(PokedexLocalModel pokedex) async {
    await database.insert(
        DatabaseTableNames.pokedex, pokedexConverter.convert(pokedex),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> _insertPokemon(PokedexLocalModel pokedex) async {
    final batch = database.batch();
    for (var pokemon in pokedex.pokemon) {
      _insertPokemonData(batch, pokemon);
      _insertPokedexEntryNumbers(pokemon, batch);
    }
    batch.commit(noResult: true);
  }

  void _insertPokemonData(Batch batch, PokemonLocalModel pokemon) async {
    batch.insert(
      DatabaseTableNames.pokemon,
      pokemonConverter.convert(pokemon),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  void _insertPokedexEntryNumbers(PokemonLocalModel pokemon, Batch batch) {
    pokemon.pokedexEntryNumbers?.forEach((pokedexName, entryNumber) {
      batch.insert(
        DatabaseTableNames.pokedexEntryNumbers,
        {
          DatabaseColumnNames.pokemonId: pokemon.id,
          DatabaseColumnNames.pokedexName: pokedexName,
          DatabaseColumnNames.entryNumber: entryNumber,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    });
  }
}
