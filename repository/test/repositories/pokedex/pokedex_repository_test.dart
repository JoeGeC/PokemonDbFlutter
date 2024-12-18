import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/src/boundary/local/pokedex_local.dart';
import 'package:repository/src/boundary/remote/pokedex_data.dart';
import 'package:repository/src/converters/pokedex/pokedex_repository_converter.dart';
import 'package:repository/src/models/data_failure.dart';
import 'package:repository/src/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/src/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/src/models/exceptions/NullException.dart';
import 'package:repository/src/models/local/pokedex_local_model.dart';
import 'package:repository/src/models/local/pokemon_local_model.dart';
import 'package:repository/src/repositories/pokedex_repository_impl.dart';

import 'pokedex_repository_test.mocks.dart';

@GenerateMocks([PokedexData, PokedexLocal, PokedexRepositoryConverter])
void main() {
  group("get pokedex", () {
    late PokedexRepositoryImpl repository;
    late MockPokedexData mockPokedexData;
    late MockPokedexLocal mockPokedexLocal;
    late MockPokedexRepositoryConverter mockConverter;
    late String failureMessage;
    late int pokedexId;
    late String pokedexDataName;
    late PokedexName pokedexName = PokedexName.originalJohto;
    late int pokemonEntryId;
    late int pokemonId;
    late String pokemonName;
    late PokedexPokemonDataModel pokedexPokemonData;
    late PokedexDataModel pokedexDataModel;
    late PokemonLocalModel pokedexPokemonLocalModel;
    late PokedexLocalModel pokedexLocalModel;
    late PokedexLocalModel pokedexLocalModelNoPokemon;
    late PokedexLocalModel pokedexLocalModelNullPokemon;
    late PokemonModel pokemonDomainModel;
    late PokedexModel pokedexDomainModel;
    late Either<DataFailure, PokedexDataModel> mockDataResultSuccess;
    late Either<DataFailure, PokedexDataModel> mockDataResultFailure;
    late Either<DataFailure, PokedexLocalModel> mockLocalResultSuccess;
    late Either<DataFailure, PokedexLocalModel> mockLocalResultSuccessNoPokemon;
    late Either<DataFailure, PokedexLocalModel> mockLocalResultSuccessNullPokemon;
    late Either<DataFailure, PokedexLocalModel> mockLocalResultFailure;
    late Either<Failure, PokedexModel> expectedFailure;
    late Either<Failure, PokedexModel> expectedSuccess;
    const PokemonRegion region = PokemonRegion.johto;
    const List<PokemonVersion> versions = [PokemonVersion.goldSilverCrystal];

    setUp(() {
      mockPokedexData = MockPokedexData();
      mockPokedexLocal = MockPokedexLocal();
      mockConverter = MockPokedexRepositoryConverter();
      repository = PokedexRepositoryImpl(
          mockPokedexData, mockPokedexLocal, mockConverter);
      failureMessage = "Failure";
      pokedexId = 1;
      pokedexDataName = "Sample Pokedex";
      pokemonEntryId = 3;
      pokemonId = 2;
      pokemonName = "Sample Pokemon";
      pokedexPokemonData =
          PokedexPokemonDataModel(pokemonId, pokemonName, "url");
      pokedexDataModel =
          PokedexDataModel(pokedexId, pokedexDataName, [pokedexPokemonData]);
      pokedexPokemonLocalModel = PokemonLocalModel(
          id: pokemonId,
          pokedexEntryNumbers: {pokedexId: pokemonEntryId},
          name: pokemonName);
      pokedexLocalModel = PokedexLocalModel(
          id: pokedexId,
          name: pokemonName,
          pokemon: [pokedexPokemonLocalModel]);
      pokedexLocalModelNoPokemon = PokedexLocalModel(
          id: pokedexId,
          name: pokemonName,
          pokemon: []);
      pokedexLocalModelNullPokemon = PokedexLocalModel(
          id: pokedexId,
          name: pokemonName,
          pokemon: null);
      pokemonDomainModel = PokemonModel(
          id: pokemonId,
          name: pokemonName,
          pokedexEntryNumbers: {pokedexId: pokemonEntryId});
      pokedexDomainModel = PokedexModel(
          id: pokedexId, name: pokedexName, region: region,
          versions: versions, pokemon: [pokemonDomainModel]);
      mockDataResultSuccess = Right(pokedexDataModel);
      mockDataResultFailure = Left(DataFailure(failureMessage));
      mockLocalResultSuccess = Right(pokedexLocalModel);
      mockLocalResultSuccessNoPokemon = Right(pokedexLocalModelNoPokemon);
      mockLocalResultSuccessNullPokemon = Right(pokedexLocalModelNullPokemon);
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

    test('get data from remote if no pokemon in local and store locally', () async {
      when(mockPokedexLocal.get(pokedexId))
          .thenAnswer((_) async => mockLocalResultSuccessNoPokemon);
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

    test('get data from remote if null pokemon in local and store locally', () async {
      when(mockPokedexLocal.get(pokedexId))
          .thenAnswer((_) async => mockLocalResultSuccessNullPokemon);
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
