import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokedex.dart';
import 'package:domain/models/pokedex_pokemon.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/boundary/remote/pokedex_api.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter.dart';
import 'package:repository/models/pokedex_data.dart';
import 'package:repository/repositories/pokedex_repository_impl.dart';
import 'pokedex_repository_should.mocks.dart';

@GenerateMocks([PokedexApi, PokedexRepositoryConverter])
void main() {
  group("get pokedex", () {
    late MockPokedexApi mockPokedexApi;
    late MockPokedexRepositoryConverter mockConverter;
    late PokedexRepositoryImpl repository;
    late int pokedexId;
    late String pokedexName;
    late PokedexData pokedexData;
    late PokedexPokemonData pokedexPokemonData;
    late String pokemonName;
    late int pokemonEntryId;
    late int pokemonId;
    late PokedexPokemon pokedexPokemonModel;
    late Pokedex pokedexModel;

    setUp(() {
      mockPokedexApi = MockPokedexApi();
      mockConverter = MockPokedexRepositoryConverter();
      repository = PokedexRepositoryImpl(mockPokedexApi, mockConverter);
      pokedexId = 1;
      pokedexName = "Sample Pokedex";
      pokemonName = "Sample Pokemon";
      pokedexPokemonData = PokedexPokemonData(1, pokemonName, "url");
      pokedexData = PokedexData(pokedexId, pokedexName, [pokedexPokemonData]);
      pokemonEntryId = 3;
      pokemonId = 2;
      pokedexPokemonModel = PokedexPokemon(pokemonId, {pokedexId: pokemonEntryId}, pokemonName);
      pokedexModel = Pokedex(pokedexId, pokedexName, [pokedexPokemonModel]);
    });


    test('get correct pokedex', () async {
      final result = PokedexData(pokedexId, pokedexName, []);
      when(mockPokedexApi.getPokedex(pokedexId))
          .thenAnswer((_) async => Right(result));

      await repository.getPokedex(pokedexId);

      verify(mockPokedexApi.getPokedex(pokedexId)).called(1);
    });


    test('return Failure on failure result', () async {
      var failureMessage = "Failure";
      Either<Failure, PokedexData> mockApiResult =
          Left(Failure(failureMessage));
      Either<Failure, Pokedex> expected = Left(Failure(failureMessage));

      when(mockPokedexApi.getPokedex(pokedexId))
          .thenAnswer((_) async => mockApiResult);

      var result = await repository.getPokedex(pokedexId);
      expect(result, expected);
    });


    test('return pokedex on result', () async {
      Either<Failure, PokedexData> mockApiResult = Right(pokedexData);
      Either<Failure, Pokedex> expected = Right(pokedexModel);

      when(mockConverter.convert(pokedexData)).thenReturn(pokedexModel);
      when(mockPokedexApi.getPokedex(pokedexId))
          .thenAnswer((_) async => mockApiResult);

      var result = await repository.getPokedex(pokedexId);
      expect(result, expected);
    });
  });
}
