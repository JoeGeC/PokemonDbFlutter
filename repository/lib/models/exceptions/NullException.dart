class NullException implements Exception{
  NullType type;

  NullException(this.type);
}

enum NullType{
  id,
  name,
  pokemonEntries
}