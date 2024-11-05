import 'package:dartz/dartz.dart';
import 'package:domain/boundary/repository/pokedex_repository.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokedex.dart';
import '../boundary/remote/pokedex_api.dart';
import '../converters/pokedex/pokedex_repository_converter.dart';

class PokedexRepositoryImpl implements PokedexRepository{
  final PokedexApi pokedexApi;
  final PokedexRepositoryConverter converter;

  PokedexRepositoryImpl(this.pokedexApi, this.converter);

  @override
  Future<Either<Failure, Pokedex>> getPokedex(int id) async {
    var result = await pokedexApi.getPokedex(id);
    return result.fold(
      (l) => Left(Failure(l.errorMessage)),
      (r) => Right(converter.convert(r)),
    );
  }
}