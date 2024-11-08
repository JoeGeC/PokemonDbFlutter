import 'package:dartz/dartz.dart';
import 'package:domain/boundary/repository/pokedex_repository.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokedex_model.dart';
import 'package:repository/boundary/local/pokedex_local.dart';
import '../boundary/remote/pokedex_data.dart';
import '../converters/pokedex/pokedex_repository_converter.dart';

class PokedexRepositoryImpl implements PokedexRepository{
  final PokedexData pokedexApi;
  final PokedexRepositoryConverter converter;
  final PokedexLocal pokedexLocal;

  PokedexRepositoryImpl(this.pokedexApi, this.pokedexLocal, this.converter);

  @override
  Future<Either<Failure, PokedexModel>> getPokedex(int id) async {
    var localResult = await pokedexLocal.get(id);
    if(localResult.isLeft()) return getPokedexFromApi(id);
    return localResult.fold(
        (l) => Left(Failure(l.errorMessage)),
        (r) => Right(converter.convertToDomain(r))
    );
  }

  Future<Either<Failure, PokedexModel>> getPokedexFromApi(int id) async {
    var result = await pokedexApi.get(id);
    return result.fold(
          (l) => Left(Failure(l.errorMessage)),
          (r) {
            var localModel = converter.convertToLocal(r);
            pokedexLocal.store(localModel);
            return Right(converter.convertToDomain(localModel));
          },
    );
  }
}