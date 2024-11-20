import 'package:get_it/get_it.dart';
import 'package:local/converters/pokedex_local_converter.dart';
import 'package:local/converters/pokemon_local_converter.dart';
import 'package:local/database_initializer.dart';
import 'package:local/pokedex/pokedex_local_impl.dart';
import 'package:repository/boundary/local/pokedex_local.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.instance;

setupLocalDependencies() async {
  getIt.registerSingleton<PokedexLocalConverter>(PokedexLocalConverter());
  getIt.registerSingleton<PokemonLocalConverter>(PokemonLocalConverter());
  getIt.registerSingleton<Database>(await DatabaseInitializer.instance.database);

  getIt.registerSingleton<PokedexLocal>(PokedexLocalImpl(getIt(), getIt(), getIt()));
}