import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/usecases/pokemon_usecase.dart';

import '../../../common/bloc/base_state.dart';
import '../converters/pokemon_presentation_converter.dart';
import '../models/pokemon_presentation_model.dart';

part 'pokemon_event.dart';

part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, BaseState> {
  final PokemonUseCase _pokemonUseCase;
  final PokemonPresentationConverter _pokemonConverter;

  PokemonBloc(PokemonUseCase pokemonUseCase,
      PokemonPresentationConverter pokemonConverter)
      : _pokemonUseCase = pokemonUseCase,
        _pokemonConverter = pokemonConverter,
        super(LoadingState()) {
    on<GetPokemonEvent>(_getPokemonEvent);
    on<GetExistingPokemonEvent>(_getExistingPokemonEvent);
  }

  _getPokemonEvent(GetPokemonEvent event, Emitter<BaseState> emit) async {
    emit(LoadingState());
    await getPokemon(event.pokemonId, emit);
  }

  Future<void> getPokemon(int pokemonId, Emitter<BaseState> emit) async {
    var result = await _pokemonUseCase.getPokemon(pokemonId);
    result.fold(
      (failure) => emit(ErrorState(failure.errorMessage)),
      (pokemon) {
        var presentationPokemon = _pokemonConverter.convert(pokemon);
        emit(PokemonSuccessState(presentationPokemon));
      },
    );
  }

  _getExistingPokemonEvent(
      GetExistingPokemonEvent event, Emitter<BaseState> emit) async {
    emit(ExistingPokemonLoadingState(event.pokemon));
    await getPokemon(event.pokemon.id, emit);
  }

  Future<void> onRefresh(int pokemonId) async {
    if(state is PokemonSuccessState) {
      add(GetExistingPokemonEvent((state as PokemonSuccessState).pokemon));
    } else {
      add(GetPokemonEvent(pokemonId));
    }
  }
}
