import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/usecases/usecase.dart';
import '../boundary/repository/pokedex_repository.dart';
import '../models/pokemon.dart';

class PokedexUseCase extends UseCase<List<Pokemon>>{
  final PokedexRepository repository;

  PokedexUseCase(this.repository);

  @override
  Future<Either<Failure, List<Pokemon>>> call() async {
    final result = await repository.getPokedex();
    return result.fold((l) {
      return Left(l);
    }, (r) async {
      return Right(r);
    });
  }
}