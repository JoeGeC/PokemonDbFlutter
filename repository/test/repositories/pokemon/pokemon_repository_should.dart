import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokemon_model.dart';
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

import 'pokemon_repository_should.mocks.dart';

@GenerateMocks([PokemonData, PokemonLocal, PokemonRepositoryConverter])
void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonData mockPokemonData;
  late MockPokemonLocal mockPokemonLocal;
  late MockPokemonRepositoryConverter mockConverter;

  late PokemonModel pokemonDomainModel;
  late PokemonModel pokemonDomainModelUndetailed;
  late PokemonLocalModel pokemonLocalModelWithEntries;
  late PokemonLocalModel pokemonLocalModelNoEntries;
  late PokemonLocalModel pokemonLocalModelUndetailed;
  late PokemonDataModel pokemonDataModel;
  late Either<DataFailure, PokemonLocalModel> mockLocalResultSuccess;
  late Either<DataFailure, PokemonLocalModel> mockLocalResultSuccessUndetailed;
  late Either<DataFailure, PokemonLocalModel> mockLocalResultFailure;
  late Either<DataFailure, PokemonDataModel> mockDataResultSuccess;
  late Either<DataFailure, PokemonDataModel> mockDataResultFailure;
  late Either<Failure, PokemonModel> expectedSuccess;
  late Either<Failure, PokemonModel> expectedSuccessUndetailed;
  late Either<Failure, PokemonModel> expectedFailure;

  const String errorMessage = "Error Message";
  const int pokemonId = 1;
  const String pokemonName = "Sample Pokemon";
  const List<String> pokemonTypes = ["Grass", "Poison"];
  const String pokemonFrontSpriteUrl = "https://sample-pokemon/dfsa.png";
  const Map<int, int> pokedexEntryNumbers = {5: 25};

  setUp(() {
    mockPokemonData = MockPokemonData();
    mockPokemonLocal = MockPokemonLocal();
    mockConverter = MockPokemonRepositoryConverter();
    repository =
        PokemonRepositoryImpl(mockPokemonData, mockPokemonLocal, mockConverter);

    pokemonLocalModelWithEntries = PokemonLocalModel(
      id: pokemonId,
      name: pokemonName,
      types: pokemonTypes,
      frontSpriteUrl: pokemonFrontSpriteUrl,
      pokedexEntryNumbers: pokedexEntryNumbers,
    );
    pokemonLocalModelNoEntries = PokemonLocalModel(
      id: pokemonId,
      name: pokemonName,
      types: pokemonTypes,
      frontSpriteUrl: pokemonFrontSpriteUrl,
    );
    pokemonLocalModelUndetailed = PokemonLocalModel(
      id: pokemonId,
      name: pokemonName,
      pokedexEntryNumbers: pokedexEntryNumbers,
    );
    pokemonDomainModel = PokemonModel(
      id: pokemonId,
      name: pokemonName,
      types: pokemonTypes,
      imageUrl: pokemonFrontSpriteUrl,
      pokedexEntryNumbers: pokedexEntryNumbers,
    );
    pokemonDomainModelUndetailed = PokemonModel(
      id: pokemonId,
      name: pokemonName,
      pokedexEntryNumbers: pokedexEntryNumbers,
    );
    pokemonDataModel = PokemonDataModel(
      pokemonId,
      pokemonName,
      pokemonTypes,
      pokemonFrontSpriteUrl,
    );
    mockLocalResultSuccess = Right(pokemonLocalModelWithEntries);
    mockLocalResultSuccessUndetailed = Right(pokemonLocalModelUndetailed);
    mockLocalResultFailure = Left(DataFailure(errorMessage));
    mockDataResultSuccess = Right(pokemonDataModel);
    mockDataResultFailure = Left(DataFailure(errorMessage));
    expectedSuccess = Right(pokemonDomainModel);
    expectedSuccessUndetailed = Right(pokemonDomainModelUndetailed);
    expectedFailure = Left(Failure(errorMessage));
  });

  group("getPokemon", () {
    test('return pokemon from local when detailed data present', () async {
      when(mockPokemonLocal.get(pokemonId))
          .thenAnswer((_) async => mockLocalResultSuccess);
      when(mockConverter.convertToDomain(pokemonLocalModelWithEntries))
          .thenReturn(pokemonDomainModel);

      var result = await repository.getPokemon(pokemonId);

      verify(mockPokemonLocal.get(any)).called(1);
      verifyNever(mockPokemonData.get(any));
      expect(result, expectedSuccess);
    });

    test('get pokemon from data when detailed data not present', () async {
      var localGetResults = [mockLocalResultSuccessUndetailed, mockLocalResultSuccess];
      when(mockPokemonLocal.get(pokemonId))
          .thenAnswer((_) async => localGetResults.removeAt(0));
      when(mockPokemonData.get(pokemonId))
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockConverter.convertToLocal(pokemonDataModel))
          .thenReturn(pokemonLocalModelNoEntries);
      when(mockPokemonLocal.store(pokemonLocalModelNoEntries))
          .thenAnswer((_) async => Future.value);
      when(mockConverter.convertToDomain(pokemonLocalModelWithEntries))
          .thenReturn(pokemonDomainModel);

      var result = await repository.getPokemon(pokemonId);

      verify(mockPokemonLocal.get(any)).called(2);
      verify(mockPokemonLocal.store(pokemonLocalModelNoEntries)).called(1);
      verify(mockPokemonData.get(any)).called(1);
      expect(result, expectedSuccess);
    });

    test('get pokemon from data when not in local and store locally', () async {
      var localGetResults = [mockLocalResultFailure, mockLocalResultSuccess];
      when(mockPokemonLocal.get(pokemonId))
          .thenAnswer((_) async => localGetResults.removeAt(0));
      when(mockPokemonData.get(pokemonId))
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockConverter.convertToLocal(pokemonDataModel))
          .thenReturn(pokemonLocalModelNoEntries);
      when(mockPokemonLocal.store(pokemonLocalModelNoEntries))
          .thenAnswer((_) async => Future.value);
      when(mockConverter.convertToDomain(pokemonLocalModelWithEntries))
          .thenReturn(pokemonDomainModel);

      var result = await repository.getPokemon(pokemonId);

      verify(mockPokemonLocal.get(any)).called(2);
      verify(mockPokemonLocal.store(pokemonLocalModelNoEntries)).called(1);
      verify(mockPokemonData.get(any)).called(1);
      expect(result, expectedSuccess);
    });

    test('return undetailed pokemon from local when no data response',
        () async {
      when(mockPokemonLocal.get(pokemonId))
          .thenAnswer((_) async => mockLocalResultSuccessUndetailed);
      when(mockConverter.convertToDomain(pokemonLocalModelUndetailed))
          .thenReturn(pokemonDomainModelUndetailed);
      when(mockPokemonData.get(pokemonId))
          .thenAnswer((_) async => mockDataResultFailure);

      var result = await repository.getPokemon(pokemonId);

      verify(mockPokemonLocal.get(any)).called(1);
      verifyNever(mockPokemonLocal.store(any));
      verify(mockPokemonData.get(any)).called(1);
      expect(result, expectedSuccessUndetailed);
    });

    test('return failure when no data', () async {
      when(mockPokemonLocal.get(pokemonId))
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockPokemonData.get(pokemonId))
          .thenAnswer((_) async => mockDataResultFailure);

      var result = await repository.getPokemon(pokemonId);

      verify(mockPokemonLocal.get(any)).called(1);
      verifyNever(mockPokemonLocal.store(any));
      verify(mockPokemonData.get(any)).called(1);
      expect(result, expectedFailure);
    });

    test('return failure when local conversion fails', () async {
      when(mockPokemonLocal.get(pokemonId))
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockConverter.convertToDomain(pokemonLocalModelWithEntries))
          .thenReturn(pokemonDomainModel);
      when(mockPokemonData.get(pokemonId))
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockConverter.convertToLocal(pokemonDataModel)).thenReturn(null);

      var result = await repository.getPokemon(pokemonId);

      verify(mockPokemonLocal.get(any)).called(1);
      verifyNever(mockPokemonLocal.store(any));
      verify(mockPokemonData.get(any)).called(1);
      expect(result, Left(Failure("Conversion failed")));
    });
  });
}
