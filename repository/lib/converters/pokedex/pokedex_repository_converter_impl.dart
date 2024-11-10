import 'package:domain/models/pokedex_model.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/models/exceptions/NullException.dart';
import 'package:repository/models/local/pokedex_local.dart';

class PokedexRepositoryConverterImpl implements PokedexRepositoryConverter {
  PokemonRepositoryConverter pokemonConverter;

  PokedexRepositoryConverterImpl(this.pokemonConverter);

  @override
  PokedexModel convertToDomain(PokedexLocalModel pokedexLocalModel) =>
      PokedexModel(
          id: pokedexLocalModel.id,
          name: pokedexLocalModel.name,
          pokemon: pokemonConverter.convertToDomain(pokedexLocalModel.pokemon));

  @override
  PokedexLocalModel convertToLocal(PokedexDataModel pokedexDataModel) {
    _validateNotNull(pokedexDataModel);
    return PokedexLocalModel(
        pokedexDataModel.id!,
        pokedexDataModel.name!,
        pokemonConverter.convertToLocal(
            pokedexDataModel.pokemonEntries!, pokedexDataModel.name!));
  }

  void _validateNotNull(PokedexDataModel pokedexDataModel) {
    if (pokedexDataModel.id == null) throw NullException(NullType.id);
    if (pokedexDataModel.name == null) throw NullException(NullType.name);
    if (pokedexDataModel.pokemonEntries == null) {
      throw NullException(NullType.pokemonEntries);
    }
  }
}
