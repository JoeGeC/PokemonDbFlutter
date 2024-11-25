import 'database_constants.dart';

class SqlCommands {
  static const String intPrimaryKey = 'INTEGER PRIMARY KEY';
  static const String foreignKey = 'FOREIGN KEY';

  static const String references = 'REFERENCES';

  static const String textType = 'TEXT';
  static const String intType = 'int';
  static const String textNonNullType = 'TEXT NON NULL';

  static const String createTable = 'CREATE TABLE';
  static const String select = 'SELECT';

  static const String onDelete = 'ON DELETE';
  static const String cascade = 'CASCADE';

  static const String selectPokemonWithEntryNumbers = '''
    SELECT ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.id} AS ${DatabaseColumnNames.pokemonId},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.name} AS ${DatabaseColumnNames.pokemonName},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.types} AS ${DatabaseColumnNames.pokemonTypes},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.frontSpriteUrl} AS ${DatabaseColumnNames.frontSpriteUrl},
           ${DatabaseTableNames.pokedexEntryNumbers}.${DatabaseColumnNames.pokedexName} AS ${DatabaseColumnNames.pokedexName},
           ${DatabaseTableNames.pokedexEntryNumbers}.${DatabaseColumnNames.entryNumber} AS ${DatabaseColumnNames.entryNumber}
    FROM ${DatabaseTableNames.pokemon} ${DatabaseTableNames.pokemon}
    LEFT JOIN ${DatabaseTableNames.pokedexEntryNumbers} ${DatabaseTableNames.pokedexEntryNumbers}
    ON ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.id} = ${DatabaseTableNames.pokedexEntryNumbers}.${DatabaseColumnNames.pokemonId}
      ''';
}