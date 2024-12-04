import 'package:domain/models/pokemon_model.dart';
import 'package:presentation/pokedex/converters/pokedex_pokemon_presentation_converter.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter_impl.dart';
import '../models/pokedex_pokemon_presentation_model.dart';

class PokedexPokemonPresentationConverterImpl
    extends PokemonPresentationConverterImpl
    implements PokedexPokemonPresentationConverter {
  @override
  List<PokedexPokemonPresentationModel> convertList(
          List<PokemonModel> pokemonList, int pokedexId) =>
      pokemonList.map((pokemon) => convertPokedexPokemon(pokemon, pokedexId)).toList();

  @override
  PokedexPokemonPresentationModel convertPokedexPokemon(PokemonModel pokemon, int pokedexId) {
    return PokedexPokemonPresentationModel(
      id: pokemon.id,
      nationalDexNumber: convertNationalDexNumber(pokemon.id),
      pokedexEntryNumber:
          convertEntryNumber(pokemon.pokedexEntryNumbers, pokedexId),
      name: convertName(pokemon.name),
      imageUrl: pokemon.imageUrl,
      types: convertTypes(pokemon.types),
    );
  }

  String convertEntryNumber(
          Map<int, int>? pokedexEntryNumbers, int pokedexId) =>
      pokedexEntryNumbers?[pokedexId]?.toString().padLeft(3, '0') ?? "";

}
