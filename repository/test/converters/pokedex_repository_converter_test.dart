import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/src/converters/pokedex/pokedex_repository_converter_impl.dart';
import 'package:repository/src/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/src/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/src/models/data/pokedex_list/pokedex_list_data_model.dart';
import 'package:repository/src/models/data/pokedex_list/pokedex_list_item_data_model.dart';
import 'package:repository/src/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/src/models/exceptions/NullException.dart';
import 'package:repository/src/models/local/pokedex_local_model.dart';
import 'package:repository/src/models/local/pokemon_local_model.dart';

import 'pokedex_repository_converter_test.mocks.dart';

@GenerateMocks([PokemonRepositoryConverter])
void main() {
  late PokedexRepositoryConverterImpl pokedexConverter;
  late MockPokemonRepositoryConverter mockPokemonConverter;
  late PokemonLocalModel pokedexPokemonLocalModel;
  late List<PokemonLocalModel> pokemonLocalList;
  late PokedexLocalModel detailedPokedexLocalModel;
  late PokedexLocalModel undetailedPokedexLocalModel1;
  late PokedexLocalModel undetailedPokedexLocalModel2;
  late List<PokedexLocalModel> undetailedPokedexLocalList;
  late List<PokedexLocalModel> pokedexLocalList;
  late PokedexPokemonDataModel pokemonDataModel;
  late List<PokedexPokemonDataModel> pokemonDataList;
  late PokemonModel pokemonDomainModel;
  late PokedexModel pokedexDomainModel1;
  late PokedexModel pokedexDomainModel2;
  late List<PokedexModel> pokedexDomainList;
  late List<PokemonModel> pokemonDomainList;
  late PokedexDataModel pokedexDataModel1;
  late PokedexListDataModel pokedexListDataModel;

  const int pokedexId1 = 1;
  const String pokedexDataName1 = "kanto";
  const PokedexName pokedexDomainName1 = PokedexName.kanto;
  const int pokedexId2 = 2;
  const String pokedexDataName2 = "original-johto";
  const PokedexName pokedexDomainName2 = PokedexName.originalJohto;
  const int pokemonId = 10;
  const int pokemonEntryId = 11;
  const String pokemonName = "Sample Pokemon";
  const String baseUrl = "https://pokeapi.co/api/v2";
  const String pokemonUrl = "$baseUrl/pokemon/$pokemonId/";
  const String pokedexUrl1 = "$baseUrl/pokedex/$pokedexId1/";
  const String pokedexUrl2 = "$baseUrl/pokedex/$pokedexId2/";
  const PokemonRegion region1 = PokemonRegion.kanto;
  const List<PokemonVersion> versions1 = [
    PokemonVersion.redBlueYellow,
    PokemonVersion.fireRedLeafGreen
  ];
  const PokemonRegion region2 = PokemonRegion.johto;
  const List<PokemonVersion> versions2 = [PokemonVersion.goldSilverCrystal];

  setUp(() {
    mockPokemonConverter = MockPokemonRepositoryConverter();
    pokedexConverter = PokedexRepositoryConverterImpl(mockPokemonConverter);
    pokedexPokemonLocalModel = PokemonLocalModel(
        id: pokemonId,
        pokedexEntryNumbers: {pokedexId1: pokemonEntryId},
        name: pokemonName);
    pokemonLocalList = [pokedexPokemonLocalModel];
    detailedPokedexLocalModel = PokedexLocalModel(
        id: pokedexId1, name: pokedexDataName1, pokemon: pokemonLocalList);
    undetailedPokedexLocalModel1 =
        PokedexLocalModel(id: pokedexId1, name: pokedexDataName1);
    undetailedPokedexLocalModel2 =
        PokedexLocalModel(id: pokedexId2, name: pokedexDataName2);
    undetailedPokedexLocalList = [
      undetailedPokedexLocalModel1,
      undetailedPokedexLocalModel2
    ];
    pokedexLocalList = [
      detailedPokedexLocalModel,
      undetailedPokedexLocalModel2
    ];
    pokemonDomainModel = PokemonModel(
        id: pokemonId,
        name: pokemonName,
        pokedexEntryNumbers: {pokedexId1: pokemonEntryId});
    pokemonDomainList = [pokemonDomainModel];
    pokedexDomainModel1 = PokedexModel(
        id: pokedexId1,
        name: pokedexDomainName1,
        region: region1,
        versions: versions1,
        pokemon: pokemonDomainList);
    pokedexDomainModel2 = PokedexModel(
        id: pokedexId2,
        name: pokedexDomainName2,
        region: region2,
        versions: versions2,
        pokemon: []);
    pokedexDomainList = [pokedexDomainModel1, pokedexDomainModel2];
    pokemonDataModel = PokedexPokemonDataModel(
      pokemonEntryId,
      pokemonName,
      pokemonUrl,
    );
    pokemonDataList = [pokemonDataModel];
    pokedexDataModel1 =
        PokedexDataModel(pokedexId1, pokedexDataName1, pokemonDataList);
    var pokedexListItemDataModel1 =
        PokedexListItemDataModel(pokedexDataName1, pokedexUrl1);
    var pokedexListItemDataModel2 =
        PokedexListItemDataModel(pokedexDataName2, pokedexUrl2);
    pokedexListDataModel = PokedexListDataModel(
        [pokedexListItemDataModel1, pokedexListItemDataModel2]);
  });

  group("convert to domain", () {
    test('convert local model to domain model', () {
      when(mockPokemonConverter.convertListToDomain(pokemonLocalList))
          .thenReturn(pokemonDomainList);
      var result = pokedexConverter.convertToDomain(detailedPokedexLocalModel);

      expect(result, pokedexDomainModel1);
    });
  });

  group("convert list to domain", () {
    test('convert local list to domain', () {
      when(mockPokemonConverter.convertListToDomain(pokemonLocalList))
          .thenReturn(pokemonDomainList);
      when(mockPokemonConverter.convertListToDomain(null)).thenReturn([]);

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

      expect(result, detailedPokedexLocalModel);
    });

    test('throw exception if null id', () {
      PokedexDataModel pokedexDataModel =
          PokedexDataModel(null, pokedexDataName1, pokemonDataList);

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
      when(
        mockPokemonConverter.convertPokedexListToLocal(
            pokemonDataList, pokedexId1),
      ).thenReturn(pokemonLocalList);
      when(mockPokemonConverter.convertPokedexListToLocal(null, pokedexId2))
          .thenReturn(null);

      var result = pokedexConverter.convertListToLocal(pokedexListDataModel);

      expect(result, undetailedPokedexLocalList);
    });
  });
}
