import 'package:flutter_test/flutter_test.dart';
import 'package:local/src/converters/pokedex_local_converter.dart';
import 'package:local/src/database_constants.dart';
import 'package:repository/repository.dart';

void main() {
  const int pokedexId = 1;
  const String pokedexName = 'original-johto';
  late PokedexLocalConverter converter;

  setUp(() {
    converter = PokedexLocalConverter();
  });

  test('convert a valid PokedexLocalModel to a map', () {
    final pokedex =
        PokedexLocalModel(id: pokedexId, name: pokedexName, pokemon: []);

    final result = converter.convert(pokedex);

    expect(result, {
      DatabaseColumnNames.id: pokedexId,
      DatabaseColumnNames.name: pokedexName,
    });
  });

  test('convert a PokedexLocalModel with an empty name to a map', () {
    final pokedex = PokedexLocalModel(id: pokedexId, name: '', pokemon: []);

    final result = converter.convert(pokedex);

    expect(result, {
      DatabaseColumnNames.id: pokedexId,
      DatabaseColumnNames.name: '',
    });
  });

  test('handle negative ID gracefully', () {
    final pokedex = PokedexLocalModel(id: -1, name: pokedexName, pokemon: []);

    final result = converter.convert(pokedex);

    expect(result, {
      DatabaseColumnNames.id: -1,
      DatabaseColumnNames.name: pokedexName,
    });
  });

  test('handles zero ID gracefully', () {
    final pokedex = PokedexLocalModel(id: 0, name: pokedexName, pokemon: []);

    final result = converter.convert(pokedex);

    expect(result, {
      DatabaseColumnNames.id: 0,
      DatabaseColumnNames.name: pokedexName,
    });
  });
}
