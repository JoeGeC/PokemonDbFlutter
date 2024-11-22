import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:local/converters/pokemon_local_converter.dart';
import 'package:local/pokemon/pokemon_local_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:repository/models/local/pokemon_local_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../mock_database.dart';
import '../pokedex/pokedex_local_should.mocks.dart';

@GenerateMocks([PokemonLocalConverter])
void main() {
  late Database database;
  late MockDatabase mockDatabase;
  late PokemonLocalImpl pokemonLocal;
  late MockPokemonLocalConverter mockPokemonConverter;
  late PokemonLocalModel pokemonModel;

  const int pokemonId = 1;
  const String pokemonName = "Sample Pokemon";
  const String pokemonType1 = "Grass";
  const String pokemonType2 = "Poison";
  const String pokemonFrontSpriteUrl = "https://sample/pokemon.png";
  const String pokedexName = "sample-pokedex";
  const int pokemonEntryNumber = 2;

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
        frontSpriteUrl: pokemonFrontSpriteUrl);
  });

  tearDown(() async {
    await database.close();
  });

  group('GetPokemon', () {
    test('return PokemonLocalModel when data is found', () async {
      await mockDatabase.populatePokemonTable(pokemonId, pokemonName,
          pokemonType1, pokemonType2, pokemonFrontSpriteUrl);
      await mockDatabase.populatePokedexEntryNumbersTable(
          pokedexName, pokemonId, pokemonEntryNumber);

      var result = await pokemonLocal.get(pokemonId);

      expect(result, Right(pokemonModel));
    });
  });
}
