import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local/converters/pokemon_local_converter.dart';
import 'package:local/database_constants.dart';
import 'package:local/pokemon/pokemon_local_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/models/data_failure.dart';
import 'package:repository/models/local/pokemon_local_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../mocks/mock_database.dart';
import '../pokedex/pokedex_local_should.mocks.dart';

@GenerateMocks([PokemonLocalConverter])
void main() {
  late Database database;
  late MockDatabase mockDatabase;
  late PokemonLocalImpl pokemonLocal;
  late MockPokemonLocalConverter mockPokemonConverter;
  late PokemonLocalModel pokemonModel;
  late PokemonLocalModel pokemonModelWithMultiplePokedexEntries;

  const int pokemonId = 1;
  const String pokemonName = "Sample Pokemon";
  const String pokemonType1 = "Grass";
  const String pokemonType2 = "Poison";
  const String pokemonFrontSpriteUrl = "https://sample/pokemon.png";
  const int pokedexId1 = 11;
  const int pokedexEntryNumber1 = 5;
  const int pokedexId2 = 12;
  const int pokedexEntryNumber2 = 10;

  setUp(() async {
    sqfliteFfiInit();
    database = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    mockDatabase = MockDatabase(database);
    await mockDatabase.setupMockPokemonTable();
    await mockDatabase.setupMockPokedexEntryNumbersTable();
    mockPokemonConverter = MockPokemonLocalConverter();
    pokemonLocal = PokemonLocalImpl(database, mockPokemonConverter);
    pokemonModel = PokemonLocalModel(
        id: pokemonId,
        name: pokemonName,
        types: [pokemonType1, pokemonType2],
        frontSpriteUrl: pokemonFrontSpriteUrl,
        pokedexEntryNumbers: {pokedexId1: pokedexEntryNumber1});
    pokemonModelWithMultiplePokedexEntries = PokemonLocalModel(
        id: pokemonId,
        name: pokemonName,
        types: [pokemonType1, pokemonType2],
        frontSpriteUrl: pokemonFrontSpriteUrl,
        pokedexEntryNumbers: {
          pokedexId1: pokedexEntryNumber1,
          pokedexId2: pokedexEntryNumber2
        });
  });

  tearDown(() async {
    await database.close();
  });

  group('GetPokemon', () {
    test('return PokemonLocalModel when data is found', () async {
      await mockDatabase.insertDetailedPokemon(pokemonId, pokemonName,
          pokemonType1, pokemonType2, pokemonFrontSpriteUrl);
      await mockDatabase.insertPokedexEntry(
          pokedexId1, pokemonId, pokedexEntryNumber1);

      var result = await pokemonLocal.get(pokemonId);

      expect(result, Right(pokemonModel));
    });

    test('return PokemonLocalModel when multiple pokedex entries found',
        () async {
      await mockDatabase.insertDetailedPokemon(pokemonId, pokemonName,
          pokemonType1, pokemonType2, pokemonFrontSpriteUrl);
      await mockDatabase.insertPokedexEntry(
          pokedexId1, pokemonId, pokedexEntryNumber1);
      await mockDatabase.insertPokedexEntry(
          pokedexId2, pokemonId, pokedexEntryNumber2);

      var result = await pokemonLocal.get(pokemonId);

      expect(result, Right(pokemonModelWithMultiplePokedexEntries));
    });

    test('return DataFailure when no data is found', () async {
      final result = await pokemonLocal.get(pokemonId);

      final expected = Left(DataFailure("No data"));
      expect(result, expected);
    });
  });

  group('StorePokemon', () {
    const pokemonMap = {
      DatabaseColumnNames.id: pokemonId,
      DatabaseColumnNames.name: pokemonName,
      DatabaseColumnNames.types: "$pokemonType1,$pokemonType2",
      DatabaseColumnNames.frontSpriteUrl: pokemonFrontSpriteUrl,
    };

    test('store pokemon when no data', () async {
      when(mockPokemonConverter.convert(pokemonModel)).thenReturn(pokemonMap);

      await pokemonLocal.store(pokemonModel);

      final pokemonFromDatabase =
          await database.query(DatabaseTableNames.pokemon);
      expect(pokemonFromDatabase, hasLength(1));
      expect(pokemonFromDatabase.first, pokemonMap);
    });

    test('store pokemon details when pokemon in database but undetailed',
        () async {
      mockDatabase.insertUndetailedPokemon(pokemonId, pokemonName);

      when(mockPokemonConverter.convert(pokemonModel)).thenReturn(pokemonMap);

      await pokemonLocal.store(pokemonModel);

      final pokemonFromDatabase =
          await database.query(DatabaseTableNames.pokemon);
      expect(pokemonFromDatabase, hasLength(1));
      expect(pokemonFromDatabase.first, pokemonMap);
    });

    test('store pokemon details when pokemon in database but undetailed',
        () async {
      mockDatabase.insertUndetailedPokemon(pokemonId, pokemonName);

      when(mockPokemonConverter.convert(pokemonModel)).thenReturn(pokemonMap);

      await pokemonLocal.store(pokemonModel);

      final pokemonFromDatabase =
          await database.query(DatabaseTableNames.pokemon);
      expect(pokemonFromDatabase, hasLength(1));
      expect(pokemonFromDatabase.first, pokemonMap);
    });
  });
}
