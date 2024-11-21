import 'package:dartz/dartz.dart';
import 'package:domain/boundary/repository/pokemon_repository.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokemon_model.dart';
import 'package:repository/models/local/pokemon_local_model.dart';

import '../boundary/local/pokemon_local.dart';
import '../boundary/remote/pokemon_data.dart';
import '../converters/pokemon/pokemon_repository_converter.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonData pokemonData;
  final PokemonLocal pokemonLocal;
  final PokemonRepositoryConverter converter;

  PokemonRepositoryImpl(this.pokemonData, this.pokemonLocal, this.converter);

  @override
  Future<Either<Failure, PokemonModel>> getPokemon(int id) async =>
      (await pokemonLocal.get(id)).fold(
        (failure) => getPokemonFromData(id, null),
        (localPokemon) => isDetailed(localPokemon)
            ? Right(converter.convertToDomain(localPokemon))
            : getPokemonFromData(id, localPokemon),
      );

  bool isDetailed(PokemonLocalModel pokemon) =>
      pokemon.types != null || pokemon.frontSpriteUrl != null;

  Future<Either<Failure, PokemonModel>> getPokemonFromData(
          int id, PokemonLocalModel? undetailedPokemonModel) async =>
      (await pokemonData.get(id)).fold(
        (failure) => undetailedPokemonModel != null
            ? Right(converter.convertToDomain(undetailedPokemonModel))
            : Left(Failure("")),
        (dataPokemon) {
          var localModel = converter.convertToLocal(dataPokemon);
          pokemonLocal.store(localModel);
          return Right(converter.convertToDomain(localModel));
        },
      );
}
