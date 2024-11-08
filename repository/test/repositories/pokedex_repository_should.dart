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
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/models/local/pokedex_local.dart';
import 'package:repository/models/local/pokedex_pokemon_local.dart';
import 'package:repository/repositories/pokedex_repository_impl.dart';

import 'pokedex_repository_should.mocks.dart';

@GenerateMocks([PokedexData, PokedexLocal, PokedexRepositoryConverter])
void main() {
  group("get pokedex", () {
    late PokedexRepositoryImpl repository;
    late MockPokedexApi mockPokedexApi;
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
    late PokedexPokemonLocalModel pokedexPokemonLocalModel;
    late PokedexLocalModel pokedexLocalModel;
    late PokemonModel pokemonDomainModel;
    late PokedexModel pokedexDomainModel;
    late Either<Failure, PokedexDataModel> mockApiResultSuccess;
    late Either<Failure, PokedexDataModel> mockApiResultFailure;
    late Either<Failure, PokedexLocalModel> mockLocalResultSuccess;
    late Either<Failure, PokedexLocalModel> mockLocalResultFailure;
    late Either<Failure, PokedexModel> expectedFailure;
    late Either<Failure, PokedexModel> expectedSuccess;

    setUp(() {
      mockPokedexApi = MockPokedexApi();
      mockPokedexLocal = MockPokedexLocal();
      mockConverter = MockPokedexRepositoryConverter();
      repository = PokedexRepositoryImpl(
          mockPokedexApi, mockPokedexLocal, mockConverter);
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
      pokedexPokemonLocalModel = PokedexPokemonLocalModel(
          pokemonId, {pokemonName: pokemonEntryId}, pokemonName);
      pokedexLocalModel =
          PokedexLocalModel(pokedexId, pokemonName, [pokedexPokemonLocalModel]);
      pokemonDomainModel = PokemonModel(
          id: pokemonId,
          name: pokemonName,
          pokedexEntryNumbers: {pokedexName: pokemonEntryId});
      pokedexDomainModel =
          PokedexModel(pokedexId, pokedexName, [pokemonDomainModel]);
      mockApiResultSuccess = Right(pokedexDataModel);
      mockApiResultFailure = Left(Failure(failureMessage));
      mockLocalResultSuccess = Right(pokedexLocalModel);
      mockLocalResultFailure = Left(Failure(failureMessage));
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
      verifyNever(mockPokedexApi.get(pokedexId));
      expect(result, expectedSuccess);
    });

    test('get data from remote if not in local', () async {
      when(mockPokedexLocal.get(pokedexId))
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockPokedexApi.get(pokedexId))
          .thenAnswer((_) async => mockApiResultSuccess);
      when(mockConverter.convertToLocal(pokedexDataModel))
          .thenReturn(pokedexLocalModel);
      when(mockConverter.convertToDomain(pokedexLocalModel))
          .thenReturn(pokedexDomainModel);
      var result = await repository.getPokedex(pokedexId);

      verify(mockPokedexLocal.get(pokedexId)).called(1);
      verify(mockPokedexApi.get(pokedexId)).called(1);
      expect(result, expectedSuccess);
    });

    test('return Failure on failure result', () async {
      when(mockPokedexLocal.get(pokedexId))
          .thenAnswer((_) async => mockLocalResultFailure);
      when(mockPokedexApi.get(pokedexId))
          .thenAnswer((_) async => mockApiResultFailure);
      var result = await repository.getPokedex(pokedexId);

      expect(result, expectedFailure);
    });
  });
}
