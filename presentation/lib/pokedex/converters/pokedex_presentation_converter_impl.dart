import 'package:domain/models/pokedex_model.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';

import '../../pokemon/converters/pokemon_presentation_converter.dart';

class PokedexPresentationConverterImpl implements PokedexPresentationConverter {
  late PokedexPokemonPresentationConverter pokemonConverter;

  PokedexPresentationConverterImpl(this.pokemonConverter);

  @override
  PokedexPresentationModel convert(PokedexModel pokedex) {
    return PokedexPresentationModel(
        id: pokedex.id,
        name: convertName(pokedex.name),
        pokemon: pokemonConverter.convertList(pokedex.pokemon, pokedex.id),
    );
  }

  String convertName(String name) => switch(name){
      "original-johto" => "Original Johto",
      String() => name,
    };

}