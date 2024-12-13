import 'package:data/api/api_service.dart';
import 'package:data/data/pokedex_data_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:repository/repository.dart';

import 'data/pokedex_list_data_impl.dart';
import 'data/pokemon_data_impl.dart';

final getIt = GetIt.instance;

setupDataDependencies() {
  ApiService.initDio();

  getIt.registerSingleton<PokedexData>(PokedexDataImpl(ApiService.dio));
  getIt.registerSingleton<PokedexListData>(PokedexListDataImpl(ApiService.dio));
  getIt.registerSingleton<PokemonData>(PokemonDataImpl(ApiService.dio));
}
