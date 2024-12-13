import 'package:local/src/database_constants.dart';
import 'package:repository/repository.dart';

class PokedexLocalConverter{
  Map<String, dynamic> convert(PokedexLocalModel pokedex) => {
    DatabaseColumnNames.id: pokedex.id,
    DatabaseColumnNames.name: pokedex.name,
  };
}