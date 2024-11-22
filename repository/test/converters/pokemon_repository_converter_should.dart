import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter_impl.dart';
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/models/exceptions/NullException.dart';
import 'package:repository/models/local/pokemon_local_model.dart';

void main() {
  late PokemonRepositoryConverterImpl pokemonConverter;
  late final String pokedexName = "sample-pokedex";
  late final int pokemonId = 1;
  late final int pokemonEntryId = 2;
  late final String pokemonName = "Sample Pokemon";
  late final String pokemonType1 = "Grass";
  late final String pokemonType2 = "Poison";
  late final String frontSpriteUrl = "https://sample/pokemon.png";
  late PokemonLocalModel pokemonLocalModel;
  late PokemonModel pokemonDomainModel;
  late List<PokemonLocalModel> pokemonLocalList;
  late List<PokemonModel> pokemonDomainList;

  setUp(() {
    pokemonConverter = PokemonRepositoryConverterImpl();
    pokemonLocalModel = PokemonLocalModel(
      id: pokemonId,
      pokedexEntryNumbers: {pokedexName: pokemonEntryId},
      name: pokemonName,
      types: [pokemonType1, pokemonType2],
      frontSpriteUrl: frontSpriteUrl,
    );
    pokemonDomainModel = PokemonModel(
      id: pokemonId,
      name: pokemonName,
      pokedexEntryNumbers: {pokedexName: pokemonEntryId},
      types: [pokemonType1, pokemonType2],
      imageUrl: frontSpriteUrl,
    );
    pokemonDomainList = [pokemonDomainModel];
    pokemonLocalList = [pokemonLocalModel];
  });

  group("convert to domain", () {
    test('convert local model to domain model', () {
      var result = pokemonConverter.convertToDomain(pokemonLocalModel);

      expect(result, pokemonDomainModel);
    });

    test('convert local model list to domain model list', () {
      var result = pokemonConverter.convertListToDomain(pokemonLocalList);

      expect(result, pokemonDomainList);
    });
  });

  group("convert to local", () {
    test('convert data model to local model', () {
      String pokemonUrl =
          "https://pokeapi.co/api/v2/pokemon-species/$pokemonId/";
      PokedexPokemonDataModel pokemonDataModel = PokedexPokemonDataModel(
        pokemonEntryId,
        pokemonName,
        pokemonUrl,
      );
      List<PokedexPokemonDataModel> dataPokemonList = [pokemonDataModel];

      var result =
          pokemonConverter.convertPokedexListToLocal(dataPokemonList, pokedexName);

      expect(result, pokemonLocalList);
    });

    test('dont include pokemon if null field', () {
      String pokemonUrl =
          "https://pokeapi.co/api/v2/pokemon-species/$pokemonId/";
      PokedexPokemonDataModel pokemonDataModel = PokedexPokemonDataModel(
        pokemonEntryId,
        pokemonName,
        pokemonUrl,
      );
      PokedexPokemonDataModel pokemonNullDataModel = PokedexPokemonDataModel(
        null,
        pokemonName,
        pokemonUrl,
      );
      List<PokedexPokemonDataModel> dataPokemonList = [
        pokemonNullDataModel,
        pokemonDataModel
      ];

      var result =
          pokemonConverter.convertPokedexListToLocal(dataPokemonList, pokedexName);

      expect(result, pokemonLocalList);
    });

    test('throw exception if invalid url', () {
      String pokemonUrl =
          "https://pokeapi.co/api/v2/pokemon-species/$pokemonId/extra";

      expect(
          () => pokemonConverter.getPokemonIdFromUrl(pokemonUrl),
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
      String pokemonUrl = "https://pokeapi.co/api/v2/pokemon-species/$id/";

      int result = pokemonConverter.getPokemonIdFromUrl(pokemonUrl);

      expect(result, id);
    });

    test('throw exception if entryNumber is null', () {
      expect(
          () => pokemonConverter.getEntryNumberAsMap(null, pokedexName),
          throwsA(predicate(
              (e) => e is NullException && e.type == NullType.entryNumber)));
    });

    test('throw exception if name is null', () {
      expect(
          () => pokemonConverter.getPokemonName(null),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.name)));
    });
  });
}
