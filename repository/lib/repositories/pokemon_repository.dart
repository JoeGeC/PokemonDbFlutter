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
  Future<Either<Failure, PokemonModel>> getPokemon(int id) async {
    var localResult = await pokemonLocal.get(id);
    return localResult.fold(
      (l) => Left(Failure("")),
      (r) => isDetailed(r)
          ? Right(converter.convertToDomain(r))
          : getPokemonFromData(id),
    );
  }

  bool isDetailed(PokemonLocalModel pokemon) =>
      pokemon.types != null || pokemon.frontSpriteUrl != null;

  Future<Either<Failure, PokemonModel>> getPokemonFromData(int id) async {
    var dataResult = await pokemonData.get(id);
    return dataResult.fold(
      (l) => Left(Failure("")),
      (r) {
        var localModel = converter.convertToLocal(r);
        pokemonLocal.store(localModel);
        return Right(converter.convertToDomain(localModel));
      });
  }
}
