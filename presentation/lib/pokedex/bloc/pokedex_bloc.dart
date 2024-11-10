import 'package:bloc/bloc.dart';
import 'package:domain/usecases/pokedex_usecase.dart';

import '../converters/pokedex_local_converter.dart';
import '../models/pokedex_local_model.dart';

part 'pokedex_event.dart';

part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final PokedexUseCase _pokedexUseCase;
  final PokedexLocalConverter _pokedexConverter;

  PokedexBloc(
      PokedexUseCase pokedexUseCase, PokedexLocalConverter pokedexConverter)
      : _pokedexUseCase = pokedexUseCase,
        _pokedexConverter = pokedexConverter,
        super(PokedexLoadingState()) {
    on<GetPokedexEvent>(_getPokedexEvent);
  }

  _getPokedexEvent(GetPokedexEvent event, Emitter<PokedexState> emitter) async {
    if (event.isLoading) {
      emitter(PokedexLoadingState());
    }

    final result = await _pokedexUseCase.getPokedex(3);
    result.fold((failure) {
      emitter(PokedexErrorState(failure.errorMessage));
    }, (pokedexModel) {
      var localPokedex = _pokedexConverter.convert(pokedexModel);
      emitter(PokedexSuccessState(localPokedex));
    });
  }
}
