import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:domain/usecases/pokemon_usecase.dart';

import '../../../common/bloc/base_state.dart';
import '../converters/pokemon_presentation_converter.dart';
import '../models/pokemon_presentation_model.dart';

part 'pokemon_event.dart';

part 'pokemon_state.dart';

class PokemonBloc
    extends Bloc<PokemonEvent, BaseState> {
  final PokemonUseCase _pokemonUseCase;
  final PokemonPresentationConverter _pokemonConverter;

  PokemonBloc(PokemonUseCase pokemonUseCase,
      PokemonPresentationConverter pokemonConverter)
      : _pokemonUseCase = pokemonUseCase,
        _pokemonConverter = pokemonConverter,
        super(LoadingState()) {
    on<GetPokemonEvent>(_getPokemonEvent);
  }

  _getPokemonEvent(GetPokemonEvent event, Emitter<BaseState> emit) async {
    var result = await _pokemonUseCase.getPokemon(event.pokemonId);
    result.fold(
        (failure) => emit(ErrorState(failure.errorMessage)),
        (pokemon) {
          var presentationPokemon = _pokemonConverter.convert(pokemon);
          emit(PokemonSuccessState(presentationPokemon));
        },
    );
  }
}
