import 'package:local/database_constants.dart';
import 'package:repository/models/local/pokedex_local_model.dart';

import 'mock_pokemon.dart';

class MockLocalPokedex {
  static const int pokedexId1 = 1;
  static const int pokedexId2 = 2;
  static const String pokedexName1 = "original-johto";
  static const String pokedexName2 = "Sample pokedex";

  static const multPokemonPokedexModel = PokedexLocalModel(
    id: pokedexId1,
    name: pokedexName1,
    pokemon: [
      MockLocalPokemon.pokemon,
      MockLocalPokemon.pokemon2,
    ],
  );

  static const pokedexModel1 = PokedexLocalModel(
    id: pokedexId1,
    name: pokedexName1,
    pokemon: [
      MockLocalPokemon.pokemon,
    ],
  );

  static const noPokemonPokedexModel1 = PokedexLocalModel(
    id: pokedexId1,
    name: pokedexName1,
  );

  static const pokedexModel2 = PokedexLocalModel(
    id: pokedexId2,
    name: pokedexName2,
  );

  static const List<PokedexLocalModel> noPokemonPokedexList = [
    noPokemonPokedexModel1,
    pokedexModel2,
  ];

  static const pokedexMap1 = {
    DatabaseColumnNames.id: pokedexId1,
    DatabaseColumnNames.name: pokedexName1,
  };

  static const pokedexMap2 = {
    DatabaseColumnNames.id: pokedexId2,
    DatabaseColumnNames.name: pokedexName2,
  };
}
