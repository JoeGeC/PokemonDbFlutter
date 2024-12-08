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
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../../test/mocks/mock_database.dart';
import '../../../test/mocks/mock_pokedex.dart';
import '../../../test/mocks/mock_pokemon.dart';
import 'pokedex_local_should.mocks.dart';

@GenerateMocks([PokedexLocalConverter, PokemonLocalConverter])
void main() {
  late Database database;
  late MockDatabase mockDatabase;
  late PokedexLocalImpl pokedexLocal;
  late MockPokedexLocalConverter mockPokedexConverter;
  late MockPokemonLocalConverter mockPokemonConverter;

  final Left<DataFailure, List<PokedexLocalModel>> expectedFailure =
      Left(DataFailure("No data"));

  setUp(() async {
    sqfliteFfiInit();
    mockPokedexConverter = MockPokedexLocalConverter();
    mockPokemonConverter = MockPokemonLocalConverter();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockDatabase = MockDatabase(database);

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
      await mockDatabase.insertPokedex(
          MockLocalPokedex.pokedexId1, MockLocalPokedex.pokedexName1);
      await mockDatabase.insertDetailedPokemon();
      await mockDatabase.insertPokedexEntry(MockLocalPokedex.pokedexId1,
          MockLocalPokemon.pokemonId, MockLocalPokemon.pokedexEntryNumber1);

      final result = await pokedexLocal.get(MockLocalPokedex.pokedexId1);

      final expected = Right(MockLocalPokedex.pokedexModel1);
      expect(result, expected);
    });

    test('return DataFailure when no data is found', () async {
      final result = await pokedexLocal.get(MockLocalPokedex.pokedexId1);

      expect(result, expectedFailure);
    });
  });

  group('get all pokedexes', () {
    test('return PokedexLocalModel list when data is found', () async {
      await mockDatabase.insertPokedex(
          MockLocalPokedex.pokedexId1, MockLocalPokedex.pokedexName1);
      await mockDatabase.insertPokedex(
          MockLocalPokedex.pokedexId2, MockLocalPokedex.pokedexName2);
      await mockDatabase.insertDetailedPokemon();
      await mockDatabase.insertPokedexEntry(MockLocalPokedex.pokedexId1,
          MockLocalPokemon.pokemonId, MockLocalPokemon.pokedexEntryNumber1);

      final result = await pokedexLocal.getAll();

      final resultList = result.getOrElse(() => throw Exception());
      expect(resultList, MockLocalPokedex.noPokemonPokedexList);
      expect(result.isRight(), true);
    });

    test('return failure when no data', () async {
      final result = await pokedexLocal.getAll();

      expect(result, expectedFailure);
    });
  });

  group('store', () {
    group('store pokedex', () {
      test('store pokedex with pokemon', () async {
        when(mockPokedexConverter.convert(MockLocalPokedex.pokedexModel1))
            .thenReturn(MockLocalPokedex.pokedexMap1);
        when(mockPokemonConverter.convertToDatabase(MockLocalPokemon.pokemon))
            .thenReturn(MockLocalPokemon.undetailedPokemonMap);

        await pokedexLocal.store(MockLocalPokedex.pokedexModel1);

        final pokedexFromDatabase =
            await database.query(DatabaseTableNames.pokedex);
        expect(pokedexFromDatabase, hasLength(1));
        expect(pokedexFromDatabase.first, MockLocalPokedex.pokedexMap1);

        final pokemonFromDatabase =
            await database.query(DatabaseTableNames.pokemon);
        expect(pokemonFromDatabase, hasLength(1));
        expect(
            pokemonFromDatabase.first, MockLocalPokemon.undetailedPokemonMap);

        final pokedexEntryFromDatabase =
            await database.query(DatabaseTableNames.pokedexEntryNumbers);
        expect(pokedexEntryFromDatabase, hasLength(1));
        expect(
            pokedexEntryFromDatabase.first, MockLocalPokemon.pokedexEntryMap);
      });

      test('replaces existing pokedex data on conflict', () async {
        const newPokedexName = "new-pokedex-name";
        const newPokedexModel = PokedexLocalModel(
            id: MockLocalPokedex.pokedexId1, name: newPokedexName, pokemon: []);
        final pokedexMap = {
          DatabaseColumnNames.id: MockLocalPokedex.pokedexId1,
          DatabaseColumnNames.name: newPokedexName,
        };
        when(mockPokedexConverter.convert(newPokedexModel))
            .thenReturn(pokedexMap);
        database.insert(
            DatabaseTableNames.pokedex, MockLocalPokedex.pokedexMap1);

        await pokedexLocal.store(newPokedexModel);

        final pokedexFromDatabase =
            await database.query(DatabaseTableNames.pokedex);
        expect(pokedexFromDatabase, hasLength(1));
        expect(pokedexFromDatabase.first[DatabaseColumnNames.name],
            newPokedexName);
      });

      test('ignores duplicate pokemon data', () async {
        when(mockPokedexConverter.convert(MockLocalPokedex.pokedexModel1))
            .thenReturn(MockLocalPokedex.pokedexMap1);
        when(mockPokemonConverter.convertToDatabase(MockLocalPokemon.pokemon))
            .thenReturn(MockLocalPokemon.undetailedPokemonMap);
        await pokedexLocal.store(MockLocalPokedex.pokedexModel1);
        await pokedexLocal.store(MockLocalPokedex.pokedexModel1);

        final pokemonRows = await database.query(DatabaseTableNames.pokemon);

        expect(pokemonRows, hasLength(1));
      });

      test('stores multiple pokemon in a single batch', () async {
        when(mockPokedexConverter
                .convert(MockLocalPokedex.multPokemonPokedexModel))
            .thenReturn(MockLocalPokedex.pokedexMap1);
        when(mockPokemonConverter.convertToDatabase(MockLocalPokemon.pokemon))
            .thenReturn(MockLocalPokemon.undetailedPokemonMap);
        when(mockPokemonConverter.convertToDatabase(MockLocalPokemon.pokemon2))
            .thenReturn(MockLocalPokemon.undetailedPokemonMap2);

        await pokedexLocal.store(MockLocalPokedex.multPokemonPokedexModel);

        final pokemonFromDatabase =
            await database.query(DatabaseTableNames.pokemon);
        expect(pokemonFromDatabase, hasLength(2));
        expect(
            pokemonFromDatabase.map((row) => row[DatabaseColumnNames.name]),
            containsAll(
                [MockLocalPokemon.pokemonName, MockLocalPokemon.pokemonName2]));
      });

      test('not store pokemon when null', () async {
        var nullPokemonPokedexModel = PokedexLocalModel(
            id: MockLocalPokedex.pokedexId1,
            name: MockLocalPokedex.pokedexName1,
            pokemon: null);
        when(mockPokedexConverter.convert(nullPokemonPokedexModel))
            .thenReturn(MockLocalPokedex.pokedexMap1);

        await pokedexLocal.store(nullPokemonPokedexModel);

        final pokedexFromDatabase =
            await database.query(DatabaseTableNames.pokedex);
        expect(pokedexFromDatabase, hasLength(1));
        expect(pokedexFromDatabase.first, MockLocalPokedex.pokedexMap1);
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
        when(mockPokedexConverter
                .convert(MockLocalPokedex.noPokemonPokedexModel1))
            .thenReturn(MockLocalPokedex.pokedexMap1);
        when(mockPokedexConverter.convert(MockLocalPokedex.pokedexModel2))
            .thenReturn(MockLocalPokedex.pokedexMap2);

        await pokedexLocal.storeList(MockLocalPokedex.noPokemonPokedexList);

        final pokedexFromDatabase =
            await database.query(DatabaseTableNames.pokedex);
        expect(pokedexFromDatabase, hasLength(2));
        expect(pokedexFromDatabase.first, MockLocalPokedex.pokedexMap1);
        expect(pokedexFromDatabase[1], MockLocalPokedex.pokedexMap2);

        final pokemonFromDatabase =
            await database.query(DatabaseTableNames.pokemon);
        expect(pokemonFromDatabase, hasLength(0));

        final pokedexEntryFromDatabase =
            await database.query(DatabaseTableNames.pokedexEntryNumbers);
        expect(pokedexEntryFromDatabase, hasLength(0));
      });

      test('replaces existing pokedex data on conflict', () async {
        const newPokedexName = "new-pokedex-name";
        const newPokedexModel = PokedexLocalModel(
            id: MockLocalPokedex.pokedexId1, name: newPokedexName);
        final newPokedexMap = {
          DatabaseColumnNames.id: MockLocalPokedex.pokedexId1,
          DatabaseColumnNames.name: newPokedexName,
        };

        when(mockPokedexConverter.convert(newPokedexModel))
            .thenReturn(newPokedexMap);
        database.insert(
            DatabaseTableNames.pokedex, MockLocalPokedex.pokedexMap1);

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
