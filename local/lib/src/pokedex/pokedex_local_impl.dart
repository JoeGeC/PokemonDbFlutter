import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:local/src/converters/pokemon_local_converter.dart';
import 'package:local/src/database_constants.dart';
import 'package:local/src/sql_commands.dart';
import 'package:repository/repository.dart';
import 'package:sqflite/sqflite.dart';

import '../converters/pokedex_local_converter.dart';

class PokedexLocalImpl implements PokedexLocal {
  final Database database;
  final PokemonLocalConverter pokemonConverter;
  final PokedexLocalConverter pokedexConverter;
  String noDataMessage = "No data";

  PokedexLocalImpl(this.database, this.pokedexConverter, this.pokemonConverter);

  @override
  Future<Either<DataFailure, List<PokedexLocalModel>>> getAll() async {
    final pokedexListMap = await database.query(DatabaseTableNames.pokedex);
    if (pokedexListMap.isEmpty) return Left(DataFailure(noDataMessage));
    final result = pokedexListMap
        .map((pokedexMap) => _buildPokedexLocalModel(pokedexMap, null))
        .toList();
    return Right(result);
  }

  @override
  Future<Either<DataFailure, PokedexLocalModel>> get(int pokedexId) async {
    final pokedexListMap = await _getPokedexById(pokedexId);
    if (pokedexListMap.isEmpty) return Left(DataFailure(noDataMessage));
    var pokedexMap = pokedexListMap.first;
    final pokemonMap = await _buildPokemonLocalModel(pokedexMap);
    return Right(_buildPokedexLocalModel(pokedexMap, pokemonMap));
  }

  Future<List<Map<String, Object?>>> _getPokedexById(int pokedexId) async =>
      await database.query(
        DatabaseTableNames.pokedex,
        where: '${DatabaseColumnNames.id} = ?',
        whereArgs: [pokedexId],
      );

  Future<Map<int, PokemonLocalModel>> _buildPokemonLocalModel(
    Map<String, Object?> pokedexMap,
  ) async {
    final pokedexId = pokedexMap[DatabaseColumnNames.id] as int;
    List<Map<String, Object?>> pokemonFromDatabase =
        await _getPokemonInPokedex(pokedexId);
    return _mapQueryResultsToPokemon(pokemonFromDatabase, pokedexId);
  }

  PokedexLocalModel _buildPokedexLocalModel(
    Map<String, Object?> pokedexMap,
    Map<int, PokemonLocalModel>? pokemonMap,
  ) =>
      PokedexLocalModel(
        id: pokedexMap[DatabaseColumnNames.id] as int,
        name: pokedexMap[DatabaseColumnNames.name] as String,
        pokemon: pokemonMap?.values.toList(),
      );

  Future<List<Map<String, Object?>>> _getPokemonInPokedex(
          int pokedexId) async =>
      await database.rawQuery('''
    ${SqlCommands.selectPokemonWithEntryNumbers}
    WHERE ${DatabaseTableNames.pokedexEntryNumbers}.${DatabaseColumnNames.pokedexId} = ?
      ''', [pokedexId]);

  Map<int, PokemonLocalModel> _mapQueryResultsToPokemon(
      List<Map<String, Object?>> pokemonFromDatabase, int pokedexId) {
    final Map<int, PokemonLocalModel> result = {};
    for (final pokemon in pokemonFromDatabase) {
      final pokemonId = pokemon['pokemonId'] as int;
      final entryNumber = pokemon['entryNumber'] as int?;
      final pokedexEntryNumbers = result[pokemonId]?.pokedexEntryNumbers ?? {};
      _assignEntryNumberTo(pokedexEntryNumbers, pokedexId, entryNumber);
      _addPokemonTo(result, pokemonId, pokemon, pokedexEntryNumbers);
    }
    return result;
  }

  void _assignEntryNumberTo(
      Map<int, int> pokedexEntryNumbers, int pokedexId, int? entryNumber) {
    if (entryNumber == null) return;
    pokedexEntryNumbers[pokedexId] = entryNumber;
  }

  void _addPokemonTo(Map<int, PokemonLocalModel> pokemonMap, int pokemonId,
      Map<String, Object?> pokemon, Map<int, int> pokedexEntryNumbers) {
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
  Future<void> storeList(List<PokedexLocalModel> pokedexList) async {
    final batch = database.batch();
    for (var pokedex in pokedexList) {
      batch.insert(
        DatabaseTableNames.pokedex,
        pokedexConverter.convert(pokedex),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
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
    if (pokedex.pokemon == null) return;
    final batch = database.batch();
    for (var pokemon in pokedex.pokemon!) {
      _insertPokemonData(batch, pokemon);
      _insertPokedexEntryNumbers(pokemon, batch);
    }
    batch.commit(noResult: true);
  }

  void _insertPokemonData(Batch batch, PokemonLocalModel pokemon) async {
    batch.insert(
      DatabaseTableNames.pokemon,
      pokemonConverter.convertToDatabase(pokemon),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }

  void _insertPokedexEntryNumbers(PokemonLocalModel pokemon, Batch batch) {
    pokemon.pokedexEntryNumbers?.forEach((pokedexId, entryNumber) {
      batch.insert(
        DatabaseTableNames.pokedexEntryNumbers,
        {
          DatabaseColumnNames.pokemonId: pokemon.id,
          DatabaseColumnNames.pokedexId: pokedexId,
          DatabaseColumnNames.entryNumber: entryNumber,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    });
  }
}
