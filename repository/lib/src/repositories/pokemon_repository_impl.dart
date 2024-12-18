import 'package:dartz/dartz.dart';
import 'package:domain/domain.dart';
import 'package:repository/src/models/local/pokemon_local_model.dart';

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
            : Left(Failure(failure.errorMessage ?? "")),
        (dataPokemon) async {
          var localModel = converter.convertToLocal(dataPokemon);
          if (localModel == null) return Left(Failure("Conversion failed"));
          await pokemonLocal.store(localModel);
          var detailedPokemon = await pokemonLocal.get(id);
          var result = detailedPokemon.fold(
              (failure) => undetailedPokemonModel,
              (success) => success,
          );
          if(result == null) return Left(Failure("Null from local"));
          return Right(converter.convertToDomain(result));
        },
      );
}
