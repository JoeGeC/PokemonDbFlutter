import 'package:domain/models/pokedex_model.dart';
import 'package:presentation/pokedex/converters/pokedex_local_converter.dart';
import 'package:presentation/pokedex/models/pokedex_local_model.dart';

class PokedexLocalConverterImpl implements PokedexLocalConverter {
  final PokemonLocalConverter pokemonConverter;

  @override
  PokedexLocalModel convert(PokedexModel pokedex) {
    return PokedexLocalModel(
        pokedex.id,
        convertName(pokedex.name),
        ,
    );
  }

  String convertName(String name) {

  }

}