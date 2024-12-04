import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/usecases/pokemon_usecase.dart';

import '../../../common/bloc/base_state.dart';
import '../../converters/pokedex_pokemon_presentation_converter.dart';
import '../../models/pokedex_pokemon_presentation_model.dart';

part 'pokedex_pokemon_event.dart';

part 'pokedex_pokemon_state.dart';

class PokedexPokemonBloc extends Bloc<PokedexPokemonEvent, BaseState> {
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
      GetPokedexPokemonEvent event, Emitter<BaseState> emit) async {
    var pokemonId = event.pokemon.id;
    emit(LoadingState());
    if (event.pokemon.hasPokedexDetails) {
      emit(PokedexPokemonSuccessState(event.pokemon));
      return;
    }
    await _getPokemonFromRepo(pokemonId, emit, event);
  }

  Future<void> _getPokemonFromRepo(int pokemonId, Emitter<BaseState> emit,
      GetPokedexPokemonEvent event) async {
    final result = await _pokemonUseCase.getPokemon(pokemonId);
    result.fold((failure) {
      emit(ErrorState(failure.errorMessage));
    }, (pokemonModel) {
      var presentationPokemon = _pokemonConverter.convertPokedexPokemon(
          pokemonModel, event.pokedexId);
      emit(PokedexPokemonSuccessState(presentationPokemon));
    });
  }
}
