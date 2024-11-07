import 'package:domain/models/pokedex_model.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/models/data/pokedex_data.dart';
import 'package:repository/models/local/pokedex_local.dart';

class PokedexRepositoryConverterImpl implements PokedexRepositoryConverter {
  PokemonRepositoryConverter pokemonConverter;

  PokedexRepositoryConverterImpl(this.pokemonConverter);

  @override
  PokedexModel convertToDomain(PokedexLocalModel pokedexLocalModel) =>
      PokedexModel(pokedexLocalModel.id, pokedexLocalModel.name,
          pokemonConverter.convertToDomain(pokedexLocalModel.pokemon));

  @override
  PokedexLocalModel convertToLocal(PokedexDataModel pokedexDataModel) =>
      PokedexLocalModel(pokedexDataModel.id, pokedexDataModel.name,
          pokemonConverter.convertToLocal(pokedexDataModel.pokemon));
}
