import 'package:get_it/get_it.dart';
import 'package:presentation/pokedex/bloc/pokedex_pokemon/pokedex_pokemon_bloc.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter_impl.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter_impl.dart';

final getIt = GetIt.instance;

setupPresentationInjections(){
  getIt.registerSingleton<PokedexPokemonPresentationConverter>(PokedexPokemonPresentationConverterImpl());
  getIt.registerSingleton<PokedexPresentationConverter>(PokedexPresentationConverterImpl(getIt()));

  getIt.registerSingleton<PokedexPokemonBloc>(PokedexPokemonBloc(getIt(), getIt()));
}