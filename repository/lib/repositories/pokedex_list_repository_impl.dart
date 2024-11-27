import 'package:dartz/dartz.dart';
import 'package:domain/boundary/repository/pokedexes_repository.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokedex_model.dart';

import '../boundary/local/pokedex_local.dart';
import '../boundary/remote/pokedex_list_data.dart';
import '../converters/pokedex/pokedex_repository_converter.dart';
import '../models/data/pokedex_list/pokedex_list_data_model.dart';
import '../models/data_failure.dart';
import '../models/local/pokedex_local_model.dart';

class PokedexListRepositoryImpl implements PokedexListRepository {
  final PokedexListData pokedexListApi;
  final PokedexLocal pokedexLocal;
  final PokedexRepositoryConverter converter;

  PokedexListRepositoryImpl(
      this.pokedexListApi, this.pokedexLocal, this.converter);

  @override
  Stream<Either<Failure, List<PokedexModel>>> getAllPokedexes() async* {
    final localResult = await pokedexLocal.getAll();
    if (localResult.isRight()) {
      yield* _yieldLocalSuccess(localResult);
    }
    final dataResult = await pokedexListApi.getAll();
    yield* _fetchData(localResult, dataResult);
  }

  Stream<Either<Failure, List<PokedexModel>>> _yieldLocalSuccess(
      Either<DataFailure, List<PokedexLocalModel>> localResult) async* {
    final localResultValue = localResult.getOrElse(() => []);
    yield Right(converter.convertListToDomain(localResultValue));
  }

  Stream<Either<Failure, List<PokedexModel>>> _fetchData(
      Either<DataFailure, List<PokedexLocalModel>> localResult,
      Either<DataFailure, PokedexListDataModel> dataResult) async* {
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

  Future<void> storeDataSuccess(
      Either<DataFailure, PokedexListDataModel> dataResult) async {
    final dataResultValue =
        dataResult.getOrElse(() => PokedexListDataModel([]));
    final localModels = converter.convertListToLocal(dataResultValue);
    await pokedexLocal.storeList(localModels);
  }
}
