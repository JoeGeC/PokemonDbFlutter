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

import '../mocks/mock_database.dart';
import 'pokedex_local_should.mocks.dart';

@GenerateMocks([PokedexLocalConverter, PokemonLocalConverter])
void main() {
  late Database database;
  late MockDatabase mockDatabase;
  late PokedexLocalImpl pokedexLocal;
  late MockPokedexLocalConverter mockPokedexConverter;
  late MockPokemonLocalConverter mockPokemonConverter;

  late PokemonLocalModel pokemonModel;
  late PokemonLocalModel pokemonModel2;
  late PokedexLocalModel multPokemonPokedexModel;
  late PokedexLocalModel pokedexModel1;
  late PokedexLocalModel noPokemonPokedexModel1;
  late PokedexLocalModel pokedexModel2;
  late List<PokedexLocalModel> noPokemonPokedexList;

  const int pokemonEntryNumber = 5;
  const int pokedexId1 = 11;
  const int pokedexId2 = 12;
  const String pokedexName1 = "original-johto";
  const String pokedexName2 = "Sample pokedex";
  const int pokemonId = 1;
  const String pokemonName = "Sample Pokemon";
  const String pokemonType1 = "Grass";
  const String pokemonType2 = "Flying";
  const String pokemonType3 = "Poison";
  const String pokemonFrontSpriteUrl = "https://example.com/example.png";
  const pokemonId2 = 20;
  const pokemonName2 = "SecondPokemon";
  const pokemonEntryNumber2 = 6;
  final Left<DataFailure, List<PokedexLocalModel>> expectedFailure =
      Left(DataFailure("No data"));

  setUp(() async {
    sqfliteFfiInit();
    mockPokedexConverter = MockPokedexLocalConverter();
    mockPokemonConverter = MockPokemonLocalConverter();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockDatabase = MockDatabase(database);
    pokemonModel = PokemonLocalModel(
        id: pokemonId,
        name: pokemonName,
        pokedexEntryNumbers: {pokedexId1: pokemonEntryNumber},
        types: [pokemonType1, pokemonType2],
        frontSpriteUrl: pokemonFrontSpriteUrl);
    pokemonModel2 = PokemonLocalModel(
      id: pokemonId2,
      name: pokemonName2,
      types: [pokemonType3],
      frontSpriteUrl: null,
      pokedexEntryNumbers: {pokedexId1: pokemonEntryNumber2},
    );
    multPokemonPokedexModel =
        PokedexLocalModel(id: pokedexId1, name: pokedexName1, pokemon: [
      pokemonModel,
      pokemonModel2,
    ]);
    pokedexModel1 = PokedexLocalModel(
        id: pokedexId1, name: pokedexName1, pokemon: [pokemonModel]);
    noPokemonPokedexModel1 =
        PokedexLocalModel(id: pokedexId1, name: pokedexName1);
    pokedexModel2 = PokedexLocalModel(id: pokedexId2, name: pokedexName2);
    noPokemonPokedexList = [noPokemonPokedexModel1, pokedexModel2];

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
      await mockDatabase.insertPokedex(pokedexId1, pokedexName1);
      await mockDatabase.insertDetailedPokemon(pokemonId, pokemonName,
          pokemonType1, pokemonType2, pokemonFrontSpriteUrl);
      await mockDatabase.insertPokedexEntry(
          pokedexId1, pokemonId, pokemonEntryNumber);

      final result = await pokedexLocal.get(pokedexId1);

      final expected = Right(pokedexModel1);
      expect(result, expected);
    });

    test('return DataFailure when no data is found', () async {
      final result = await pokedexLocal.get(pokedexId1);

      expect(result, expectedFailure);
    });
  });

  group('get all pokedexes', () {
    test('return PokedexLocalModel list when data is found', () async {
      await mockDatabase.insertPokedex(pokedexId1, pokedexName1);
      await mockDatabase.insertPokedex(pokedexId2, pokedexName2);
      await mockDatabase.insertDetailedPokemon(pokemonId, pokemonName,
          pokemonType1, pokemonType2, pokemonFrontSpriteUrl);
      await mockDatabase.insertPokedexEntry(
          pokedexId1, pokemonId, pokemonEntryNumber);

      final result = await pokedexLocal.getAll();

      final resultList = result.getOrElse(() => throw Exception());
      expect(resultList, noPokemonPokedexList);
      expect(result.isRight(), true);
    });

    test('return failure when no data', () async {
      final result = await pokedexLocal.getAll();

      expect(result, expectedFailure);
    });
  });

  group('store', () {
    const pokedexMap1 = {
      DatabaseColumnNames.id: pokedexId1,
      DatabaseColumnNames.name: pokedexName1,
    };

    const pokedexMap2 = {
      DatabaseColumnNames.id: pokedexId2,
      DatabaseColumnNames.name: pokedexName2,
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
      DatabaseColumnNames.pokedexId: pokedexId1,
      DatabaseColumnNames.entryNumber: pokemonEntryNumber,
    };

    group('store pokedex', () {
      test('store pokedex with pokemon', () async {
        when(mockPokedexConverter.convert(pokedexModel1))
            .thenReturn(pokedexMap1);
        when(mockPokemonConverter.convert(pokemonModel)).thenReturn(pokemonMap);

        await pokedexLocal.store(pokedexModel1);

        final pokedexFromDatabase =
            await database.query(DatabaseTableNames.pokedex);
        expect(pokedexFromDatabase, hasLength(1));
        expect(pokedexFromDatabase.first, pokedexMap1);

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
        const newPokedexModel = PokedexLocalModel(
            id: pokedexId1, name: newPokedexName, pokemon: []);
        final pokedexMap = {
          DatabaseColumnNames.id: pokedexId1,
          DatabaseColumnNames.name: newPokedexName,
        };
        when(mockPokedexConverter.convert(newPokedexModel))
            .thenReturn(pokedexMap);
        database.insert(DatabaseTableNames.pokedex, pokedexMap1);

        await pokedexLocal.store(newPokedexModel);

        final pokedexFromDatabase =
            await database.query(DatabaseTableNames.pokedex);
        expect(pokedexFromDatabase, hasLength(1));
        expect(pokedexFromDatabase.first[DatabaseColumnNames.name],
            newPokedexName);
      });

      test('ignores duplicate pokemon data', () async {
        when(mockPokedexConverter.convert(pokedexModel1))
            .thenReturn(pokedexMap1);
        when(mockPokemonConverter.convert(pokemonModel)).thenReturn(pokemonMap);
        await pokedexLocal.store(pokedexModel1);
        await pokedexLocal.store(pokedexModel1);

        final pokemonRows = await database.query(DatabaseTableNames.pokemon);

        expect(pokemonRows, hasLength(1));
      });

      test('stores multiple pokemon in a single batch', () async {
        when(mockPokedexConverter.convert(multPokemonPokedexModel))
            .thenReturn(pokedexMap1);
        when(mockPokemonConverter.convert(pokemonModel)).thenReturn(pokemonMap);
        when(mockPokemonConverter.convert(pokemonModel2))
            .thenReturn(pokemon2Map);

        await pokedexLocal.store(multPokemonPokedexModel);

        final pokemonFromDatabase =
            await database.query(DatabaseTableNames.pokemon);
        expect(pokemonFromDatabase, hasLength(2));
        expect(pokemonFromDatabase.map((row) => row[DatabaseColumnNames.name]),
            containsAll([pokemonName, pokemonName2]));
      });

      test('not store pokemon when null', () async {
        var nullPokemonPokedexModel = PokedexLocalModel(
            id: pokedexId1, name: pokedexName1, pokemon: null);
        when(mockPokedexConverter.convert(nullPokemonPokedexModel))
            .thenReturn(pokedexMap1);

        await pokedexLocal.store(nullPokemonPokedexModel);

        final pokedexFromDatabase =
            await database.query(DatabaseTableNames.pokedex);
        expect(pokedexFromDatabase, hasLength(1));
        expect(pokedexFromDatabase.first, pokedexMap1);
        final pokemonFromDatabase =
            await database.query(DatabaseTableNames.pokemon);
        expect(pokemonFromDatabase, hasLength(0));
        final pokedexEntriesFromDatabase =
            await database.query(DatabaseTableNames.pokedexEntryNumbers);
        expect(pokedexEntriesFromDatabase, hasLength(0));
      });
    });

    group('store list', () {
      test('store list of pokedexes', () async {
        when(mockPokedexConverter.convert(noPokemonPokedexModel1))
            .thenReturn(pokedexMap1);
        when(mockPokedexConverter.convert(pokedexModel2))
            .thenReturn(pokedexMap2);

        await pokedexLocal.storeList(noPokemonPokedexList);

        final pokedexFromDatabase =
            await database.query(DatabaseTableNames.pokedex);
        expect(pokedexFromDatabase, hasLength(2));
        expect(pokedexFromDatabase.first, pokedexMap1);
        expect(pokedexFromDatabase[1], pokedexMap2);

        final pokemonFromDatabase =
            await database.query(DatabaseTableNames.pokemon);
        expect(pokemonFromDatabase, hasLength(0));

        final pokedexEntryFromDatabase =
            await database.query(DatabaseTableNames.pokedexEntryNumbers);
        expect(pokedexEntryFromDatabase, hasLength(0));
      });

      test('replaces existing pokedex data on conflict', () async {
        const newPokedexName = "new-pokedex-name";
        const newPokedexModel =
            PokedexLocalModel(id: pokedexId1, name: newPokedexName);
        final newPokedexMap = {
          DatabaseColumnNames.id: pokedexId1,
          DatabaseColumnNames.name: newPokedexName,
        };

        when(mockPokedexConverter.convert(newPokedexModel))
            .thenReturn(newPokedexMap);
        database.insert(DatabaseTableNames.pokedex, pokedexMap1);

        await pokedexLocal.storeList([newPokedexModel]);

        final pokedexFromDatabase =
            await database.query(DatabaseTableNames.pokedex);
        expect(pokedexFromDatabase, hasLength(1));
        expect(pokedexFromDatabase.first[DatabaseColumnNames.name],
            newPokedexName);
      });
    });
  });
}
