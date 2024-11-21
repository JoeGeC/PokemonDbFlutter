import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/boundary/local/pokedex_local.dart';
import 'package:repository/boundary/remote/pokedex_data.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter.dart';
import 'package:repository/models/data_failure.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/models/exceptions/NullException.dart';
import 'package:repository/models/local/pokedex_local_model.dart';
import 'package:repository/models/local/pokemon_local_model.dart';
import 'package:repository/repositories/pokedex_repository_impl.dart';

import 'pokedex_repository_should.mocks.dart';

@GenerateMocks([PokedexData, PokedexLocal, PokedexRepositoryConverter])
void main() {
  group("get pokedex", () {
    late PokedexRepositoryImpl repository;
    late MockPokedexData mockPokedexData;
    late MockPokedexLocal mockPokedexLocal;
    late MockPokedexRepositoryConverter mockConverter;
    late String failureMessage;
    late int pokedexId;
    late String pokedexName;
    late int pokemonEntryId;
    late int pokemonId;
    late String pokemonName;
    late PokedexPokemonDataModel pokedexPokemonData;
    late PokedexDataModel pokedexDataModel;
    late PokemonLocalModel pokedexPokemonLocalModel;
    late PokedexLocalModel pokedexLocalModel;
    late PokemonModel pokemonDomainModel;
    late PokedexModel pokedexDomainModel;
    late Either<DataFailure, PokedexDataModel> mockDataResultSuccess;
    late Either<DataFailure, PokedexDataModel> mockDataResultFailure;
    late Either<DataFailure, PokedexLocalModel> mockLocalResultSuccess;
    late Either<DataFailure, PokedexLocalModel> mockLocalResultFailure;
    late Either<Failure, PokedexModel> expectedFailure;
    late Either<Failure, PokedexModel> expectedSuccess;

    setUp(() {
      mockPokedexData = MockPokedexData();
      mockPokedexLocal = MockPokedexLocal();
      mockConverter = MockPokedexRepositoryConverter();
      repository = PokedexRepositoryImpl(
          mockPokedexData, mockPokedexLocal, mockConverter);
      failureMessage = "Failure";
      pokedexId = 1;
      pokedexName = "Sample Pokedex";
      pokemonEntryId = 3;
      pokemonId = 2;
      pokemonName = "Sample Pokemon";
      pokedexPokemonData =
          PokedexPokemonDataModel(pokemonId, pokemonName, "url");
      pokedexDataModel =
          PokedexDataModel(pokedexId, pokedexName, [pokedexPokemonData]);
      pokedexPokemonLocalModel = PokemonLocalModel(
          id: pokemonId,
          pokedexEntryNumbers: {pokemonName: pokemonEntryId},
          name: pokemonName);
      pokedexLocalModel =
          PokedexLocalModel(pokedexId, pokemonName, [pokedexPokemonLocalModel]);
      pokemonDomainModel = PokemonModel(
          id: pokemonId,
          name: pokemonName,
          pokedexEntryNumbers: {pokedexName: pokemonEntryId});
      pokedexDomainModel = PokedexModel(
          id: pokedexId, name: pokedexName, pokemon: [pokemonDomainModel]);
      mockDataResultSuccess = Right(pokedexDataModel);
      mockDataResultFailure = Left(DataFailure(failureMessage));
      mockLocalResultSuccess = Right(pokedexLocalModel);
      mockLocalResultFailure = Left(DataFailure(failureMessage));
      expectedSuccess = Right(pokedexDomainModel);
      expectedFailure = Left(Failure(failureMessage));
    });

    test('return pokedex from local', () async {
      when(mockPokedexLocal.get(pokedexId))
          .thenAnswer((_) async => mockLocalResultSuccess);
      when(mockConverter.convertToDomain(pokedexLocalModel))
          .thenReturn(pokedexDomainModel);
      var result = await repository.getPokedex(pokedexId);

      verify(mockPokedexLocal.get(pokedexId)).called(1);
      verifyNever(mockPokedexData.get(pokedexId));
      expect(result, expectedSuccess);
    });

    test('get data from remote if not in local and store locally', () async {
      when(mockPokedexLocal.get(pokedexId))
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockPokedexData.get(pokedexId))
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockConverter.convertToLocal(pokedexDataModel))
          .thenReturn(pokedexLocalModel);
      when(mockConverter.convertToDomain(pokedexLocalModel))
          .thenReturn(pokedexDomainModel);
      var result = await repository.getPokedex(pokedexId);

      verify(mockPokedexLocal.get(pokedexId)).called(1);
      verify(mockPokedexData.get(pokedexId)).called(1);
      verify(mockPokedexLocal.store(pokedexLocalModel)).called(1);
      expect(result, expectedSuccess);
    });

    test('return Failure on failure result', () async {
      when(mockPokedexLocal.get(pokedexId))
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockPokedexData.get(pokedexId))
          .thenAnswer((_) async => mockDataResultFailure);
      var result = await repository.getPokedex(pokedexId);

      expect(result, expectedFailure);
    });

    test('return Failure if conversion to local fails', () async {
      when(mockPokedexLocal.get(pokedexId))
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockPokedexData.get(pokedexId))
          .thenAnswer((_) async => mockDataResultSuccess);
      when(mockConverter.convertToLocal(pokedexDataModel))
          .thenThrow(NullException(NullType.id));

      var result = await repository.getPokedex(pokedexId);

      var nullFailure = Left(Failure("Null ID"));
      expect(result, nullFailure);
    });

    test('return Failure with empty message if null', () async {
      when(mockPokedexLocal.get(pokedexId))
          .thenAnswer((_) async => mockLocalResultFailure);
      Either<DataFailure, PokedexDataModel> emptyMessageDataFailure =
          Left(DataFailure(null));
      when(mockPokedexData.get(pokedexId))
          .thenAnswer((_) async => emptyMessageDataFailure);
      var result = await repository.getPokedex(pokedexId);

      var emptyMessageFailure = Left(Failure(""));
      expect(result, emptyMessageFailure);
    });
  });
}
