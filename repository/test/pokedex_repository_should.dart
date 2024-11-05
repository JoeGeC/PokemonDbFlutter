import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokemon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repository/models/pokedex_data.dart';
import 'package:repository/pokedex_repository_impl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/boundary/remote/pokedex_api.dart';
import 'pokedex_repository_should.mocks.dart';

// @GenerateNiceMocks([MockSpec<PokedexApi>()])
// import 'pokedexapi.mocks.dart';

@GenerateMocks([PokedexApi])
void main() {
  group("get pokedex", () {
    var pokedexApi = MockPokedexApi();
    var repository = PokedexRepositoryImpl(pokedexApi);

    test('get correct pokedex', () {
      repository.getPokedex(4);

      verify(pokedexApi.getPokedex(1));
    });


  });
}
