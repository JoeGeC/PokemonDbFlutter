import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter_impl.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';
import 'package:repository/models/exceptions/NullException.dart';
import 'package:repository/models/local/pokedex_local.dart';
import 'package:repository/models/local/pokedex_pokemon_local.dart';

import 'pokedex_repository_converter_should.mocks.dart';

@GenerateMocks([PokemonRepositoryConverter])
void main() {
  late PokedexRepositoryConverterImpl pokedexConverter;
  late MockPokemonRepositoryConverter mockPokemonConverter;
  late int pokedexId;
  late String pokedexName;
  late int pokemonId;
  late int pokemonEntryId;
  late String pokemonName;
  late PokedexPokemonLocalModel pokedexPokemonLocalModel;
  late List<PokedexPokemonLocalModel> localPokemonList;
  late PokedexLocalModel pokedexLocalModel;
  late List<PokedexPokemonDataModel> dataPokemonList;
  late PokedexPokemonDataModel pokemonDataModel;
  late String pokemonUrl;

  setUp(() {
    mockPokemonConverter = MockPokemonRepositoryConverter();
    pokedexConverter = PokedexRepositoryConverterImpl(mockPokemonConverter);
    pokedexId = 1;
    pokedexName = "Sample Pokedex";
    pokemonId = 2;
    pokemonEntryId = 3;
    pokemonName = "Sample Pokemon";
    pokedexPokemonLocalModel = PokedexPokemonLocalModel(
        pokemonId, {pokedexName: pokemonEntryId}, pokemonName);
    localPokemonList = [pokedexPokemonLocalModel];
    pokedexLocalModel =
        PokedexLocalModel(pokedexId, pokedexName, localPokemonList);
    pokemonUrl = "url/$pokemonId/";
    pokemonDataModel = PokedexPokemonDataModel(
      pokemonEntryId,
      pokemonName,
      pokemonUrl,
    );
    dataPokemonList = [pokemonDataModel];
  });

  group("convert to domain", () {
    test('convert local model to domain model', () {
      PokemonModel pokemonDomainModel = PokemonModel(
          id: pokemonId,
          name: pokemonName,
          pokedexEntryNumbers: {pokemonName: pokemonEntryId});
      List<PokemonModel> domainPokemonList = [pokemonDomainModel];
      PokedexModel pokedexModel =
          PokedexModel(pokedexId, pokedexName, domainPokemonList);

      when(mockPokemonConverter.convertToDomain(localPokemonList))
          .thenReturn(domainPokemonList);
      var result = pokedexConverter.convertToDomain(pokedexLocalModel);

      expect(result, pokedexModel);
    });
  });

  group("convert to local", () {
    test('convert data model to local model', () {
      PokedexDataModel pokedexDataModel =
          PokedexDataModel(pokedexId, pokedexName, dataPokemonList);

      when(mockPokemonConverter.convertToLocal(dataPokemonList, pokedexName))
          .thenReturn(localPokemonList);
      var result = pokedexConverter.convertToLocal(pokedexDataModel);

      expect(result, pokedexLocalModel);
    });

    test('throw exception if null id', () {
      PokedexDataModel pokedexDataModel =
          PokedexDataModel(null, pokedexName, dataPokemonList);

      expect(
          () => pokedexConverter.convertToLocal(pokedexDataModel),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.id)));
    });

    test('throw exception if null name', () {
      PokedexDataModel pokedexDataModel =
          PokedexDataModel(pokedexId, null, dataPokemonList);

      expect(
          () => pokedexConverter.convertToLocal(pokedexDataModel),
          throwsA(
              predicate((e) => e is NullException && e.type == NullType.name)));
    });

    test('throw exception if null pokemon entries', () {
      PokedexDataModel pokedexDataModel =
          PokedexDataModel(pokedexId, pokemonName, null);

      expect(
          () => pokedexConverter.convertToLocal(pokedexDataModel),
          throwsA(predicate(
              (e) => e is NullException && e.type == NullType.pokemonEntries)));
    });
  });
}
