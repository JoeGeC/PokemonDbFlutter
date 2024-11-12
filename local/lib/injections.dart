import 'package:get_it/get_it.dart';
import 'package:local/pokedex/pokedex_local_impl.dart';
import 'package:repository/boundary/local/pokedex_local.dart';

final getIt = GetIt.instance;

setupLocalDependencies(){
  getIt.registerSingleton<PokedexLocal>(PokedexLocalImpl());
}