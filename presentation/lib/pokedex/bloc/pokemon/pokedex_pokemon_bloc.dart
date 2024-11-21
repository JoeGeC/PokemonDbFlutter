import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/usecases/pokemon_usecase.dart';

import '../../../pokemon/converters/pokemon_presentation_converter.dart';
import '../../models/pokedex_pokemon_presentation_model.dart';

part 'pokedex_pokemon_event.dart';

part 'pokedex_pokemon_state.dart';

class PokedexPokemonBloc
    extends Bloc<PokedexPokemonEvent, PokedexPokemonState> {
  final PokemonUseCase _pokemonUseCase;
  final PokedexPokemonPresentationConverter _pokemonConverter;
  final int _pokemonId;
  final String _pokedexName;

  PokedexPokemonBloc(
      PokemonUseCase pokedexPokemonUseCase,
      PokedexPokemonPresentationConverter pokedexPokemonConverter,
      int pokemonId,
      String pokedexName)
      : _pokemonUseCase = pokedexPokemonUseCase,
        _pokemonConverter = pokedexPokemonConverter,
        _pokemonId = pokemonId,
        _pokedexName = pokedexName,
        super(PokedexPokemonLoadingState()) {
    on<GetPokedexPokemonEvent>(_getPokedexPokemonEvent);
  }

  _getPokedexPokemonEvent(GetPokedexPokemonEvent event,
      Emitter<PokedexPokemonState> emitter) async {
    if (event.isLoading) {
      emitter(PokedexPokemonLoadingState());
    }

    final result = await _pokemonUseCase.getPokemon(_pokemonId);
    result.fold((failure) {
      emitter(PokedexPokemonErrorState(failure.errorMessage));
    }, (pokemonModel) {
      var localPokemon = _pokemonConverter.convert(pokemonModel, _pokedexName);
      emitter(PokedexPokemonSuccessState(localPokemon));
    });
  }
}
