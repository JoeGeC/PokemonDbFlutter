import 'package:dartz/dartz.dart';
import 'package:data/src/data/pokemon_data_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/repository.dart';

import '../mocks/pokemon_mocks.dart';
import '../pokedex/pokedex_data_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late String path;
  late PokemonDataImpl pokemonDataImpl;

  setUp(() {
    mockDio = MockDio();
    path = "/pokemon/${PokemonDataMocks.pokemonId}/";
    pokemonDataImpl = PokemonDataImpl(mockDio);
  });

  group('get pokemon', () {
    test('return failure on null data', () async {
      final nullResponse =
          Response(requestOptions: RequestOptions(), data: null);
      final expectedFailureResult = Left(DataFailure("ServerError"));

      when(mockDio.get(path)).thenAnswer((_) async => nullResponse);
      var result = await pokemonDataImpl.get(PokemonDataMocks.pokemonId);

      expect(result, expectedFailureResult);
    });

    test('return failure on DioException', () async {
      var errorMessage = "Error";
      final expectedFailureResult = Left(DataFailure(errorMessage));

      when(mockDio.get(path)).thenThrow(DioException(
          requestOptions: RequestOptions(), message: errorMessage));
      var result = await pokemonDataImpl.get(PokemonDataMocks.pokemonId);

      expect(result, expectedFailureResult);
    });

    test('return failure on Parsing error', () async {
      var errorMessage = "ParsingError";
      final expectedFailureResult = Left(DataFailure(errorMessage));

      when(mockDio.get(path)).thenThrow(DioException(
          requestOptions: RequestOptions(), message: errorMessage));
      var result = await pokemonDataImpl.get(PokemonDataMocks.pokemonId);

      expect(result, expectedFailureResult);
    });

    test('return pokemon on success', () async {
      final successResponse = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: PokemonDataMocks.pokemonJson);

      when(mockDio.get(path)).thenAnswer((_) async => successResponse);
      var result = await pokemonDataImpl.get(PokemonDataMocks.pokemonId);

      expect(result, Right(PokemonDataMocks.pokemonDataModel));
    });
  });
}
