import 'package:domain/models/pokemon_model.dart';
import 'package:presentation/common/utils/extensions.dart';
import 'package:presentation/pokedex/converters/pokedex_pokemon_presentation_converter.dart';
import '../models/pokedex_pokemon_presentation_model.dart';

class PokedexPokemonPresentationConverterImpl implements PokedexPokemonPresentationConverter {
  @override
  List<PokedexPokemonPresentationModel> convertList(
          List<PokemonModel> pokemonList, int pokedexId) =>
      pokemonList.map((pokemon) => convert(pokemon, pokedexId)).toList();

  @override
  PokedexPokemonPresentationModel convert(PokemonModel pokemon, int pokedexId) {
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

  String convertNationalDexNumber(int id) => id.toString().padLeft(4, '0');

  String convertEntryNumber(
          Map<int, int>? pokedexEntryNumbers, int pokedexId) =>
      pokedexEntryNumbers?[pokedexId]?.toString().padLeft(3, '0') ?? "";

  String convertName(String name) => name.capitalise();

  List<String> convertTypes(List<String>? types) =>
      types?.map((type) => type.capitalise()).toList() ?? [];
}
