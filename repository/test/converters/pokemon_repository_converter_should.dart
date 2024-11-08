import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter_impl.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter_impl.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/models/local/pokedex_local.dart';
import 'package:repository/models/local/pokedex_pokemon_local.dart';

import 'pokedex_repository_converter_should.mocks.dart';

void main() {
  late PokemonRepositoryConverterImpl pokemonConverter;
  late String pokedexName;
  late int pokemonId;
  late int pokemonEntryId;
  late String pokemonName;
  late PokedexPokemonLocalModel pokedexPokemonLocalModel;
  late List<PokedexPokemonLocalModel> localPokemonList;

  setUp(() {
    pokemonConverter = PokemonRepositoryConverterImpl();
    pokedexName = "Sample Pokedex";
    pokemonId = 2;
    pokemonEntryId = 3;
    pokemonName = "Sample Pokemon";
    pokedexPokemonLocalModel = PokedexPokemonLocalModel(
        pokemonId, {pokedexName: pokemonEntryId}, pokemonName);
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
      String pokemonUrl = "https://pokeapi.co/api/v2/pokemon-species/$pokemonId/";
      PokedexPokemonDataModel pokemonDataModel = PokedexPokemonDataModel(
        pokemonEntryId,
        pokemonName,
        pokemonUrl,
      );
      List<PokedexPokemonDataModel> dataPokemonList = [pokemonDataModel];
      String pokedexName = "Sample Pokedex";

      var result = pokemonConverter.convertToLocal(dataPokemonList, pokedexName);

      expect(result, localPokemonList);
    });

    test('return 0 if pokemon url is invalid', (){
      String pokemonUrl = "https://pokeapi.co/api/v2/pokemon-species/$pokemonId/extra";

      int result = pokemonConverter.getPokemonId(pokemonUrl);

      expect(result, 0);
    });

    test('return id on large number', (){
      int id = 2313452334;
      String pokemonUrl = "https://pokeapi.co/api/v2/pokemon-species/$id/";

      int result = pokemonConverter.getPokemonId(pokemonUrl);

      expect(result, id);
    });

  });
}
