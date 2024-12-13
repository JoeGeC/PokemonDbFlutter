import 'package:domain/domain.dart';
import 'package:get_it/get_it.dart';
import 'package:repository/src/converters/pokedex/pokedex_repository_converter_impl.dart';
import 'package:repository/src/repositories/pokedex_list_repository_impl.dart';
import 'package:repository/src/repositories/pokedex_repository_impl.dart';
import 'package:repository/src/repositories/pokemon_repository_impl.dart';

import 'package:repository/src/converters/pokedex/pokedex_repository_converter.dart';
import 'package:repository/src/converters/pokemon/pokemon_repository_converter_impl.dart';
import 'package:repository/src/converters/pokemon/pokemon_repository_converter.dart';

final getIt = GetIt.instance;

setupRepositoryDependencies(){
  getIt.registerSingleton<PokemonRepositoryConverter>(PokemonRepositoryConverterImpl());
  getIt.registerSingleton<PokedexRepositoryConverter>(PokedexRepositoryConverterImpl(getIt()));

  getIt.registerSingleton<PokedexRepository>(PokedexRepositoryImpl(getIt(), getIt(), getIt()));
  getIt.registerSingleton<PokedexListRepository>(PokedexListRepositoryImpl(getIt(), getIt(), getIt()));
  getIt.registerSingleton<PokemonRepository>(PokemonRepositoryImpl(getIt(), getIt(), getIt()));
}