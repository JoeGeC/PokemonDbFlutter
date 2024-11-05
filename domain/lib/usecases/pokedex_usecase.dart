import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import '../boundary/repository/pokedex_repository.dart';
import '../models/pokemon.dart';

class PokedexUseCase {
  final PokedexRepository repository;

  PokedexUseCase(this.repository);

  @override
  Future<Either<Failure, List<Pokemon>>> getPokedex(int id) async {
    final result = await repository.getPokedex(id);
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}