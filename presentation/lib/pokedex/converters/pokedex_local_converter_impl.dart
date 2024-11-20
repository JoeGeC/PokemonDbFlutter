import 'package:domain/models/pokedex_model.dart';
import 'package:presentation/pokedex/converters/pokedex_local_converter.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';

import '../../pokemon/converters/pokemon_presentation_converter.dart';

class PokedexPresentationConverterImpl implements PokedexPresentationConverter {
  late PokemonPresentationConverter pokemonConverter;

  PokedexPresentationConverterImpl(this.pokemonConverter);

  @override
  PokedexPresentationModel convert(PokedexModel pokedex) {
    return PokedexPresentationModel(
        id: pokedex.id,
        name: convertName(pokedex.name),
        pokemon: pokemonConverter.convertList(pokedex.pokemon, pokedex.name),
    );
  }

  String convertName(String name) => switch(name){
      "original-johto" => "Original Johto",
      String() => "",
    };

}