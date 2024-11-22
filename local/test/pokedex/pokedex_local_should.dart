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

import '../mock_database.dart';
import 'pokedex_local_should.mocks.dart';

@GenerateMocks([PokedexLocalConverter, PokemonLocalConverter])
void main() {
  late Database database;
  late MockDatabase mockDatabase;
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
  const String pokemonType3 = "Poison";
  const String pokemonFrontSpriteUrl = "https://example.com/example.png";
  const pokemonId2 = 20;
  const pokemonName2 = "SecondPokemon";
  const pokemonEntryNumber2 = 6;
  late PokedexLocalModel pokedexModel;
  late PokemonLocalModel pokemonModel;
  late PokemonLocalModel pokemonModel2;
  late PokedexLocalModel multPokemonPokedexModel;

  setUp(() async {
    sqfliteFfiInit();
    mockPokedexConverter = MockPokedexLocalConverter();
    mockPokemonConverter = MockPokemonLocalConverter();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockDatabase = MockDatabase(database);
    pokemonModel = PokemonLocalModel(
        id: pokemonId,
        name: pokemonName,
        pokedexEntryNumbers: {pokedexName: pokemonEntryNumber},
        types: [pokemonType1, pokemonType2],
        frontSpriteUrl: pokemonFrontSpriteUrl);
    pokemonModel2 = PokemonLocalModel(
      id: pokemonId2,
      name: pokemonName2,
      types: [pokemonType3],
      frontSpriteUrl: null,
      pokedexEntryNumbers: {pokedexName: pokemonEntryNumber2},
    );
    pokedexModel = PokedexLocalModel(pokedexId, pokedexName, [pokemonModel]);
    multPokemonPokedexModel = PokedexLocalModel(pokedexId, pokedexName, [
      pokemonModel,
      pokemonModel2,
    ]);

    await mockDatabase.setupMockPokedexTable();
    await mockDatabase.setupMockPokemonTable();
    await mockDatabase.setupMockPokedexEntryNumbersTable();
    pokedexLocal =
        PokedexLocalImpl(database, mockPokedexConverter, mockPokemonConverter);
  });

  tearDown(() async {
    await mockDatabase.close();
  });

  group('get pokedex', () {
    test('return PokedexLocalModel when data is found', () async {
      await mockDatabase.populatePokedexTable(pokedexId, pokedexName);
      await mockDatabase.populatePokemonTable(pokemonId, pokemonName,
          pokemonType1, pokemonType2, pokemonFrontSpriteUrl);
      await mockDatabase.populatePokedexEntryNumbersTable(
          pokedexName, pokemonId, pokemonEntryNumber);

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
    const pokedexMap = {
      DatabaseColumnNames.id: pokedexId,
      DatabaseColumnNames.name: pokedexName,
    };

    const pokemonMap = {
      DatabaseColumnNames.id: pokemonId,
      DatabaseColumnNames.name: pokemonName,
      DatabaseColumnNames.types: "$pokemonType1,$pokemonType2",
      DatabaseColumnNames.frontSpriteUrl: pokemonFrontSpriteUrl,
    };

    const pokemon2Map = {
      DatabaseColumnNames.id: pokemonId2,
      DatabaseColumnNames.name: pokemonName2,
      DatabaseColumnNames.types: pokemonType3,
    };

    const pokedexEntryMap = {
      DatabaseColumnNames.pokemonId: pokemonId,
      DatabaseColumnNames.pokedexName: pokedexName,
      DatabaseColumnNames.entryNumber: pokemonEntryNumber,
    };

    test('store pokedex with pokemon', () async {
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

    test('ignores duplicate pokemon data', () async {
      when(mockPokedexConverter.convert(pokedexModel)).thenReturn(pokedexMap);
      when(mockPokemonConverter.convert(pokemonModel)).thenReturn(pokemonMap);
      await pokedexLocal.store(pokedexModel);
      await pokedexLocal.store(pokedexModel);

      final pokemonRows = await database.query(DatabaseTableNames.pokemon);

      expect(pokemonRows, hasLength(1));
    });

    test('stores multiple pokemon in a single batch', () async {
      when(mockPokedexConverter.convert(multPokemonPokedexModel))
          .thenReturn(pokedexMap);
      when(mockPokemonConverter.convert(pokemonModel)).thenReturn(pokemonMap);
      when(mockPokemonConverter.convert(pokemonModel2)).thenReturn(pokemon2Map);

      await pokedexLocal.store(multPokemonPokedexModel);

      final pokemonFromDatabase =
          await database.query(DatabaseTableNames.pokemon);
      expect(pokemonFromDatabase, hasLength(2));
      expect(pokemonFromDatabase.map((row) => row[DatabaseColumnNames.name]),
          containsAll([pokemonName, pokemonName2]));
    });
  });
}
