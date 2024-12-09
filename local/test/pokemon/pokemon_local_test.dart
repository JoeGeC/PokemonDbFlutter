import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local/converters/pokemon_local_converter.dart';
import 'package:local/database_constants.dart';
import 'package:local/pokemon/pokemon_local_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/models/data_failure.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../pokedex/pokedex_local_test.mocks.dart';
import '../../../test/mocks/mock_database.dart';
import '../../../test/mocks/mock_pokedex.dart';
import '../../../test/mocks/mock_pokemon.dart';

@GenerateMocks([PokemonLocalConverter])
void main() {
  late Database database;
  late MockDatabase mockDatabase;
  late PokemonLocalImpl pokemonLocal;
  late MockPokemonLocalConverter mockPokemonConverter;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockDatabase = MockDatabase(database);
    await mockDatabase.setupMockPokemonTable();
    await mockDatabase.setupMockPokedexEntryNumbersTable();
    mockPokemonConverter = MockPokemonLocalConverter();
    pokemonLocal = PokemonLocalImpl(database, mockPokemonConverter);
  });

  tearDown(() async {
    await database.close();
  });

  group('GetPokemon', () {
    test('return PokemonLocalModel when data is found', () async {
      await mockDatabase.insertDetailedPokemon();
      await mockDatabase.insertPokedexEntry(
        MockLocalPokedex.pokedexId1,
        MockLocalPokemon.pokemonId,
        MockLocalPokemon.pokedexEntryNumber1,
      );

      when(mockPokemonConverter.convertFromDatabase(any, any))
          .thenReturn(MockLocalPokemon.pokemon);

      var result = await pokemonLocal.get(MockLocalPokemon.pokemonId);

      expect(result, Right(MockLocalPokemon.pokemon));
    });

    test('return PokemonLocalModel when multiple pokedex entries found',
        () async {
      await mockDatabase.insertDetailedPokemon();
      await mockDatabase.insertPokedexEntry(
        MockLocalPokedex.pokedexId1,
        MockLocalPokemon.pokemonId,
        MockLocalPokemon.pokedexEntryNumber1,
      );
      await mockDatabase.insertPokedexEntry(
        MockLocalPokedex.pokedexId2,
        MockLocalPokemon.pokemonId,
        MockLocalPokemon.pokedexEntryNumber2,
      );

      when(mockPokemonConverter.convertFromDatabase(any, any))
          .thenReturn(MockLocalPokemon.pokemon);

      var result = await pokemonLocal.get(MockLocalPokemon.pokemonId);

      expect(result, Right(MockLocalPokemon.pokemonWithMultiplePokedexEntries));
    });

    test('return DataFailure when no data is found', () async {
      final result = await pokemonLocal.get(MockLocalPokemon.pokemonId);

      final expected = Left(DataFailure("No data"));
      expect(result, expected);
    });
  });

  group('StorePokemon', () {
    test('store pokemon when no data', () async {
      when(mockPokemonConverter.convertToDatabase(MockLocalPokemon.pokemon))
          .thenReturn(MockLocalPokemon.pokemonMap);

      await pokemonLocal.store(MockLocalPokemon.pokemon);

      final pokemonFromDatabase =
          await database.query(DatabaseTableNames.pokemon);
      expect(pokemonFromDatabase, hasLength(1));
      expect(pokemonFromDatabase.first, MockLocalPokemon.pokemonMap);
    });

    test('store pokemon details when pokemon in database but undetailed',
        () async {
      mockDatabase.insertUndetailedPokemon(
          MockLocalPokemon.pokemonId, MockLocalPokemon.pokemonName);

      when(mockPokemonConverter.convertToDatabase(MockLocalPokemon.pokemon))
          .thenReturn(MockLocalPokemon.pokemonMap);

      await pokemonLocal.store(MockLocalPokemon.pokemon);

      final pokemonFromDatabase =
          await database.query(DatabaseTableNames.pokemon);
      expect(pokemonFromDatabase, hasLength(1));
      expect(pokemonFromDatabase.first, MockLocalPokemon.pokemonMap);
    });

    test('store pokemon details when pokemon in database but undetailed',
        () async {
      mockDatabase.insertUndetailedPokemon(
          MockLocalPokemon.pokemonId, MockLocalPokemon.pokemonName);

      when(mockPokemonConverter.convertToDatabase(MockLocalPokemon.pokemon))
          .thenReturn(MockLocalPokemon.pokemonMap);

      await pokemonLocal.store(MockLocalPokemon.pokemon);

      final pokemonFromDatabase =
          await database.query(DatabaseTableNames.pokemon);
      expect(pokemonFromDatabase, hasLength(1));
      expect(pokemonFromDatabase.first, MockLocalPokemon.pokemonMap);
    });
  });
}
