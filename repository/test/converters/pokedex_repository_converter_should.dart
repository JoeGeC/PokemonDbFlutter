import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter_impl.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/models/exceptions/NullException.dart';
import 'package:repository/models/local/pokedex_local_model.dart';
import 'package:repository/models/local/pokemon_local_model.dart';

import 'pokedex_repository_converter_should.mocks.dart';

@GenerateMocks([PokemonRepositoryConverter])
void main() {
  late PokedexRepositoryConverterImpl pokedexConverter;
  late MockPokemonRepositoryConverter mockPokemonConverter;
  late PokemonLocalModel pokedexPokemonLocalModel;
  late List<PokemonLocalModel> pokemonLocalList;
  late PokedexLocalModel pokedexLocalModel1;
  late PokedexLocalModel pokedexLocalModel2;
  late List<PokedexLocalModel> pokedexLocalList;
  late PokedexPokemonDataModel pokemonDataModel;
  late List<PokedexPokemonDataModel> pokemonDataList;
  late PokemonModel pokemonDomainModel;
  late PokedexModel pokedexDomainModel1;
  late PokedexModel pokedexDomainModel2;
  late List<PokedexModel> pokedexDomainList;
  late List<PokemonModel> pokemonDomainList;
  late PokedexDataModel pokedexDataModel1;
  late PokedexDataModel pokedexDataModel2;
  late List<PokedexDataModel> pokedexDataList;
  late String pokemonUrl;

  const int pokedexId1 = 1;
  const String pokedexName1 = "Sample Pokedex";
  const int pokedexId2 = 2;
  const String pokedexName2 = "Sample Pokedex 2";
  const int pokemonId = 10;
  const int pokemonEntryId = 11;
  const String pokemonName = "Sample Pokemon";

  setUp(() {
    mockPokemonConverter = MockPokemonRepositoryConverter();
    pokedexConverter = PokedexRepositoryConverterImpl(mockPokemonConverter);
    pokedexPokemonLocalModel = PokemonLocalModel(
        id: pokemonId,
        pokedexEntryNumbers: {pokedexId1: pokemonEntryId},
        name: pokemonName);
    pokemonLocalList = [pokedexPokemonLocalModel];
    pokedexLocalModel1 = PokedexLocalModel(
        id: pokedexId1, name: pokedexName1, pokemon: pokemonLocalList);
    pokedexLocalModel2 = PokedexLocalModel(
        id: pokedexId2, name: pokedexName2);
    pokedexLocalList = [pokedexLocalModel1, pokedexLocalModel2];
    pokemonDomainModel = PokemonModel(
        id: pokemonId,
        name: pokemonName,
        pokedexEntryNumbers: {pokedexId1: pokemonEntryId});
    pokemonDomainList = [pokemonDomainModel];
    pokedexDomainModel1 = PokedexModel(
        id: pokedexId1, name: pokedexName1, pokemon: pokemonDomainList);
    pokedexDomainModel2 = PokedexModel(
        id: pokedexId2, name: pokedexName2, pokemon: []);
    pokedexDomainList = [pokedexDomainModel1, pokedexDomainModel2];
    pokemonUrl = "url/$pokemonId/";
    pokemonDataModel = PokedexPokemonDataModel(
      pokemonEntryId,
      pokemonName,
      pokemonUrl,
    );
    pokemonDataList = [pokemonDataModel];
    pokedexDataModel1 = PokedexDataModel(pokedexId1, pokedexName1, pokemonDataList);
    pokedexDataModel2 = PokedexDataModel(pokedexId2, pokedexName2, null);
    pokedexDataList = [pokedexDataModel1, pokedexDataModel2];
  });

  group("convert to domain", () {

    test('convert local model to domain model', () {
      when(mockPokemonConverter.convertListToDomain(pokemonLocalList))
          .thenReturn(pokemonDomainList);
      var result = pokedexConverter.convertToDomain(pokedexLocalModel1);

      expect(result, pokedexDomainModel1);
    });

  });

  group("convert list to domain", () {
    test('convert local list to domain', () {
      when(mockPokemonConverter.convertListToDomain(pokemonLocalList))
          .thenReturn(pokemonDomainList);
      when(mockPokemonConverter.convertListToDomain(null))
          .thenReturn([]);

      var result = pokedexConverter.convertListToDomain(pokedexLocalList);

      expect(result, pokedexDomainList);
    });
  });

  group("convert to local", () {
    test('convert data model to local model', () {
      when(mockPokemonConverter.convertPokedexListToLocal(
              pokemonDataList, pokedexId1))
          .thenReturn(pokemonLocalList);
      var result = pokedexConverter.convertToLocal(pokedexDataModel1);

      expect(result, pokedexLocalModel1);
    });

    test('throw exception if null id', () {
      PokedexDataModel pokedexDataModel =
          PokedexDataModel(null, pokedexName1, pokemonDataList);

      expect(
          () => pokedexConverter.convertToLocal(pokedexDataModel),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.id)));
    });

    test('throw exception if null name', () {
      PokedexDataModel pokedexDataModel =
          PokedexDataModel(pokedexId1, null, pokemonDataList);

      expect(
          () => pokedexConverter.convertToLocal(pokedexDataModel),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.name)));
    });

  });

  group("convert list to local", () {

    test('convert data list to local', () {
      when(mockPokemonConverter.convertPokedexListToLocal(pokemonDataList, pokedexId1))
          .thenReturn(pokemonLocalList);
      when(mockPokemonConverter.convertPokedexListToLocal(null, pokedexId2))
          .thenReturn(null);

      var result = pokedexConverter.convertListToLocal(pokedexDataList);

      expect(result, pokedexLocalList);
    });

  });
}
