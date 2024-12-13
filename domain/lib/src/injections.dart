import 'package:domain/src/usecases/pokedex_usecase.dart';
import 'package:domain/src/usecases/pokedex_list_usecase.dart';
import 'package:domain/src/usecases/pokemon_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupDomainDependencies(){
  getIt.registerSingleton<PokedexListUseCase>(PokedexListUseCase(getIt()));
  getIt.registerSingleton<PokedexUseCase>(PokedexUseCase(getIt()));
  getIt.registerSingleton<PokemonUseCase>(PokemonUseCase(getIt()));
}