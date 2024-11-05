class PokedexData {
  int id;
  String name;
  List<PokedexPokemonData> pokemon;

  PokedexData(this.id, this.name, this.pokemon);
}

class PokedexPokemonData {
  int entryNumber;
  String name;
  String pokemonUrl;

  PokedexPokemonData(this.entryNumber, this.name, this.pokemonUrl);
}
