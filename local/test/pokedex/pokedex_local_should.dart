import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local/converters/pokedex_local_converter.dart';
import 'package:local/converters/pokemon_local_converter.dart';
import 'package:local/database_constants.dart';
import 'package:local/pokedex/pokedex_local_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/models/data_failure.dart';
import 'package:repository/models/local/pokedex_local_model.dart';
import 'package:repository/models/local/pokemon_local_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'pokedex_local_should.mocks.dart';

@GenerateMocks([PokedexLocalConverter, PokemonLocalConverter])
void main() {
  late Database database;
  late PokedexLocalImpl pokedexLocal;
  late MockPokedexLocalConverter mockPokedexConverter;
  late MockPokemonLocalConverter mockPokemonConverter;

  const int pokemonEntryNumber = 5;
  const int pokedexId = 3;
  const String pokedexName = "original-johto";
  const int pokemonId = 1;
  const String pokemonName = "Sample Pokemon";
  const String pokemonType1 = "Grass";
  const String pokemonType2 = "Flying";
  const String pokemonFrontSpriteUrl = "https://example.com/example.png";
  const PokemonLocalModel pokemonModel = PokemonLocalModel(
      id: pokemonId,
      name: pokemonName,
      pokedexEntryNumbers: {pokedexName: pokemonEntryNumber},
      types: [pokemonType1, pokemonType2],
      frontSpriteUrl: pokemonFrontSpriteUrl);
  const PokedexLocalModel pokedexModel =
      PokedexLocalModel(pokedexId, pokedexName, [pokemonModel]);

  setUp(() async {
    mockPokedexConverter = MockPokedexLocalConverter();
    mockPokemonConverter = MockPokemonLocalConverter();
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    await setupMockPokedexTable(database);
    await setupMockPokemonTable(database);
    await setupMockPokedexEntryNumbersTable(database);
    pokedexLocal =
        PokedexLocalImpl(database, mockPokedexConverter, mockPokemonConverter);
  });

  tearDown(() async {
    await database.close();
  });

  group('get pokedex', () {
    test('return PokedexLocalModel when data is found', () async {
      await populatePokedexTable(database, pokedexId, pokedexName);
      await populatePokemonTable(database, pokemonId, pokemonName, pokemonType1,
          pokemonType2, pokemonFrontSpriteUrl);
      await populatePokedexEntryNumbersTable(
          database, pokedexName, pokemonId, pokemonEntryNumber);

      final result = await pokedexLocal.get(pokedexId);

      final expected = Right(pokedexModel);
      expect(result, expected);
    });

    test('return DataFailure when no data is found', () async {
      final result = await pokedexLocal.get(pokedexId);

      final expected = Left(DataFailure("No data"));
      expect(result, expected);
    });
  });

  group('store data', () {
    test('store pokedex with pokemon', () async {
      final pokedexMap = {
        DatabaseColumnNames.id: pokedexId,
        DatabaseColumnNames.name: pokedexName,
      };

      final pokemonMap = {
        DatabaseColumnNames.id: pokemonId,
        DatabaseColumnNames.name: pokemonName,
        DatabaseColumnNames.types: "$pokemonType1,$pokemonType2",
        DatabaseColumnNames.frontSpriteUrl: pokemonFrontSpriteUrl,
      };

      final pokedexEntryMap = {
        DatabaseColumnNames.pokemonId: pokemonId,
        DatabaseColumnNames.pokedexName: pokedexName,
        DatabaseColumnNames.entryNumber: pokemonEntryNumber,
      };

      when(mockPokedexConverter.convert(pokedexModel)).thenReturn(pokedexMap);
      when(mockPokemonConverter.convert(pokemonModel)).thenReturn(pokemonMap);
      await pokedexLocal.store(pokedexModel);

      final pokedexFromDatabase =
          await database.query(DatabaseTableNames.pokedex);
      expect(pokedexFromDatabase, hasLength(1));
      expect(pokedexFromDatabase.first, pokedexMap);

      final pokemonFromDatabase =
          await database.query(DatabaseTableNames.pokemon);
      expect(pokemonFromDatabase, hasLength(1));
      expect(pokemonFromDatabase.first, pokemonMap);

      final pokedexEntryFromDatabase =
          await database.query(DatabaseTableNames.pokedexEntryNumbers);
      expect(pokedexEntryFromDatabase, hasLength(1));
      expect(pokedexEntryFromDatabase.first, pokedexEntryMap);
    });

    test('replaces existing pokedex data on conflict', () async {
      const newPokedexName = "new-pokedex-name";
      const newPokedexModel = PokedexLocalModel(pokedexId, newPokedexName, []);
      final pokedexMap = {
        DatabaseColumnNames.id: pokedexId,
        DatabaseColumnNames.name: newPokedexName,
      };

      when(mockPokedexConverter.convert(newPokedexModel))
          .thenReturn(pokedexMap);
      await pokedexLocal.store(newPokedexModel);

      final pokedexFromDatabase =
          await database.query(DatabaseTableNames.pokedex);
      expect(pokedexFromDatabase, hasLength(1));
      expect(
          pokedexFromDatabase.first[DatabaseColumnNames.name], newPokedexName);
    });
  });
}

Future<void> populatePokedexTable(
    Database database, int pokedexId, String pokedexName) async {
  await database.insert(DatabaseTableNames.pokedex, {
    DatabaseColumnNames.id: pokedexId,
    DatabaseColumnNames.name: pokedexName,
  });
}

Future<void> populatePokemonTable(
    Database database,
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

Future<void> populatePokedexEntryNumbersTable(Database database,
    String pokedexName, int pokemonId, int pokemonEntryNumber) async {
  await database.insert(DatabaseTableNames.pokedexEntryNumbers, {
    DatabaseColumnNames.pokedexName: pokedexName,
    DatabaseColumnNames.pokemonId: pokemonId,
    DatabaseColumnNames.entryNumber: pokemonEntryNumber,
  });
}

Future<void> setupMockPokedexTable(Database database) async {
  await database.execute('''
      CREATE TABLE ${DatabaseTableNames.pokedex} (
      ${DatabaseColumnNames.id} INTEGER PRIMARY KEY,
      ${DatabaseColumnNames.name} TEXT
    )
  ''');
}

Future<void> setupMockPokemonTable(Database database) async {
  await database.execute('''
      CREATE TABLE ${DatabaseTableNames.pokemon} (
      ${DatabaseColumnNames.id} INTEGER PRIMARY KEY,
      ${DatabaseColumnNames.name} TEXT,
      ${DatabaseColumnNames.types} TEXT,
      ${DatabaseColumnNames.frontSpriteUrl} TEXT
    )
  ''');
}

Future<void> setupMockPokedexEntryNumbersTable(Database database) async {
  await database.execute('''
      CREATE TABLE ${DatabaseTableNames.pokedexEntryNumbers} (
      ${DatabaseColumnNames.pokedexName} TEXT,
      ${DatabaseColumnNames.pokemonId} INTEGER,
      ${DatabaseColumnNames.entryNumber} INTEGER
    )
  ''');
}
