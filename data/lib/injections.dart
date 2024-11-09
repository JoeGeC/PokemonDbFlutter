import 'package:data/data/pokedex_data_impl.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

setupDataDependencies() {
  getIt.registerSingleton<PokedexDataImpl>(getIt());
}
