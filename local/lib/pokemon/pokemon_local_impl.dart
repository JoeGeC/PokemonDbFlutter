import 'package:dartz/dartz.dart';
import 'package:local/database_constants.dart';
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
    var result = await getPokemonFromDatabase(id);
    if(result.isEmpty) return Left(DataFailure("No data"));
    final pokemonMap = result.first;
    return Right(buildPokemonModel(pokemonMap));
  }

  Future<List<Map<String, Object?>>> getPokemonFromDatabase(int id) async =>
      await database.rawQuery('''
        SELECT * FROM ${DatabaseTableNames.pokemon}
        WHERE ${DatabaseColumnNames.id} = ?
      ''', [id]);

  PokemonLocalModel buildPokemonModel(Map<String, Object?> pokemon) =>
      PokemonLocalModel(
        id: pokemon[DatabaseColumnNames.id] as int,
        name: pokemon[DatabaseColumnNames.name] as String,
        types: (pokemon[DatabaseColumnNames.types] as String?)?.split(','),
        frontSpriteUrl: pokemon[DatabaseColumnNames.frontSpriteUrl] as String?,
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
