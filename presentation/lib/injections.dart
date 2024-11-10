import 'package:get_it/get_it.dart';
import 'package:presentation/pokedex/converters/pokedex_local_converter.dart';
import 'package:presentation/pokedex/converters/pokedex_local_converter_impl.dart';
import 'package:presentation/pokemon/converters/pokemon_local_converter.dart';
import 'package:presentation/pokemon/converters/pokemon_local_converter_impl.dart';

final getIt = GetIt.instance;

setupPresentationInjections(){
  getIt.registerSingleton<PokemonLocalConverter>(PokedexPokemonLocalConverterImpl());
  getIt.registerSingleton<PokedexLocalConverter>(PokedexLocalConverterImpl(getIt()));
}