class PokedexDataModel {
  int id;
  String name;
  List<PokedexPokemonDataModel> pokemon;

  PokedexDataModel(this.id, this.name, this.pokemon);
}

class PokedexPokemonDataModel {
  int entryNumber;
  String name;
  String pokemonUrl;

  PokedexPokemonDataModel(this.entryNumber, this.name, this.pokemonUrl);
}
