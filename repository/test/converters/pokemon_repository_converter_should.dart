import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter_impl.dart';
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/models/exceptions/NullException.dart';
import 'package:repository/models/local/pokemon_local_model.dart';

void main() {
  late PokemonRepositoryConverterImpl pokemonConverter;
  late String pokedexName;
  late int pokemonId;
  late int pokemonEntryId;
  late String pokemonName;
  late PokemonLocalModel pokedexPokemonLocalModel;
  late List<PokemonLocalModel> localPokemonList;

  setUp(() {
    pokemonConverter = PokemonRepositoryConverterImpl();
    pokedexName = "Sample Pokedex";
    pokemonId = 2;
    pokemonEntryId = 3;
    pokemonName = "Sample Pokemon";
    pokedexPokemonLocalModel = PokemonLocalModel(
        id: pokemonId,
        pokedexEntryNumbers: {pokedexName: pokemonEntryId},
        name: pokemonName);
    localPokemonList = [pokedexPokemonLocalModel];
  });

  group("convert to domain", () {
    test('convert local model to domain model', () {
      PokemonModel pokemonDomainModel = PokemonModel(
          id: pokemonId,
          name: pokemonName,
          pokedexEntryNumbers: {pokedexName: pokemonEntryId});
      List<PokemonModel> domainPokemonList = [pokemonDomainModel];

      var result = pokemonConverter.convertToDomain(localPokemonList);

      expect(result, domainPokemonList);
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
      String pokedexName = "Sample Pokedex";

      var result =
          pokemonConverter.convertToLocal(dataPokemonList, pokedexName);

      expect(result, localPokemonList);
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
      String pokedexName = "Sample Pokedex";

      var result =
          pokemonConverter.convertToLocal(dataPokemonList, pokedexName);

      expect(result, localPokemonList);
    });

    test('throw exception if invalid url', () {
      String pokemonUrl =
          "https://pokeapi.co/api/v2/pokemon-species/$pokemonId/extra";

      expect(
          () => pokemonConverter.getPokemonId(pokemonUrl),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.id)));
    });

    test('throw exception if null url', () {
      expect(
          () => pokemonConverter.getPokemonId(null),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.id)));
    });

    test('return id on large number', () {
      int id = 2313452334;
      String pokemonUrl = "https://pokeapi.co/api/v2/pokemon-species/$id/";

      int result = pokemonConverter.getPokemonId(pokemonUrl);

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
