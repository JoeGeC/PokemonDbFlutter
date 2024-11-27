import 'package:domain/boundary/repository/pokedex_repository.dart';
import 'package:domain/boundary/repository/pokemon_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter_impl.dart';
import 'package:repository/repositories/pokedex_repository_impl.dart';
import 'package:repository/repositories/pokemon_repository_impl.dart';

import 'converters/pokedex/pokedex_repository_converter.dart';
import 'converters/pokemon/pokemon_repository_converter_impl.dart';
import 'converters/pokemon/pokemon_repository_converter.dart';

final getIt = GetIt.instance;

setupRepositoryDependencies(){
  getIt.registerSingleton<PokemonRepositoryConverter>(PokemonRepositoryConverterImpl());
  getIt.registerSingleton<PokedexRepositoryConverter>(PokedexRepositoryConverterImpl(getIt()));

  getIt.registerSingleton<PokedexRepository>(PokedexRepositoryImpl(getIt(), getIt(), getIt()));
  getIt.registerSingleton<PokemonRepository>(PokemonRepositoryImpl(getIt(), getIt(), getIt()));
}