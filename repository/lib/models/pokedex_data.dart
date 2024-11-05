class PokedexData {
  int id;
  String name;
  List<PokedexPokemon> pokemon;

  PokedexData(this.id, this.name, this.pokemon);
}

class PokedexPokemon {
  int entryNumber;
  String name;
  String url;

  PokedexPokemon(this.entryNumber, this.name, this.url);
}
