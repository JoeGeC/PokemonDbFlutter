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
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.hp} AS ${DatabaseColumnNames.hp},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.attack} AS ${DatabaseColumnNames.attack},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.defense} AS ${DatabaseColumnNames.defense},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.specialAttack} AS ${DatabaseColumnNames.specialAttack},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.specialDefense} AS ${DatabaseColumnNames.specialDefense},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.speed} AS ${DatabaseColumnNames.speed},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.hpEvYield} AS ${DatabaseColumnNames.hpEvYield},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.attackEvYield} AS ${DatabaseColumnNames.attackEvYield},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.defenseEvYield} AS ${DatabaseColumnNames.defenseEvYield},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.specialAttackEvYield} AS ${DatabaseColumnNames.specialAttackEvYield},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.specialDefenseEvYield} AS ${DatabaseColumnNames.specialDefenseEvYield},
           ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.speedEvYield} AS ${DatabaseColumnNames.speedEvYield},
           ${DatabaseTableNames.pokedexEntryNumbers}.${DatabaseColumnNames.pokedexId} AS ${DatabaseColumnNames.pokedexId},
           ${DatabaseTableNames.pokedexEntryNumbers}.${DatabaseColumnNames.entryNumber} AS ${DatabaseColumnNames.entryNumber}
    FROM ${DatabaseTableNames.pokemon} ${DatabaseTableNames.pokemon}
    LEFT JOIN ${DatabaseTableNames.pokedexEntryNumbers} ${DatabaseTableNames.pokedexEntryNumbers}
    ON ${DatabaseTableNames.pokemon}.${DatabaseColumnNames.id} = ${DatabaseTableNames.pokedexEntryNumbers}.${DatabaseColumnNames.pokemonId}
      ''';
}