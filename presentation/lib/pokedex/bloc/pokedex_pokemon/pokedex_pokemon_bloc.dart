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

  PokedexPokemonBloc(PokemonUseCase pokedexPokemonUseCase,
      PokedexPokemonPresentationConverter pokedexPokemonConverter)
      : _pokemonUseCase = pokedexPokemonUseCase,
        _pokemonConverter = pokedexPokemonConverter,
        super(PokedexPokemonInitialState()) {
    on<GetPokedexPokemonEvent>(_getPokedexPokemonEvent);
  }

  _getPokedexPokemonEvent(
      GetPokedexPokemonEvent event, Emitter<PokedexPokemonState> emit) async {
    emit(PokedexPokemonLoadingState(pokemonId: event.pokemonId));

    final result = await _pokemonUseCase.getPokemon(event.pokemonId);
    result.fold((failure) {
      emit(PokedexPokemonErrorState(event.pokemonId, failure.errorMessage));
    }, (pokemonModel) {
      var localPokemon =
          _pokemonConverter.convert(pokemonModel, event.pokedexId);
      emit(PokedexPokemonSuccessState(localPokemon));
    });
  }
}
