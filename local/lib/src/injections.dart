import 'package:get_it/get_it.dart';
import 'package:local/src/converters/pokedex_local_converter.dart';
import 'package:local/src/converters/pokemon_local_converter.dart';
import 'package:local/src/database_initializer.dart';
import 'package:local/src/pokedex/pokedex_local_impl.dart';
import 'package:local/src/pokemon/pokemon_local_impl.dart';
import 'package:repository/repository.dart';
import 'package:sqflite/sqflite.dart';

final getIt = GetIt.instance;

setupLocalDependencies(Database? database) async {
  getIt.registerSingleton<PokedexLocalConverter>(PokedexLocalConverter());
  getIt.registerSingleton<PokemonLocalConverter>(PokemonLocalConverter());

  database = database ??
      getIt.registerSingleton<Database>(
          await DatabaseInitializer.instance.database);

  getIt.registerSingleton<PokedexLocal>(PokedexLocalImpl(database, getIt(), getIt()));
  getIt.registerSingleton<PokemonLocal>(PokemonLocalImpl(database, getIt()));
}
