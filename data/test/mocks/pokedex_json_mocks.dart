class PokedexJsonMocks {
  static Map<String, dynamic> pokedexListJson(String pokedexName1,
          String pokedexUrl1, String pokedexName2, String pokedexUrl2) =>
      {
        "count": 32,
        "next": null,
        "previous": null,
        "results": [
          {"name": pokedexName1, "url": pokedexUrl1},
          {"name": pokedexName2, "url": pokedexUrl2},
        ],
      };

  static Map<String, dynamic> pokedexJson(int pokedexId, String pokedexName,
          int pokemonEntryNumber, String pokemonName, String pokemonUrl) =>
      {
        "id": pokedexId,
        "name": pokedexName,
        "pokemon_entries": [
          {
            "entry_number": pokemonEntryNumber,
            "pokemon_species": {"name": pokemonName, "url": pokemonUrl}
          }
        ]
      };
}
