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
import 'package:repository/repositories/pokemon_repository.dart';

import 'pokemon_repository_should.mocks.dart';

@GenerateMocks([PokemonData, PokemonLocal, PokemonRepositoryConverter])
void main() {
  late PokemonRepositoryImpl repository;
  late MockPokemonData mockPokemonData;
  late MockPokemonLocal mockPokemonLocal;
  late MockPokemonRepositoryConverter mockConverter;

  late PokemonModel pokemonDomainModel;
  late PokemonModel pokemonDomainModelUndetailed;
  late PokemonLocalModel pokemonLocalModel;
  late PokemonLocalModel pokemonLocalModelUndetailed;
  late PokemonDataModel pokemonDataModel;
  late Either<DataFailure, PokemonLocalModel> mockLocalResultSuccess;
  late Either<DataFailure, PokemonLocalModel> mockLocalResultSuccessUndetailed;
  late Either<DataFailure, PokemonLocalModel> mockLocalResultFailure;
  late Either<DataFailure, PokemonDataModel> mockDataResultSuccess;
  late Either<DataFailure, PokemonDataModel> mockDataResultFailure;
  late Either<Failure, PokemonModel> expectedSuccess;
  late Either<Failure, PokemonModel> expectedSuccessUndetailed;

  const String errorMessage = "Error Message";
  const int pokemonId = 1;
  const String pokemonName = "Sample Pokemon";
  const List<String> pokemonTypes = ["Grass", "Poison"];
  const String pokemonFrontSpriteUrl = "https://sample-pokemon/dfsa.png";
  const Map<String, int> pokedexEntryNumbers = {"original-johto": 25};

  setUp(() {
    mockPokemonData = MockPokemonData();
    mockPokemonLocal = MockPokemonLocal();
    mockConverter = MockPokemonRepositoryConverter();
    repository =
        PokemonRepositoryImpl(mockPokemonData, mockPokemonLocal, mockConverter);

    pokemonLocalModel = PokemonLocalModel(
      id: pokemonId,
      name: pokemonName,
      types: pokemonTypes,
      frontSpriteUrl: pokemonFrontSpriteUrl,
      pokedexEntryNumbers: pokedexEntryNumbers,
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
    mockLocalResultSuccess = Right(pokemonLocalModel);
    mockLocalResultSuccessUndetailed = Right(pokemonLocalModelUndetailed);
    mockLocalResultFailure = Left(DataFailure(errorMessage));
    mockDataResultSuccess = Right(pokemonDataModel);
    mockDataResultFailure = Left(DataFailure(errorMessage));
    expectedSuccess = Right(pokemonDomainModel);
    expectedSuccessUndetailed = Right(pokemonDomainModelUndetailed);
  });

  group("getPokemon", () {
    test('return pokemon from local when detailed data present', () async {
      when(mockPokemonLocal.get(pokemonId))
          .thenAnswer((_) async => mockLocalResultSuccess);
      when(mockConverter.convertToDomain(pokemonLocalModel))
          .thenReturn(pokemonDomainModel);
      var result = await repository.getPokemon(pokemonId);

      verify(mockPokemonLocal.get(any)).called(1);
      verifyNever(mockPokemonData.get(any));
      expect(result, expectedSuccess);
    });

    test('get pokemon from data when detailed data not present and store locally', () async {
      when(mockPokemonLocal.get(pokemonId))
          .thenAnswer((_) async => mockLocalResultSuccessUndetailed);
      when(mockConverter.convertToDomain(pokemonLocalModel))
          .thenReturn(pokemonDomainModel);
      when(mockPokemonData.get(pokemonId))
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockConverter.convertToLocal(pokemonDataModel))
          .thenReturn(pokemonLocalModel);

      var result = await repository.getPokemon(pokemonId);

      verify(mockPokemonLocal.get(any)).called(1);
      verify(mockPokemonLocal.store(pokemonLocalModel)).called(1);
      verify(mockPokemonData.get(any)).called(1);
      expect(result, expectedSuccess);
    });

    test('get pokemon from data when not in local and store locally', () async {
      when(mockPokemonLocal.get(pokemonId))
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockConverter.convertToDomain(pokemonLocalModel))
          .thenReturn(pokemonDomainModel);
      when(mockPokemonData.get(pokemonId))
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockConverter.convertToLocal(pokemonDataModel))
          .thenReturn(pokemonLocalModel);

      var result = await repository.getPokemon(pokemonId);

      verify(mockPokemonLocal.get(any)).called(1);
      verify(mockPokemonLocal.store(pokemonLocalModel)).called(1);
      verify(mockPokemonData.get(any)).called(1);
      expect(result, expectedSuccess);
    });

    test('return undetailed pokemon from local when no data response', () async {
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
  });
}
