import 'package:local/database_constants.dart';
import 'package:local/sql_commands.dart';
import 'package:sqflite/sqflite.dart';

import 'mock_pokemon.dart';

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
      ${DatabaseColumnNames.frontSpriteUrl} TEXT,
      ${DatabaseColumnNames.hp} ${SqlCommands.intType},
      ${DatabaseColumnNames.attack} ${SqlCommands.intType},
      ${DatabaseColumnNames.defense} ${SqlCommands.intType},
      ${DatabaseColumnNames.specialAttack} ${SqlCommands.intType},
      ${DatabaseColumnNames.specialDefense} ${SqlCommands.intType},
      ${DatabaseColumnNames.speed} ${SqlCommands.intType},
      ${DatabaseColumnNames.hpEvYield} ${SqlCommands.intType},
      ${DatabaseColumnNames.attackEvYield} ${SqlCommands.intType},
      ${DatabaseColumnNames.defenseEvYield} ${SqlCommands.intType},
      ${DatabaseColumnNames.specialAttackEvYield} ${SqlCommands.intType},
      ${DatabaseColumnNames.specialDefenseEvYield} ${SqlCommands.intType},
      ${DatabaseColumnNames.speedEvYield} ${SqlCommands.intType}
    )
  ''');
  }

  Future<void> setupMockPokedexEntryNumbersTable() async {
    await database.execute('''
      CREATE TABLE ${DatabaseTableNames.pokedexEntryNumbers} (
      ${DatabaseColumnNames.pokedexId} INTEGER,
      ${DatabaseColumnNames.pokemonId} INTEGER,
      ${DatabaseColumnNames.entryNumber} INTEGER
    )
  ''');
  }

  Future<void> insertPokedex(int pokedexId, String pokedexName) async {
    await database.insert(DatabaseTableNames.pokedex, {
      DatabaseColumnNames.id: pokedexId,
      DatabaseColumnNames.name: pokedexName,
    });
  }

  Future<void> insertDetailedPokemon({
    int pokemonId = MockLocalPokemon.pokemonId,
    String pokemonName = MockLocalPokemon.pokemonName,
    String pokemonType1 = MockLocalPokemon.pokemonType1,
    String pokemonType2 = MockLocalPokemon.pokemonType2,
    String pokemonFrontSpriteUrl = MockLocalPokemon.pokemonFrontSpriteUrl,
    int hp = MockLocalPokemon.baseStatHp,
    int attack = MockLocalPokemon.baseStatAttack,
    int defense = MockLocalPokemon.baseStatDefense,
    int specialAttack = MockLocalPokemon.baseStatSpecialAttack,
    int specialDefense = MockLocalPokemon.baseStatSpecialDefense,
    int speed = MockLocalPokemon.baseStatSpeed,
    int hpEvYield = MockLocalPokemon.statEffortHp,
    int attackEvYield = MockLocalPokemon.statEffortAttack,
    int defenseEvYield = MockLocalPokemon.statEffortDefense,
    int specialAttackEvYield = MockLocalPokemon.statEffortSpecialAttack,
    int specialDefenseEvYield = MockLocalPokemon.statEffortSpecialDefense,
    int speedEvYield = MockLocalPokemon.statEffortSpeed,
  }) async {
    await database.insert(DatabaseTableNames.pokemon, {
      DatabaseColumnNames.id: pokemonId,
      DatabaseColumnNames.name: pokemonName,
      DatabaseColumnNames.types: '$pokemonType1,$pokemonType2',
      DatabaseColumnNames.frontSpriteUrl: pokemonFrontSpriteUrl,
      DatabaseColumnNames.hp: hp,
      DatabaseColumnNames.attack: attack,
      DatabaseColumnNames.defense: defense,
      DatabaseColumnNames.specialAttack: specialAttack,
      DatabaseColumnNames.specialDefense: specialDefense,
      DatabaseColumnNames.speed: speed,
      DatabaseColumnNames.hpEvYield: hpEvYield,
      DatabaseColumnNames.attackEvYield: attackEvYield,
      DatabaseColumnNames.defenseEvYield: defenseEvYield,
      DatabaseColumnNames.specialAttackEvYield: specialAttackEvYield,
      DatabaseColumnNames.specialDefenseEvYield: specialDefenseEvYield,
      DatabaseColumnNames.speedEvYield: speedEvYield,
    });
  }

  Future<void> insertUndetailedPokemon(
      int pokemonId, String pokemonName) async {
    await database.insert(DatabaseTableNames.pokemon, {
      DatabaseColumnNames.id: pokemonId,
      DatabaseColumnNames.name: pokemonName,
    });
  }

  Future<void> insertPokedexEntry(
      int pokedexId, int pokemonId, int pokemonEntryNumber) async {
    await database.insert(DatabaseTableNames.pokedexEntryNumbers, {
      DatabaseColumnNames.pokedexId: pokedexId,
      DatabaseColumnNames.pokemonId: pokemonId,
      DatabaseColumnNames.entryNumber: pokemonEntryNumber,
    });
  }

  Future close() async {
    await database.close();
  }
}
