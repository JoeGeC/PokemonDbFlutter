import 'package:domain/domain.dart';
import 'package:presentation/presentation.dart';
import 'package:presentation/src/pokedex/converters/pokedex_pokemon_presentation_converter.dart';
import 'package:presentation/src/pokemon/converters/pokemon_presentation_converter_impl.dart';
import '../models/pokedex_pokemon_presentation_model.dart';

class PokedexPokemonPresentationConverterImpl
    extends PokemonPresentationConverterImpl
    implements PokedexPokemonPresentationConverter {

  PokedexPokemonPresentationConverterImpl(super.localizations);

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
      imageUrl: pokemon.spriteUrl,
      types: convertTypes(pokemon.types),
    );
  }

  String convertEntryNumber(
          Map<int, int>? pokedexEntryNumbers, int pokedexId) =>
      pokedexEntryNumbers?[pokedexId]?.toString().padLeft(3, '0') ?? "";

}
