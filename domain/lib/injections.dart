import 'package:domain/usecases/pokedex_usecase.dart';
import 'package:domain/usecases/pokemon_usecase.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupDomainDependencies(){
  getIt.registerSingleton<PokedexUseCase>(PokedexUseCase(getIt()));
  getIt.registerSingleton<PokemonUseCase>(PokemonUseCase(getIt()));
}