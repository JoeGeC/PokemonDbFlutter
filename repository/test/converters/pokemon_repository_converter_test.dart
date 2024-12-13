import 'package:flutter_test/flutter_test.dart';
import 'package:repository/src/converters/pokemon/pokemon_repository_converter_impl.dart';
import 'package:repository/src/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/src/models/exceptions/NullException.dart';

import '../mocks/pokemon_mocks.dart';

void main() {
  late PokemonRepositoryConverterImpl pokemonConverter;

  setUp(() {
    pokemonConverter = PokemonRepositoryConverterImpl();
  });

  group("convert to domain", () {
    test('convert local model to domain model', () {
      var result = pokemonConverter
          .convertToDomain(PokemonRepoMocks.pokemonLocalModelWithEntryNumbers);

      expect(result, PokemonRepoMocks.pokemonDomainModel);
    });

    test('convert local model list to domain model list', () {
      var result = pokemonConverter.convertListToDomain(
          PokemonRepoMocks.detailedPokedexPokemonLocalList);

      expect(result, PokemonRepoMocks.pokemonPokedexDetailDomainList);
    });
  });

  group("convert to local", () {
    test('convert data model to local model', () {
      var result =
          pokemonConverter.convertToLocal(PokemonRepoMocks.pokemonDataModel);

      expect(result, PokemonRepoMocks.pokemonLocalModelNoEntryNumbers);
    });

    test('return null if id null', () {
      var result = pokemonConverter
          .convertToLocal(PokemonRepoMocks.nullIdPokemonDataModel);

      expect(result, null);
    });

    test('return null if name null', () {
      var result = pokemonConverter
          .convertToLocal(PokemonRepoMocks.nullNamePokemonDataModel);

      expect(result, null);
    });

    test('throw exception on getPokemonId() if id is null', () {
      expect(
          () => pokemonConverter.getPokemonId(null),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.id)));
    });
  });

  group("convert to local list", () {
    test('convert data list to local list', () {
      var result = pokemonConverter.convertPokedexListToLocal(
          PokemonRepoMocks.dataPokemonList, PokemonRepoMocks.pokedexId);

      expect(result, PokemonRepoMocks.undetailedPokedexPokemonLocalList);
    });

    test('dont include pokemon if null field', () {
      List<PokedexPokemonDataModel> dataPokemonList = [
        PokemonRepoMocks.pokedexPokemonNullIdModel,
        PokemonRepoMocks.pokedexPokemonDataModel
      ];

      var result = pokemonConverter.convertPokedexListToLocal(
          dataPokemonList, PokemonRepoMocks.pokedexId);

      expect(result, PokemonRepoMocks.undetailedPokedexPokemonLocalList);
    });

    test('throw exception if invalid url', () {
      String invalidUrl =
          "https://pokeapi.co/api/v2/pokemon-species/${PokemonRepoMocks.pokemonId}/extra";

      expect(
          () => pokemonConverter.getIdFromUrl(invalidUrl),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.id)));
    });

    test('throw exception if null url', () {
      expect(
          () => pokemonConverter.getIdFromUrl(null),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.id)));
    });

    test('return id on large number', () {
      int id = 2313452334;
      String longIdUrl = "https://pokeapi.co/api/v2/pokemon-species/$id/";

      int result = pokemonConverter.getIdFromUrl(longIdUrl);

      expect(result, id);
    });

    test('throw exception if entryNumber is null', () {
      expect(
          () => pokemonConverter.getEntryNumberAsMap(
              null, PokemonRepoMocks.pokedexId),
          throwsA(predicate(
              (e) => e is NullException && e.type == NullType.entryNumber)));
    });

    test('throw exception if name is null', () {
      expect(
          () => pokemonConverter.getPokemonName(null),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.name)));
    });

    test('return null if list is null', () {
      expect(
          pokemonConverter.convertPokedexListToLocal(
              null, PokemonRepoMocks.pokedexId),
          null);
    });
  });

  group('convert list to domain', () {
    test('return empty list if pokemon list is null', () {
      expect(pokemonConverter.convertListToDomain(null), []);
    });
  });
}
