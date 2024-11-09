import 'package:data/api/api_service.dart';
import 'package:data/data/pokedex_data_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:repository/boundary/remote/pokedex_data.dart';

final getIt = GetIt.instance;

setupDataDependencies() {
  ApiService.initDio();
  getIt.registerSingleton<PokedexData>(PokedexDataImpl(ApiService.dio));
}
