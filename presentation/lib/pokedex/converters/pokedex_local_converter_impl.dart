import 'package:domain/models/pokedex_model.dart';
import 'package:presentation/pokedex/converters/pokedex_local_converter.dart';
import 'package:presentation/pokedex/models/pokedex_local_model.dart';

import '../../pokemon/converters/pokemon_local_converter.dart';

class PokedexLocalConverterImpl implements PokedexLocalConverter {
  late PokemonLocalConverter pokemonConverter;

  PokedexLocalConverterImpl(this.pokemonConverter);

  @override
  PokedexLocalModel convert(PokedexModel pokedex) {
    return PokedexLocalModel(
        id: pokedex.id,
        name: convertName(pokedex.name),
        pokemon: pokemonConverter.convertList(pokedex.pokemon),
    );
  }

  String convertName(String name) => switch(name){
      "johto-original" => "Johto Original Pokedex",
      String() => "Pokedex",
    };

}