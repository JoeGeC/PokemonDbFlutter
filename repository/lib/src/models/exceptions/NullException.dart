class NullException implements Exception {
  NullType type;

  NullException(this.type);

  String getErrorMessage() => switch(type){
      NullType.id => "Null ID",
      NullType.name => "Null Name",
      NullType.pokemonEntries => "Null Pokemon Entries",
      NullType.entryNumber => "Null Entry Number",
      NullType.pokemonTypes => "Null Pokemon Types",
    };
}

enum NullType { id, name, pokemonEntries, entryNumber, pokemonTypes }
