import 'package:dartz/dartz.dart';
import 'package:data/data/pokemon_data_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/models/data/pokemon/pokemon_data_model.dart';
import 'package:repository/models/data_failure.dart';

import '../json_mocks/pokemon_json_mocks.dart';
import '../pokedex/pokedex_data_should.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late String path;
  late PokemonDataImpl pokemonDataImpl;
  late PokemonDataModel pokemonDataModel;
  late int pokemonId = 1;
  late String pokemonName = "Sample Pokemon";
  late String pokemonType1 = "Grass";
  late String pokemonType2 = "Poison";
  late String frontSpriteUrl = "https://sample/pokemon.png";

  setUp(() {
    mockDio = MockDio();
    path = "/pokemon/$pokemonId/";
    pokemonDataImpl = PokemonDataImpl(mockDio);
    pokemonDataModel = PokemonDataModel(
        pokemonId, pokemonName, [pokemonType1, pokemonType2], frontSpriteUrl);
  });

  group('get pokemon', () {
    test('return failure on null data', () async {
      final nullResponse =
          Response(requestOptions: RequestOptions(), data: null);
      final expectedFailureResult = Left(DataFailure("ServerError"));

      when(mockDio.get(path)).thenAnswer((_) async => nullResponse);
      var result = await pokemonDataImpl.get(pokemonId);

      expect(result, expectedFailureResult);
    });

    test('return failure on DioException', () async {
      var errorMessage = "Error";
      final expectedFailureResult = Left(DataFailure(errorMessage));

      when(mockDio.get(path)).thenThrow(DioException(
          requestOptions: RequestOptions(), message: errorMessage));
      var result = await pokemonDataImpl.get(pokemonId);

      expect(result, expectedFailureResult);
    });

    test('return failure on Parsing error', () async {
      var errorMessage = "ParsingError";
      final expectedFailureResult = Left(DataFailure(errorMessage));

      when(mockDio.get(path)).thenThrow(DioException(
          requestOptions: RequestOptions(), message: errorMessage));
      var result = await pokemonDataImpl.get(pokemonId);

      expect(result, expectedFailureResult);
    });

    test('return pokemon on success', () async {
      final successResponse = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: PokemonJsonMocks.pokemonJson(pokemonId, pokemonName,
              pokemonType1, pokemonType2, frontSpriteUrl));

      when(mockDio.get(path)).thenAnswer((_) async => successResponse);
      var result = await pokemonDataImpl.get(pokemonId);

      expect(result, Right(pokemonDataModel));
    });
  });
}
