import 'package:flutter_test/flutter_test.dart';
import 'package:local/database_constants.dart';
import 'package:local/database_initializer.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  setUpAll(() {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  });

  test('DatabaseInitializer creates all tables correctly', () async {
    final database = await DatabaseInitializer.instance.database;

    final pokedexTable = await database.rawQuery(
      "PRAGMA table_info(${DatabaseTableNames.pokedex});",
    );
    expect(pokedexTable, isNotEmpty);
    expect(
      pokedexTable.map((column) => column['name']),
      containsAll([DatabaseColumnNames.id, DatabaseColumnNames.name]),
    );

    final pokemonTable = await database.rawQuery(
      "PRAGMA table_info(${DatabaseTableNames.pokemon});",
    );
    expect(pokemonTable, isNotEmpty);
    expect(
      pokemonTable.map((column) => column['name']),
      containsAll([
        DatabaseColumnNames.id,
        DatabaseColumnNames.name,
        DatabaseColumnNames.types,
        DatabaseColumnNames.frontSpriteUrl,
        DatabaseColumnNames.artworkUrl,
        DatabaseColumnNames.hp,
        DatabaseColumnNames.attack,
        DatabaseColumnNames.defense,
        DatabaseColumnNames.specialAttack,
        DatabaseColumnNames.specialDefense,
        DatabaseColumnNames.speed,
        DatabaseColumnNames.hpEvYield,
        DatabaseColumnNames.attackEvYield,
        DatabaseColumnNames.defenseEvYield,
        DatabaseColumnNames.specialAttackEvYield,
        DatabaseColumnNames.specialDefenseEvYield,
        DatabaseColumnNames.speedEvYield,
      ]),
    );

    final pokedexEntryTable = await database.rawQuery(
      "PRAGMA table_info(${DatabaseTableNames.pokedexEntryNumbers});",
    );
    expect(pokedexEntryTable, isNotEmpty);
    expect(
      pokedexEntryTable.map((column) => column['name']),
      containsAll([
        DatabaseColumnNames.pokemonId,
        DatabaseColumnNames.pokedexId,
        DatabaseColumnNames.entryNumber,
      ]),
    );

    await database.close();
  });
}
