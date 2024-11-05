import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokedex.dart';
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
    late MockPokedexApi mockPokedexApi;
    late PokedexRepositoryImpl repository;
    late int pokedexId;

    setUp(() {
      mockPokedexApi = MockPokedexApi();
      repository = PokedexRepositoryImpl(mockPokedexApi);
      pokedexId = 1;
    });

    test('get correct pokedex', () async {
      final result = PokedexData(1, "Sample Pokedex", []);
      when(mockPokedexApi.getPokedex(1)).thenAnswer((_) async => Right(result));

      await repository.getPokedex(pokedexId);

      verify(mockPokedexApi.getPokedex(pokedexId)).called(1);
    });

    test('return Failure on failure result', () async {
      var failureMessage = "Failure";
      Either<Failure, PokedexData> apiResult = Left(Failure(failureMessage));
      Either<Failure, Pokedex> expected = Left(Failure(failureMessage));

      when(mockPokedexApi.getPokedex(pokedexId))
          .thenAnswer((_) async => apiResult);

      var result = await repository.getPokedex(pokedexId);
      expect(result, expected);
    });
  });
}
