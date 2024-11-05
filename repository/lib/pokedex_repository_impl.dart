import 'package:dartz/dartz.dart';
import 'package:domain/boundary/repository/pokedex_repository.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokemon.dart';
import 'boundary/remote/pokedex_api.dart';

class PokedexRepositoryImpl implements PokedexRepository{
  final PokedexApi pokedexApi;

  PokedexRepositoryImpl(this.pokedexApi);

  @override
  Future<Either<Failure, List<Pokemon>>> getPokedex(int id) async {
    pokedexApi.getPokedex(id);
    return Left(Failure(""));
  }
}