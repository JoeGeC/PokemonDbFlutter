import 'package:dartz/dartz.dart';
import 'package:data/data/pokedex_list_data_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/models/data/pokedex_list/pokedex_list_data_model.dart';
import 'package:repository/models/data/pokedex_list/pokedex_list_item_data_model.dart';

import '../json_mocks/pokedex_json_mocks.dart';
import '../pokedex/pokedex_data_should.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late MockDio mockDio;
  late PokedexListDataImpl pokedexListDataImpl;
  const int pokedexId1 = 1;
  const int pokedexId2 = 2;
  const String pokedexName1 = "Sample Pokedex";
  const String pokedexName2 = "Sample Pokedex 2";
  const String pokedexUrl1 = "https://sample-pokedex/url/$pokedexId1/";
  const String pokedexUrl2 = "https://sample-pokedex/url/$pokedexId2/";
  const String pokedexListPath = "/pokedex";

  setUp(() {
    mockDio = MockDio();
    pokedexListDataImpl = PokedexListDataImpl(mockDio);
  });

  group('get list of pokedex', () {
    test('get all', () async {
      final successResponse = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          data: PokedexJsonMocks.pokedexListJson(
              pokedexName1, pokedexUrl1, pokedexName2, pokedexUrl2));

      when(mockDio.get(pokedexListPath, queryParameters: {'limit': '9999'}))
          .thenAnswer((_) async => successResponse);
      var result = await pokedexListDataImpl.getAll();

      final expected = Right(PokedexListDataModel([
        PokedexListItemDataModel(pokedexName1, pokedexUrl1),
        PokedexListItemDataModel(pokedexName2, pokedexUrl2)
      ]));
      expect(result, expected);
    });
  });
}
