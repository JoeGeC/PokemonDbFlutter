class PokedexJsonMocks {

  static Map<String, dynamic> pokedexJson(int pokedexId, String pokedexName,
          int pokemonEntryNumber, String pokemonName, String pokemonUrl) =>
      {
        "id": pokedexId,
        "name": pokedexName,
        "pokemon_entries": [
          {
            "entry_number": pokemonEntryNumber,
            "pokemon_species": {
              "name": pokemonName, "url": pokemonUrl
            }
          }
        ]
      };
}
