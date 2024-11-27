import 'package:dartz/dartz.dart';
import 'package:domain/boundary/repository/pokedexes_repository.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokedex_model.dart';

import '../boundary/local/pokedexes_local.dart';
import '../boundary/remote/pokedexes_data.dart';
import '../converters/pokedex/pokedex_repository_converter.dart';

class PokedexesRepositoryImpl implements PokedexesRepository {
  final PokedexesData pokedexesApi;
  final PokedexesLocal pokedexesLocal;
  final PokedexRepositoryConverter converter;

  PokedexesRepositoryImpl(this.pokedexesApi, this.pokedexesLocal, this.converter);

  @override
  Stream<Either<Failure, List<PokedexModel>>> getAllPokedexes() async* {
    final localResult = await pokedexesLocal.getAll();
    if(localResult.isRight()) {
      var localResultValue = localResult.getOrElse(() => []);
      yield Right(converter.convertListToDomain(localResultValue));
    }
    final dataResult = await pokedexesApi.getALl();
    if(dataResult.isLeft()){
      yield Left(Failure(""));
    } else {
      var dataResultValue = dataResult.getOrElse(() => []);
      var localModels = converter.convertListToLocal(dataResultValue);
      await pokedexesLocal.store(localModels);
      final localResult = await pokedexesLocal.getAll();
      if(localResult.isRight()) {
        var localResultValue = localResult.getOrElse(() => []);
        yield Right(converter.convertListToDomain(localResultValue));
      }
    }
  }

}
