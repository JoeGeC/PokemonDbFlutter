import 'package:dartz/dartz.dart';
import 'package:data/data/pokedex_data_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/models/data/data_failure.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';

import 'pokedex_data_should.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late int pokedexId;
  late String path;
  late PokedexDataImpl pokedexDataImpl;
  late String pokedexName;
  late List<PokedexPokemonDataModel> pokemonEntries;
  late PokedexPokemonDataModel pokedexPokemonDataModel;
  late Map<String, dynamic> successJson;
  late int pokemonEntryNumber;
  late String pokemonName;
  late String pokemonUrl;

  setUp(() {
    mockDio = MockDio();
    pokedexId = 3;
    path = "/pokedex/$pokedexId/";
    pokedexDataImpl = PokedexDataImpl(mockDio);
    pokedexName = "Sample Pokedex";
    pokemonEntryNumber = 1;
    pokemonName = "Sample Pokemon";
    pokemonUrl = "url";
    pokedexPokemonDataModel =
        PokedexPokemonDataModel(pokemonEntryNumber, pokemonName, pokemonUrl);
    pokemonEntries = [pokedexPokemonDataModel];
    successJson = {
      "id": pokedexId,
      "name": pokedexName,
      "pokemon_entries": [
        {
          "entry_number": pokemonEntryNumber,
          "pokemon_species": {
            {
              "name": pokemonName,
              "url": pokemonUrl
            }
          }
        }
      ]
    };
  });

  group('get pokedex', () {
    test('return failure on null data', () async {
      final nullResponse =
          Response(requestOptions: RequestOptions(), data: null);
      final expectedFailureResult = Left(DataFailure("ServerError"));

      when(mockDio.get(path)).thenAnswer((_) async => nullResponse);
      var result = await pokedexDataImpl.get(pokedexId);

      expect(result, expectedFailureResult);
    });

    test('return failure on DioException', () async {
      var errorMessage = "Error";
      final expectedFailureResult = Left(DataFailure(errorMessage));

      when(mockDio.get(path)).thenThrow(DioException(requestOptions: RequestOptions(), message: errorMessage));
      var result = await pokedexDataImpl.get(pokedexId);

      expect(result, expectedFailureResult);
    });

    test('return pokedex on success', () async {
      final successResponse = Response(
          requestOptions: RequestOptions(), statusCode: 200, data: successJson);

      when(mockDio.get(path)).thenAnswer((_) async => successResponse);
      var result = await pokedexDataImpl.get(pokedexId);

      final expected =
          Right(PokedexDataModel(pokedexId, pokedexName, pokemonEntries));
      expect(result, expected);
    });
  });
}
