import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/boundary/local/pokedex_local.dart';
import 'package:repository/boundary/remote/pokedex_list_data.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter.dart';
import 'package:repository/models/data/pokedex_list/pokedex_list_data_model.dart';
import 'package:repository/models/data/pokedex_list/pokedex_list_item_data_model.dart';
import 'package:repository/models/data_failure.dart';
import 'package:repository/models/local/pokedex_local_model.dart';
import 'package:repository/repositories/pokedex_list_repository_impl.dart';

import 'pokedex_list_repository_test.mocks.dart';

@GenerateMocks([PokedexListData, PokedexLocal, PokedexRepositoryConverter])
void main() {
  late PokedexListRepository repository;
  late MockPokedexListData mockPokedexListData;
  late MockPokedexLocal mockPokedexLocal;
  late MockPokedexRepositoryConverter mockConverter;
  late PokedexLocalModel pokedexLocalModel1;
  late PokedexLocalModel pokedexLocalModel2;
  late List<PokedexLocalModel> pokedexLocalModels1;
  late List<PokedexLocalModel> pokedexLocalModels2;
  late PokedexListItemDataModel pokedexDataModel1;
  late PokedexListItemDataModel pokedexDataModel2;
  late PokedexListDataModel pokedexListDataModel;
  late PokedexModel pokedexDomainModel1;
  late PokedexModel pokedexDomainModel2;
  late List<PokedexModel> pokedexDomainModels1;
  late List<PokedexModel> pokedexDomainModels2;
  late Either<DataFailure, List<PokedexLocalModel>> mockLocalResultFailure;
  late Either<DataFailure, List<PokedexLocalModel>> mockLocalResultSuccess1;
  late Either<DataFailure, List<PokedexLocalModel>> mockLocalResultSuccess2;
  late Either<DataFailure, PokedexListDataModel> mockDataResultSuccess;
  late Either<DataFailure, PokedexListDataModel> mockDataResultFailure;

  const String pokedexDataName1 = "kanto";
  const String pokedexDataName2 = "original-johto";
  const PokedexName pokedexName1 = PokedexName.kanto;
  const PokedexName pokedexName2 = PokedexName.originalJohto;
  const int pokedexId1 = 1;
  const int pokedexId2 = 2;
  const String pokedexUrl1 = "https://pokeapi.co/api/v2/pokedex/$pokedexId1/";
  const String pokedexUrl2 = "https://pokeapi.co/api/v2/pokedex/$pokedexId2/";
  const String errorMessage = "No data";
  const PokemonRegion region = PokemonRegion.johto;
  const List<PokemonVersion> versions = [PokemonVersion.goldSilverCrystal];

  setUp(() {
    mockPokedexListData = MockPokedexListData();
    mockPokedexLocal = MockPokedexLocal();
    mockConverter = MockPokedexRepositoryConverter();
    repository = PokedexListRepositoryImpl(
        mockPokedexListData, mockPokedexLocal, mockConverter);
    pokedexLocalModel1 = PokedexLocalModel(id: pokedexId1, name: pokedexDataName1);
    pokedexLocalModel2 = PokedexLocalModel(id: pokedexId2, name: pokedexDataName2);
    pokedexLocalModels1 = [pokedexLocalModel1];
    pokedexLocalModels2 = [pokedexLocalModel1, pokedexLocalModel2];
    pokedexDataModel1 = PokedexListItemDataModel(pokedexDataName1, pokedexUrl1);
    pokedexDataModel2 = PokedexListItemDataModel(pokedexDataName2, pokedexUrl2);
    pokedexListDataModel =
        PokedexListDataModel([pokedexDataModel1, pokedexDataModel2]);
    pokedexDomainModel1 = PokedexModel(
        id: pokedexId1,
        name: pokedexName1,
        region: region,
        versions: versions,
        pokemon: []);
    pokedexDomainModel2 = PokedexModel(
        id: pokedexId2,
        name: pokedexName2,
        region: region,
        versions: versions,
        pokemon: []);
    pokedexDomainModels1 = [pokedexDomainModel1];
    pokedexDomainModels2 = [pokedexDomainModel1, pokedexDomainModel2];
    mockLocalResultFailure = Left(DataFailure(errorMessage));
    mockLocalResultSuccess1 = Right(pokedexLocalModels1);
    mockLocalResultSuccess2 = Right(pokedexLocalModels2);
    mockDataResultSuccess = Right(pokedexListDataModel);
    mockDataResultFailure = Left(DataFailure(errorMessage));
  });

  group("get pokedexes", () {
    test('return pokedexes from local, then return from data', () async {
      var localResults = [mockLocalResultSuccess1, mockLocalResultSuccess2];
      when(mockPokedexLocal.getAll())
          .thenAnswer((_) async => localResults.removeAt(0));

      when(mockConverter.convertListToDomain(pokedexLocalModels1))
          .thenReturn(pokedexDomainModels1);
      when(mockConverter.convertListToLocal(pokedexListDataModel))
          .thenReturn(pokedexLocalModels2);
      when(mockConverter.convertListToDomain(pokedexLocalModels2))
          .thenReturn(pokedexDomainModels2);

      when(mockPokedexListData.getAll())
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockPokedexLocal.storeList(pokedexLocalModels2))
          .thenAnswer((_) async => Future.value());

      var result = repository.getAllPokedexes();
      final emittedEvents = await result.toList();

      expect(
        emittedEvents,
        equals([
          Right(pokedexDomainModels1),
          Right(pokedexDomainModels2),
        ]),
      );
      verify(mockPokedexLocal.getAll()).called(2);
      verify(mockPokedexListData.getAll()).called(1);
      verify(mockPokedexLocal.storeList(any)).called(1);
    });

    test('return pokedexes from data when local is failure', () async {
      var localResults = [mockLocalResultFailure, mockLocalResultSuccess2];
      when(mockPokedexLocal.getAll())
          .thenAnswer((_) async => localResults.removeAt(0));

      when(mockConverter.convertListToDomain(pokedexLocalModels1))
          .thenReturn(pokedexDomainModels1);
      when(mockConverter.convertListToLocal(pokedexListDataModel))
          .thenReturn(pokedexLocalModels2);
      when(mockConverter.convertListToDomain(pokedexLocalModels2))
          .thenReturn(pokedexDomainModels2);

      when(mockPokedexListData.getAll())
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockPokedexLocal.storeList(pokedexLocalModels2))
          .thenAnswer((_) async => Future.value());

      var result = repository.getAllPokedexes();
      final emittedEvents = await result.toList();

      expect(
        emittedEvents,
        equals([
          Right(pokedexDomainModels2),
        ]),
      );
      verify(mockPokedexLocal.getAll()).called(2);
      verify(mockPokedexListData.getAll()).called(1);
      verify(mockPokedexLocal.storeList(any)).called(1);
    });

    test('return pokedexes from local when data is failure', () async {
      when(mockPokedexLocal.getAll())
          .thenAnswer((_) async => mockLocalResultSuccess1);
      when(mockConverter.convertListToDomain(pokedexLocalModels1))
          .thenReturn(pokedexDomainModels1);
      when(mockPokedexListData.getAll())
          .thenAnswer((_) async => mockDataResultFailure);

      var result = repository.getAllPokedexes();
      final emittedEvents = await result.toList();

      expect(
        emittedEvents,
        equals([
          Right(pokedexDomainModels1),
        ]),
      );
      verify(mockPokedexLocal.getAll()).called(1);
      verify(mockPokedexListData.getAll()).called(1);
      verifyNever(mockPokedexLocal.store(any));
      verifyNever(mockPokedexLocal.storeList(any));
    });

    test('return failure when local and data are failures', () async {
      when(mockPokedexLocal.getAll())
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockPokedexListData.getAll())
          .thenAnswer((_) async => mockDataResultFailure);

      var result = repository.getAllPokedexes();
      final emittedEvents = await result.toList();

      expect(
        emittedEvents,
        equals([
          Left(Failure()),
        ]),
      );
      verify(mockPokedexLocal.getAll()).called(1);
      verify(mockPokedexListData.getAll()).called(1);
      verifyNever(mockPokedexLocal.store(any));
      verifyNever(mockPokedexLocal.storeList(any));
    });
  });
}
