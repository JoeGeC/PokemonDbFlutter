import 'package:domain/models/pokemon_model.dart';
import 'package:presentation/common/utils/utils.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter.dart';
import '../../pokedex/models/pokedex_pokemon_presentation_model.dart';

class PokedexPokemonPresentationConverterImpl extends PokedexPokemonPresentationConverter {
  @override
  List<PokedexPokemonPresentationModel> convertList(
          List<PokemonModel> pokemonList, String pokedexName) =>
      pokemonList.map((pokemon) => convert(pokemon, pokedexName)).toList();

  @override
  PokedexPokemonPresentationModel convert(PokemonModel pokemon, String pokedexName) {
    return PokedexPokemonPresentationModel(
      id: pokemon.id,
      nationalDexNumber: convertNationalDexNumber(pokemon.id),
      pokedexEntryNumber:
          convertEntryNumber(pokemon.pokedexEntryNumbers, pokedexName),
      name: convertName(pokemon.name),
      imageUrl: pokemon.imageUrl,
      types: convertTypes(pokemon.types),
    );
  }

  String convertNationalDexNumber(int id) => id.toString().padLeft(4, '0');

  String convertEntryNumber(
          Map<String, int>? pokedexEntryNumbers, String pokedexName) =>
      pokedexEntryNumbers?[pokedexName]?.toString().padLeft(3, '0') ?? "";

  String convertName(String name) => name.capitalise();

  List<String> convertTypes(List<String>? types) =>
      types?.map((type) => type.capitalise()).toList() ?? [];
}
