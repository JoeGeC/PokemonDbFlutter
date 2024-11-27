import 'package:dartz/dartz.dart';
import 'package:domain/boundary/repository/pokedexes_repository.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokedex_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/boundary/local/pokedex_local.dart';
import 'package:repository/boundary/remote/pokedexes_data.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/models/data_failure.dart';
import 'package:repository/models/local/pokedex_local_model.dart';
import 'package:repository/repositories/pokedexes_repository_impl.dart';

import 'pokedexes_repository_should.mocks.dart';

@GenerateMocks([PokedexesData, PokedexLocal, PokedexRepositoryConverter])
void main() {
  late PokedexesRepository repository;
  late MockPokedexesData mockPokedexesData;
  late MockPokedexLocal mockPokedexLocal;
  late MockPokedexRepositoryConverter mockConverter;
  late PokedexLocalModel pokedexLocalModel1;
  late PokedexLocalModel pokedexLocalModel2;
  late List<PokedexLocalModel> pokedexLocalModels1;
  late List<PokedexLocalModel> pokedexLocalModels2;
  late PokedexDataModel pokedexDataModel1;
  late PokedexDataModel pokedexDataModel2;
  late List<PokedexDataModel> pokedexDataModels;
  late PokedexModel pokedexDomainModel1;
  late PokedexModel pokedexDomainModel2;
  late List<PokedexModel> pokedexDomainModels1;
  late List<PokedexModel> pokedexDomainModels2;
  late Either<DataFailure, List<PokedexLocalModel>> mockLocalResultFailure;
  late Either<DataFailure, List<PokedexLocalModel>> mockLocalResultSuccess1;
  late Either<DataFailure, List<PokedexLocalModel>> mockLocalResultSuccess2;
  late Either<DataFailure, List<PokedexDataModel>> mockDataResultSuccess;
  late Either<DataFailure, List<PokedexDataModel>> mockDataResultFailure;

  const int pokedexId1 = 1;
  const String pokedexName1 = "Sample Pokedex";
  const int pokedexId2 = 2;
  const String pokedexName2 = "Sample Pokedex 2";
  const String errorMessage = "No data";

  setUp(() {
    mockPokedexesData = MockPokedexesData();
    mockPokedexLocal = MockPokedexLocal();
    mockConverter = MockPokedexRepositoryConverter();
    repository = PokedexesRepositoryImpl(
        mockPokedexesData, mockPokedexLocal, mockConverter);
    pokedexLocalModel1 = PokedexLocalModel(id: pokedexId1, name: pokedexName1);
    pokedexLocalModel2 = PokedexLocalModel(id: pokedexId2, name: pokedexName2);
    pokedexLocalModels1 = [pokedexLocalModel1];
    pokedexLocalModels2 = [pokedexLocalModel1, pokedexLocalModel2];
    pokedexDataModel1 = PokedexDataModel(pokedexId1, pokedexName1, null);
    pokedexDataModel2 = PokedexDataModel(pokedexId2, pokedexName2, null);
    pokedexDataModels = [pokedexDataModel1, pokedexDataModel2];
    pokedexDomainModel1 =
        PokedexModel(id: pokedexId1, name: pokedexName1, pokemon: []);
    pokedexDomainModel2 =
        PokedexModel(id: pokedexId2, name: pokedexName2, pokemon: []);
    pokedexDomainModels1 = [pokedexDomainModel1];
    pokedexDomainModels2 = [pokedexDomainModel1, pokedexDomainModel2];
    mockLocalResultFailure = Left(DataFailure(errorMessage));
    mockLocalResultSuccess1 = Right(pokedexLocalModels1);
    mockLocalResultSuccess2 = Right(pokedexLocalModels2);
    mockDataResultSuccess = Right(pokedexDataModels);
    mockDataResultFailure = Left(DataFailure(errorMessage));
  });

  group("get pokedexes", () {
    test('return pokedexes from local, then return from data', () async {
      var localResults = [mockLocalResultSuccess1, mockLocalResultSuccess2];
      when(mockPokedexLocal.getAll())
          .thenAnswer((_) async => localResults.removeAt(0));

      when(mockConverter.convertListToDomain(pokedexLocalModels1))
          .thenReturn(pokedexDomainModels1);
      when(mockConverter.convertListToLocal(pokedexDataModels))
          .thenReturn(pokedexLocalModels2);
      when(mockConverter.convertListToDomain(pokedexLocalModels2))
          .thenReturn(pokedexDomainModels2);

      when(mockPokedexesData.getALl())
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
      verify(mockPokedexesData.getALl()).called(1);
      verify(mockPokedexLocal.storeList(any)).called(1);
    });

    test('return pokedexes from data when local is failure', () async {
      var localResults = [mockLocalResultFailure, mockLocalResultSuccess2];
      when(mockPokedexLocal.getAll())
          .thenAnswer((_) async => localResults.removeAt(0));

      when(mockConverter.convertListToDomain(pokedexLocalModels1))
          .thenReturn(pokedexDomainModels1);
      when(mockConverter.convertListToLocal(pokedexDataModels))
          .thenReturn(pokedexLocalModels2);
      when(mockConverter.convertListToDomain(pokedexLocalModels2))
          .thenReturn(pokedexDomainModels2);

      when(mockPokedexesData.getALl())
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
      verify(mockPokedexesData.getALl()).called(1);
      verify(mockPokedexLocal.storeList(any)).called(1);
    });

    test('return pokedexes from local when data is failure', () async {
      when(mockPokedexLocal.getAll())
          .thenAnswer((_) async => mockLocalResultSuccess1);
      when(mockConverter.convertListToDomain(pokedexLocalModels1))
          .thenReturn(pokedexDomainModels1);
      when(mockPokedexesData.getALl())
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
      verify(mockPokedexesData.getALl()).called(1);
      verifyNever(mockPokedexLocal.store(any));
      verifyNever(mockPokedexLocal.storeList(any));
    });

    test('return failure when local and data are failures', () async {
      when(mockPokedexLocal.getAll())
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockPokedexesData.getALl())
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
      verify(mockPokedexesData.getALl()).called(1);
      verifyNever(mockPokedexLocal.store(any));
      verifyNever(mockPokedexLocal.storeList(any));
    });

  });
}
