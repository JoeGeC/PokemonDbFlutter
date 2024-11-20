import 'package:get_it/get_it.dart';
import 'package:presentation/pokedex/converters/pokedex_local_converter.dart';
import 'package:presentation/pokedex/converters/pokedex_local_converter_impl.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter_impl.dart';

final getIt = GetIt.instance;

setupPresentationInjections(){
  getIt.registerSingleton<PokemonPresentationConverter>(PokedexPokemonLocalConverterImpl());
  getIt.registerSingleton<PokedexPresentationConverter>(PokedexPresentationConverterImpl(getIt()));
}