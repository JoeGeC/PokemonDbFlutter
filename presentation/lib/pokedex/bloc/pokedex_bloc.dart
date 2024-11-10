import 'package:bloc/bloc.dart';
import 'package:domain/models/pokedex_model.dart';
import 'package:domain/usecases/pokedex_usecase.dart';

part 'pokedex_event.dart';

part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, PokedexState> {
  final PokedexUseCase _pokedexUseCase;

  PokedexBloc(PokedexUseCase pokedexUseCase, PokedexLocalConverter pokedexLocalConverter)
      : _pokedexUseCase = pokedexUseCase,
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
      var localPokedexModel =
      emitter(PokedexSuccessState(pokedexModel));
    });
  }
}
