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
    var result = _buildPokemonModel(pokemonFromDatabase.first, entryNumbers);
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

  PokemonLocalModel _buildPokemonModel(
          Map<String, Object?> pokemon, Map<int, int> entryNumbers) =>
      PokemonLocalModel(
        id: pokemon[DatabaseColumnNames.pokemonId] as int,
        name: pokemon[DatabaseColumnNames.pokemonName] as String,
        types:
            (pokemon[DatabaseColumnNames.pokemonTypes] as String?)?.split(','),
        frontSpriteUrl: pokemon[DatabaseColumnNames.frontSpriteUrl] as String?,
        pokedexEntryNumbers: entryNumbers,
      );

  @override
  Future store(PokemonLocalModel pokemonModel) async {
    var pokemonMap = pokemonConverter.convert(pokemonModel);
    upsertPokemon(pokemonMap);
  }

  Future<void> upsertPokemon(Map<String, dynamic> pokemonData) async {
    await database.rawInsert('''
    INSERT INTO ${DatabaseTableNames.pokemon} (
      ${DatabaseColumnNames.id}, 
      ${DatabaseColumnNames.name}, 
      ${DatabaseColumnNames.types}, 
      ${DatabaseColumnNames.frontSpriteUrl}
    )
    VALUES (?, ?, ?, ?)
    ON CONFLICT(${DatabaseColumnNames.id}) DO UPDATE SET
      ${DatabaseColumnNames.name} = excluded.${DatabaseColumnNames.name},
      ${DatabaseColumnNames.types} = excluded.${DatabaseColumnNames.types},
      ${DatabaseColumnNames.frontSpriteUrl} = excluded.${DatabaseColumnNames.frontSpriteUrl};
  ''', [
      pokemonData[DatabaseColumnNames.id],
      pokemonData[DatabaseColumnNames.name],
      pokemonData[DatabaseColumnNames.types],
      pokemonData[DatabaseColumnNames.frontSpriteUrl],
    ]);
  }
}
