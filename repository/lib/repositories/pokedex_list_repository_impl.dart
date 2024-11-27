import 'package:dartz/dartz.dart';
import 'package:domain/boundary/repository/pokedexes_repository.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokedex_model.dart';

import '../boundary/local/pokedex_local.dart';
import '../boundary/remote/pokedex_data.dart';
import '../converters/pokedex/pokedex_repository_converter.dart';
import '../models/data/pokedex/pokedex_data_model.dart';
import '../models/data_failure.dart';
import '../models/local/pokedex_local_model.dart';

class PokedexListRepositoryImpl implements PokedexListRepository {
  final PokedexData pokedexesApi;
  final PokedexLocal pokedexLocal;
  final PokedexRepositoryConverter converter;

  PokedexListRepositoryImpl(
      this.pokedexesApi, this.pokedexLocal, this.converter);

  @override
  Stream<Either<Failure, List<PokedexModel>>> getAllPokedexes() async* {
    final localResult = await pokedexLocal.getAll();
    if (localResult.isRight()) {
      yield* _yieldLocalSuccess(localResult);
    }
    final dataResult = await pokedexesApi.getALl();
    yield* _fetchData(localResult, dataResult);
  }

  Stream<Either<Failure, List<PokedexModel>>> _yieldLocalSuccess(
      Either<DataFailure, List<PokedexLocalModel>> localResult) async* {
    final localResultValue = localResult.getOrElse(() => []);
    yield Right(converter.convertListToDomain(localResultValue));
  }

  Stream<Either<Failure, List<PokedexModel>>> _fetchData(
      Either<DataFailure, List<PokedexLocalModel>> localResult,
      Either<DataFailure, List<PokedexDataModel>> dataResult) async* {
    if (dataResult.isLeft() && localResult.isLeft()) {
      yield Left(Failure());
    } else if (dataResult.isRight()) {
      await storeDataSuccess(dataResult);
      final freshLocalResult = await pokedexLocal.getAll();
      if (freshLocalResult.isRight()) {
        yield* _yieldLocalSuccess(freshLocalResult);
      }
    }
  }

  Future<void> storeDataSuccess(Either<DataFailure, List<PokedexDataModel>> dataResult) async {
    final dataResultValue = dataResult.getOrElse(() => []);
    final localModels = converter.convertListToLocal(dataResultValue);
    await pokedexLocal.storeList(localModels);
  }
}
