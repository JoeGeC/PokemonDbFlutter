import 'package:flutter_test/flutter_test.dart';
import 'package:local/converters/pokedex_local_converter.dart';
import 'package:local/database_constants.dart';
import 'package:repository/models/local/pokedex_local_model.dart';

void main(){
  const int pokedexId = 1;
  const String pokedexName = 'original-johto';
  late PokedexLocalConverter converter;

  setUp(() {
    converter = PokedexLocalConverter();
  });

  test('convert a valid PokedexLocalModel to a map', () {
    final pokedex = PokedexLocalModel(pokedexId, pokedexName, []);

    final result = converter.convert(pokedex);

    expect(result, {
      DatabaseColumnNames.id: pokedexId,
      DatabaseColumnNames.name: pokedexName,
    });
  });
}