import 'package:local/database_constants.dart';
import 'package:sqflite/sqflite.dart';

class MockDatabase {
  late Database database;

  MockDatabase(this.database);

  Future<void> setupMockPokedexTable() async {
    await database.execute('''
      CREATE TABLE ${DatabaseTableNames.pokedex} (
      ${DatabaseColumnNames.id} INTEGER PRIMARY KEY,
      ${DatabaseColumnNames.name} TEXT
    )
  ''');
  }

  Future<void> setupMockPokemonTable() async {
    await database.execute('''
      CREATE TABLE ${DatabaseTableNames.pokemon} (
      ${DatabaseColumnNames.id} INTEGER PRIMARY KEY,
      ${DatabaseColumnNames.name} TEXT,
      ${DatabaseColumnNames.types} TEXT,
      ${DatabaseColumnNames.frontSpriteUrl} TEXT
    )
  ''');
  }

  Future<void> setupMockPokedexEntryNumbersTable() async {
    await database.execute('''
      CREATE TABLE ${DatabaseTableNames.pokedexEntryNumbers} (
      ${DatabaseColumnNames.pokedexName} TEXT,
      ${DatabaseColumnNames.pokemonId} INTEGER,
      ${DatabaseColumnNames.entryNumber} INTEGER
    )
  ''');
  }

  Future<void> populatePokedexTable(int pokedexId, String pokedexName) async {
    await database.insert(DatabaseTableNames.pokedex, {
      DatabaseColumnNames.id: pokedexId,
      DatabaseColumnNames.name: pokedexName,
    });
  }

  Future<void> populatePokemonTable(
      int pokemonId,
      String pokemonName,
      String pokemonType1,
      String pokemonType2,
      String pokemonFrontSpriteUrl) async {
    await database.insert(DatabaseTableNames.pokemon, {
      DatabaseColumnNames.id: pokemonId,
      DatabaseColumnNames.name: pokemonName,
      DatabaseColumnNames.types: '$pokemonType1,$pokemonType2',
      DatabaseColumnNames.frontSpriteUrl: pokemonFrontSpriteUrl,
    });
  }

  Future<void> populatePokedexEntryNumbersTable(
      String pokedexName, int pokemonId, int pokemonEntryNumber) async {
    await database.insert(DatabaseTableNames.pokedexEntryNumbers, {
      DatabaseColumnNames.pokedexName: pokedexName,
      DatabaseColumnNames.pokemonId: pokemonId,
      DatabaseColumnNames.entryNumber: pokemonEntryNumber,
    });
  }

  Future close() async {
    await database.close();
  }
}
