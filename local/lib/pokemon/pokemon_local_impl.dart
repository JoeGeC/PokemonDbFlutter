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
  void store(PokemonLocalModel model) {
    // TODO: implement store
  }
}
