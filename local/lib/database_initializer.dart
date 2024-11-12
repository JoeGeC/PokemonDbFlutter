import 'package:local/sql_commands.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'database_constants.dart';

class DatabaseInitializer {
  static final DatabaseInitializer instance = DatabaseInitializer._init();
  static Database? _database;

  DatabaseInitializer._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase(DatabaseConstants.databaseName);
    return _database!;
  }

  Future<Database> _initDatabase(String filePath) async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, filePath);
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future _createDatabase(Database database, int version) async {
    await createPokedexTable(database);
    await createPokemonTable(database);
    await createPokedexEntryNumbersTable(database);
  }

  Future<void> createPokedexTable(Database database) async {
    await database.execute('''
      ${SqlCommands.createTable} IF NOT EXISTS ${DatabaseConstants.pokedexTableName} ( 
        ${DatabaseConstants.columnId} ${SqlCommands.intPrimaryKey},
        ${DatabaseConstants.columnName} ${SqlCommands.textType}
      )
    ''');
  }

  Future<void> createPokemonTable(Database database) async {
    await database.execute('''
      ${SqlCommands.createTable} IF NOT EXISTS ${DatabaseConstants.pokemonTableName} ( 
        ${DatabaseConstants.columnId} ${SqlCommands.intPrimaryKey}, 
        ${DatabaseConstants.columnName} ${SqlCommands.textType},
        ${DatabaseConstants.columnTypes} ${SqlCommands.textType},
        ${DatabaseConstants.columnFrontSpriteUrl} ${SqlCommands.textType}
      )
    ''');
  }

  Future<void> createPokedexEntryNumbersTable(Database database) async {
    await database.execute('''
      ${SqlCommands.createTable} IF NOT EXISTS ${DatabaseConstants.pokedexEntryNumbersTableName} ( 
        ${DatabaseConstants.columnPokemonId} ${SqlCommands.intType}, 
        ${DatabaseConstants.columnPokedexName} ${SqlCommands.textType},
        ${DatabaseConstants.columnEntryNumber} ${SqlCommands.intType},
        ${SqlCommands.foreignKey} (${DatabaseConstants.columnPokemonId}) ${SqlCommands.references} ${DatabaseConstants.pokemonTableName}(${DatabaseConstants.columnId}) ${SqlCommands.onDelete} ${SqlCommands.cascade}
      )
    ''');
  }
}
