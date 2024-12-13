import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/boundary/local/pokemon_local.dart';
import 'package:repository/boundary/remote/pokemon_data.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/models/data/pokemon/pokemon_data_model.dart';
import 'package:repository/models/data_failure.dart';
import 'package:repository/models/local/pokemon_local_model.dart';
import 'package:repository/repositories/pokemon_repository_impl.dart';

import '../../mocks/pokemon_mocks.dart';
import 'pokemon_repository_test.mocks.dart';

@GenerateMocks([PokemonData, PokemonLocal, PokemonRepositoryConverter])
void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonData mockPokemonData;
  late MockPokemonLocal mockPokemonLocal;
  late MockPokemonRepositoryConverter mockConverter;

  const String errorMessage = "Error Message";

  final Either<DataFailure, PokemonLocalModel> mockLocalResultSuccess =
      Right(PokemonRepoMocks.pokemonLocalModelWithEntryNumbers);
  final Either<DataFailure, PokemonLocalModel>
      mockLocalResultSuccessUndetailed =
      Right(PokemonRepoMocks.pokemonLocalModelUndetailed);
  final Either<DataFailure, PokemonLocalModel> mockLocalResultFailure =
      Left(DataFailure(errorMessage));
  final Either<DataFailure, PokemonDataModel> mockDataResultSuccess =
      Right(PokemonRepoMocks.pokemonDataModel);
  final Either<DataFailure, PokemonDataModel> mockDataResultFailure =
      Left(DataFailure(errorMessage));
  final Either<Failure, PokemonModel> expectedSuccess =
      Right(PokemonRepoMocks.pokemonDomainModel);
  final Either<Failure, PokemonModel> expectedSuccessUndetailed =
      Right(PokemonRepoMocks.pokemonDomainModelUndetailed);
  final Either<Failure, PokemonModel> expectedFailure =
      Left(Failure(errorMessage));

  setUp(() {
    mockPokemonData = MockPokemonData();
    mockPokemonLocal = MockPokemonLocal();
    mockConverter = MockPokemonRepositoryConverter();
    repository =
        PokemonRepositoryImpl(mockPokemonData, mockPokemonLocal, mockConverter);
  });

  group("getPokemon", () {
    test('return pokemon from local when detailed data present', () async {
      when(mockPokemonLocal.get(PokemonRepoMocks.pokemonId))
          .thenAnswer((_) async => mockLocalResultSuccess);
      when(mockConverter.convertToDomain(
              PokemonRepoMocks.pokemonLocalModelWithEntryNumbers))
          .thenReturn(PokemonRepoMocks.pokemonDomainModel);

      var result = await repository.getPokemon(PokemonRepoMocks.pokemonId);

      verify(mockPokemonLocal.get(any)).called(1);
      verifyNever(mockPokemonData.get(any));
      expect(result, expectedSuccess);
    });

    test('get pokemon from data when detailed data not present', () async {
      var localGetResults = [
        mockLocalResultSuccessUndetailed,
        mockLocalResultSuccess
      ];
      when(mockPokemonLocal.get(PokemonRepoMocks.pokemonId))
          .thenAnswer((_) async => localGetResults.removeAt(0));
      when(mockPokemonData.get(PokemonRepoMocks.pokemonId))
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockConverter.convertToLocal(PokemonRepoMocks.pokemonDataModel))
          .thenReturn(PokemonRepoMocks.pokemonLocalModelNoEntryNumbers);
      when(mockPokemonLocal
              .store(PokemonRepoMocks.pokemonLocalModelNoEntryNumbers))
          .thenAnswer((_) async => Future.value);
      when(mockConverter.convertToDomain(
              PokemonRepoMocks.pokemonLocalModelWithEntryNumbers))
          .thenReturn(PokemonRepoMocks.pokemonDomainModel);

      var result = await repository.getPokemon(PokemonRepoMocks.pokemonId);

      verify(mockPokemonLocal.get(any)).called(2);
      verify(
        mockPokemonLocal
            .store(PokemonRepoMocks.pokemonLocalModelNoEntryNumbers),
      ).called(1);
      verify(mockPokemonData.get(any)).called(1);
      expect(result, expectedSuccess);
    });

    test('get pokemon from data when not in local and store locally', () async {
      var localGetResults = [mockLocalResultFailure, mockLocalResultSuccess];
      when(mockPokemonLocal.get(PokemonRepoMocks.pokemonId))
          .thenAnswer((_) async => localGetResults.removeAt(0));
      when(mockPokemonData.get(PokemonRepoMocks.pokemonId))
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockConverter.convertToLocal(PokemonRepoMocks.pokemonDataModel))
          .thenReturn(PokemonRepoMocks.pokemonLocalModelNoEntryNumbers);
      when(mockPokemonLocal
              .store(PokemonRepoMocks.pokemonLocalModelNoEntryNumbers))
          .thenAnswer((_) async => Future.value);
      when(mockConverter.convertToDomain(
              PokemonRepoMocks.pokemonLocalModelWithEntryNumbers))
          .thenReturn(PokemonRepoMocks.pokemonDomainModel);

      var result = await repository.getPokemon(PokemonRepoMocks.pokemonId);

      verify(mockPokemonLocal.get(any)).called(2);
      verify(mockPokemonLocal
              .store(PokemonRepoMocks.pokemonLocalModelNoEntryNumbers))
          .called(1);
      verify(mockPokemonData.get(any)).called(1);
      expect(result, expectedSuccess);
    });

    test('return undetailed pokemon from local when no data response',
        () async {
      when(mockPokemonLocal.get(PokemonRepoMocks.pokemonId))
          .thenAnswer((_) async => mockLocalResultSuccessUndetailed);
      when(mockConverter
              .convertToDomain(PokemonRepoMocks.pokemonLocalModelUndetailed))
          .thenReturn(PokemonRepoMocks.pokemonDomainModelUndetailed);
      when(mockPokemonData.get(PokemonRepoMocks.pokemonId))
          .thenAnswer((_) async => mockDataResultFailure);

      var result = await repository.getPokemon(PokemonRepoMocks.pokemonId);

      verify(mockPokemonLocal.get(any)).called(1);
      verifyNever(mockPokemonLocal.store(any));
      verify(mockPokemonData.get(any)).called(1);
      expect(result, expectedSuccessUndetailed);
    });

    test('return failure when no data', () async {
      when(mockPokemonLocal.get(PokemonRepoMocks.pokemonId))
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockPokemonData.get(PokemonRepoMocks.pokemonId))
          .thenAnswer((_) async => mockDataResultFailure);

      var result = await repository.getPokemon(PokemonRepoMocks.pokemonId);

      verify(mockPokemonLocal.get(any)).called(1);
      verifyNever(mockPokemonLocal.store(any));
      verify(mockPokemonData.get(any)).called(1);
      expect(result, expectedFailure);
    });

    test('return failure when local conversion fails', () async {
      when(mockPokemonLocal.get(PokemonRepoMocks.pokemonId))
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockConverter.convertToDomain(
              PokemonRepoMocks.pokemonLocalModelWithEntryNumbers))
          .thenReturn(PokemonRepoMocks.pokemonDomainModel);
      when(mockPokemonData.get(PokemonRepoMocks.pokemonId))
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockConverter.convertToLocal(PokemonRepoMocks.pokemonDataModel))
          .thenReturn(null);

      var result = await repository.getPokemon(PokemonRepoMocks.pokemonId);

      verify(mockPokemonLocal.get(any)).called(1);
      verifyNever(mockPokemonLocal.store(any));
      verify(mockPokemonData.get(any)).called(1);
      expect(result, Left(Failure("Conversion failed")));
    });
  });
}
