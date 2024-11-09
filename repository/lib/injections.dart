import 'package:get_it/get_it.dart';
import 'package:repository/repositories/pokedex_repository_impl.dart';

final getIt = GetIt.instance;

setupRepositoryDependencies(){
  getIt.registerSingleton<PokedexRepositoryImpl>(getIt());
}