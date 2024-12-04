import 'package:get_it/get_it.dart';
import 'package:presentation/pokedex/converters/pokedex_pokemon_presentation_converter.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter_impl.dart';
import 'package:presentation/pokedex/converters/pokedex_pokemon_presentation_converter_impl.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter_impl.dart';

final getIt = GetIt.instance;

setupPresentationInjections(){
  getIt.registerSingleton<PokemonPresentationConverter>(PokemonPresentationConverterImpl());
  getIt.registerSingleton<PokedexPokemonPresentationConverter>(PokedexPokemonPresentationConverterImpl());
  getIt.registerSingleton<PokedexPresentationConverter>(PokedexPresentationConverterImpl(getIt()));
}