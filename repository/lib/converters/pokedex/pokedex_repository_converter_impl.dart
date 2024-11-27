import 'package:domain/models/pokedex_model.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/models/exceptions/NullException.dart';
import 'package:repository/models/local/pokedex_local_model.dart';

class PokedexRepositoryConverterImpl implements PokedexRepositoryConverter {
  PokemonRepositoryConverter pokemonConverter;

  PokedexRepositoryConverterImpl(this.pokemonConverter);

  @override
  PokedexModel convertToDomain(
          PokedexLocalModel pokedexLocalModel) =>
      PokedexModel(
          id: pokedexLocalModel.id,
          name: pokedexLocalModel.name,
          pokemon:
              pokemonConverter.convertListToDomain(pokedexLocalModel.pokemon));

  @override
  PokedexLocalModel convertToLocal(PokedexDataModel pokedexDataModel) {
    _validateNotNull(pokedexDataModel);
    return PokedexLocalModel(
        id: pokedexDataModel.id!,
        name: pokedexDataModel.name!,
        pokemon: pokemonConverter.convertPokedexListToLocal(
            pokedexDataModel.pokemonEntries, pokedexDataModel.id!));
  }

  void _validateNotNull(PokedexDataModel pokedexDataModel) {
    if (pokedexDataModel.id == null) throw NullException(NullType.id);
    if (pokedexDataModel.name == null) throw NullException(NullType.name);
  }

  @override
  List<PokedexModel> convertListToDomain(
          List<PokedexLocalModel> pokedexLocalList) =>
      pokedexLocalList.map((pokedex) => convertToDomain(pokedex)).toList();

  @override
  List<PokedexLocalModel> convertListToLocal(
          List<PokedexDataModel> pokedexDataList) =>
      pokedexDataList.map((pokedex) => convertToLocal(pokedex)).toList();
}
