import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter_impl.dart';
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/models/data/pokemon/pokemon_data_model.dart';
import 'package:repository/models/exceptions/NullException.dart';
import 'package:repository/models/local/pokemon_local_model.dart';

void main() {
  late PokemonRepositoryConverterImpl pokemonConverter;
  final int pokedexId = 5;
  final int pokemonId = 1;
  final int pokemonEntryId = 2;
  final String pokemonName = "Sample Pokemon";
  final String pokemonType1 = "Grass";
  final String pokemonType2 = "Poison";
  final String frontSpriteUrl = "https://sample/pokemon.png";
  final String pokemonUrl =
      "https://pokeapi.co/api/v2/pokemon-species/$pokemonId/";
  late PokemonLocalModel pokedexPokemonLocalModel;
  late PokemonLocalModel pokemonLocalModel;
  late PokemonModel pokemonDomainModel;
  late PokemonDataModel pokemonDataModel;
  late PokedexPokemonDataModel pokedexPokemonDataModel;
  late List<PokemonLocalModel> pokemonLocalList;
  late List<PokemonModel> pokemonDomainList;
  late List<PokedexPokemonDataModel> dataPokemonList;

  setUp(() {
    pokemonConverter = PokemonRepositoryConverterImpl();
    pokedexPokemonLocalModel = PokemonLocalModel(
      id: pokemonId,
      pokedexEntryNumbers: {pokedexId: pokemonEntryId},
      name: pokemonName,
      types: [pokemonType1, pokemonType2],
      frontSpriteUrl: frontSpriteUrl,
    );
    pokemonLocalModel = PokemonLocalModel(
      id: pokemonId,
      name: pokemonName,
      types: [pokemonType1, pokemonType2],
      frontSpriteUrl: frontSpriteUrl,
    );
    pokemonDomainModel = PokemonModel(
      id: pokemonId,
      name: pokemonName,
      pokedexEntryNumbers: {pokedexId: pokemonEntryId},
      types: [pokemonType1, pokemonType2],
      imageUrl: frontSpriteUrl,
    );
    pokemonDataModel = PokemonDataModel(
      pokemonId,
      pokemonName,
      [pokemonType1, pokemonType2],
      pokemonUrl,
    );
    pokedexPokemonDataModel = PokedexPokemonDataModel(
      pokemonEntryId,
      pokemonName,
      pokemonUrl,
    );
    dataPokemonList = [pokedexPokemonDataModel];
    pokemonDomainList = [pokemonDomainModel];
    pokemonLocalList = [pokedexPokemonLocalModel];
  });

  group("convert to domain", () {
    test('convert local model to domain model', () {
      var result = pokemonConverter.convertToDomain(pokedexPokemonLocalModel);

      expect(result, pokemonDomainModel);
    });

    test('convert local model list to domain model list', () {
      var result = pokemonConverter.convertListToDomain(pokemonLocalList);

      expect(result, pokemonDomainList);
    });
  });

  group("convert to local", () {
    test('convert data model to local model', () {
      var result = pokemonConverter.convertToLocal(pokemonDataModel);

      expect(result, pokemonLocalModel);
    });

    test('return null if id null', () {
      PokemonDataModel invalidIdPokemonDataModel =
          PokemonDataModel(null, pokemonName, [pokemonType1], frontSpriteUrl);

      var result = pokemonConverter.convertToLocal(invalidIdPokemonDataModel);

      expect(result, null);
    });

    test('return null if name null', () {
      PokemonDataModel invalidIdPokemonDataModel =
          PokemonDataModel(pokemonId, null, [pokemonType1], frontSpriteUrl);

      var result = pokemonConverter.convertToLocal(invalidIdPokemonDataModel);

      expect(result, null);
    });

    test('throw exception if id is null', () {
      expect(
          () => pokemonConverter.getPokemonId(null),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.id)));
    });
  });

  group("convert to local list", () {
    test('convert data list to local list', () {
      var result = pokemonConverter.convertPokedexListToLocal(
          dataPokemonList, pokedexId);

      expect(result, pokemonLocalList);
    });

    test('dont include pokemon if null field', () {
      PokedexPokemonDataModel pokemonNullDataModel = PokedexPokemonDataModel(
        null,
        pokemonName,
        pokemonUrl,
      );
      List<PokedexPokemonDataModel> dataPokemonList = [
        pokemonNullDataModel,
        pokedexPokemonDataModel
      ];

      var result = pokemonConverter.convertPokedexListToLocal(
          dataPokemonList, pokedexId);

      expect(result, pokemonLocalList);
    });

    test('throw exception if invalid url', () {
      String invalidUrl =
          "https://pokeapi.co/api/v2/pokemon-species/$pokemonId/extra";

      expect(
          () => pokemonConverter.getPokemonIdFromUrl(invalidUrl),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.id)));
    });

    test('throw exception if null url', () {
      expect(
          () => pokemonConverter.getPokemonIdFromUrl(null),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.id)));
    });

    test('return id on large number', () {
      int id = 2313452334;
      String longIdUrl = "https://pokeapi.co/api/v2/pokemon-species/$id/";

      int result = pokemonConverter.getPokemonIdFromUrl(longIdUrl);

      expect(result, id);
    });

    test('throw exception if entryNumber is null', () {
      expect(
          () => pokemonConverter.getEntryNumberAsMap(null, pokedexId),
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
      expect(pokemonConverter.convertPokedexListToLocal(null, pokedexId), null);
    });
  });

  group('convert list to domain', () {
    test('return empty list if pokemon list is null', () {
      expect(pokemonConverter.convertListToDomain(null), []);
    });
  });
}
