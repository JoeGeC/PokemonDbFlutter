import 'package:dartz/dartz.dart';
import 'package:data/src/data/pokedex_data_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/repository.dart';

import '../mocks/pokedex_json_mocks.dart';
import 'pokedex_data_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late List<PokedexPokemonDataModel> pokemonEntries;
  late PokedexPokemonDataModel pokedexPokemonDataModel;
  late PokedexDataImpl pokedexDataImpl;
  const int pokedexId1 = 1;
  const String pokedexName1 = "Sample Pokedex";
  const int pokemonEntryNumber = 1;
  const String pokemonName = "Sample Pokemon";
  const String pokemonUrl = "https://sample-pokemon/url/1/";
  const String pokedexPath = "/pokedex/$pokedexId1/";

  setUp(() {
    mockDio = MockDio();
    pokedexDataImpl = PokedexDataImpl(mockDio);
    pokedexPokemonDataModel =
        PokedexPokemonDataModel(pokemonEntryNumber, pokemonName, pokemonUrl);
    pokemonEntries = [pokedexPokemonDataModel];
  });

  group('get pokedex', () {
    test('return failure on null data', () async {
      final nullResponse =
          Response(requestOptions: RequestOptions(), data: null);
      final expectedFailureResult = Left(DataFailure("ServerError"));

      when(mockDio.get(pokedexPath)).thenAnswer((_) async => nullResponse);
      var result = await pokedexDataImpl.get(pokedexId1);

      expect(result, expectedFailureResult);
    });

    test('return failure on DioException', () async {
      var errorMessage = "Error";
      final expectedFailureResult = Left(DataFailure(errorMessage));

      when(mockDio.get(pokedexPath)).thenThrow(DioException(
          requestOptions: RequestOptions(), message: errorMessage));
      var result = await pokedexDataImpl.get(pokedexId1);

      expect(result, expectedFailureResult);
    });

    test('return failure on Parsing error', () async {
      var errorMessage = "ParsingError";
      final expectedFailureResult = Left(DataFailure(errorMessage));

      when(mockDio.get(pokedexPath)).thenThrow(DioException(
          requestOptions: RequestOptions(), message: errorMessage));
      var result = await pokedexDataImpl.get(pokedexId1);

      expect(result, expectedFailureResult);
    });

    test('return pokedex on success', () async {
      final successResponse = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: PokedexJsonMocks.pokedexJson(pokedexId1, pokedexName1,
              pokemonEntryNumber, pokemonName, pokemonUrl));

      when(mockDio.get(pokedexPath)).thenAnswer((_) async => successResponse);
      var result = await pokedexDataImpl.get(pokedexId1);

      final expected =
          Right(PokedexDataModel(pokedexId1, pokedexName1, pokemonEntries));
      expect(result, expected);
    });
  });

}
