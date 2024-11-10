import 'package:domain/models/pokemon_model.dart';
import 'package:presentation/common/utils/utils.dart';
import 'package:presentation/pokemon/converters/pokemon_local_converter.dart';
import '../../pokedex/models/pokemon_local_model.dart';

class PokemonLocalConverterImpl extends PokemonLocalConverter {
  @override
  List<PokemonLocalModel> convertList(List<PokemonModel> pokemonList) =>
      pokemonList.map((pokemon) => convert(pokemon)).toList();

  @override
  PokemonLocalModel convert(PokemonModel pokemon) {
    return PokemonLocalModel(
      id: pokemon.id,
      nationalDexNumber: convertNationalDexNumber(pokemon.id),
      pokedexEntryNumbers: convertEntryNumbers(pokemon.pokedexEntryNumbers),
      name: convertName(pokemon.name),
      imageUrl: pokemon.imageUrl,
      types: convertTypes(pokemon.types),
    );
  }

  String convertNationalDexNumber(int id) => id.toString().padLeft(4, '0');

  Map<String, String> convertEntryNumbers(
          Map<String, int>? pokedexEntryNumbers) =>
      pokedexEntryNumbers?.map((pokedex, entryNumber) =>
          MapEntry(pokedex, entryNumber.toString().padLeft(3, '0'))) ??
      {};

  String convertName(String name) => name.capitalise();

  List<String> convertTypes(List<String>? types) =>
      types?.map((type) => type.capitalise()).toList() ?? [];
}
