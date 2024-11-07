import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokemon_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter_impl.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/models/local/pokedex_local.dart';
import 'package:repository/models/local/pokedex_pokemon_local.dart';

import 'pokedex_repository_converter_should.mocks.dart';

@GenerateMocks([PokemonRepositoryConverter])
void main() {
  late PokedexRepositoryConverterImpl pokedexConverter;
  late MockPokemonRepositoryConverter mockPokemonConverter;

  setUp(() {
    mockPokemonConverter = MockPokemonRepositoryConverter();
    pokedexConverter = PokedexRepositoryConverterImpl(mockPokemonConverter);
  });

  group("convert to domain", () {
    test('convert local model to domain model', () {
      int pokedexId = 1;
      String pokedexName = "Sample Pokedex";
      int pokemonId = 2;
      int pokemonEntryId = 3;
      String pokemonName = "Sample Pokemon";
      PokedexPokemonLocalModel pokedexPokemonLocalModel =
          PokedexPokemonLocalModel(
              pokemonId, {pokedexName: pokemonEntryId}, pokemonName);
      List<PokedexPokemonLocalModel> localPokemonList = [
        pokedexPokemonLocalModel
      ];
      PokedexLocalModel pokedexLocalModel =
          PokedexLocalModel(pokedexId, pokedexName, localPokemonList);
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
}
