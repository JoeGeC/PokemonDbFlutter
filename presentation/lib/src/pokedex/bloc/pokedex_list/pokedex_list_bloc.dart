import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/base_state.dart';
import '../../converters/pokedex_presentation_converter.dart';
import '../../models/pokedex_group_presentation_model.dart';

part 'pokedex_list_event.dart';

part 'pokedex_list_state.dart';

class PokedexListBloc extends Bloc<PokedexListEvent, BaseState> {
  final PokedexListUseCase _pokedexListUseCase;
  final PokedexPresentationConverter _pokedexConverter;

  PokedexListBloc(PokedexListUseCase pokedexListUseCase,
      PokedexPresentationConverter pokedexConverter)
      : _pokedexListUseCase = pokedexListUseCase,
        _pokedexConverter = pokedexConverter,
        super(LoadingState()) {
    on<GetPokedexListEvent>(_getPokedexListEvent);
  }

  void _getPokedexListEvent(
      GetPokedexListEvent event, Emitter<BaseState> emit) async {
    BaseState lastState = LoadingState();
    emit(lastState);
    await for (final result in _pokedexListUseCase.getAllPokedexes()) {
      result.fold(
        (failure) {
          lastState = ErrorState(failure.errorMessage);
          return emit(lastState);
        },
        (pokedexList) {
          var orderedResult = _pokedexConverter.convertAndOrder(pokedexList);
          lastState = PokedexListSuccessState(orderedResult);
          return emit(lastState);
        },
      );
    }
    emit(CompletedState(lastState));
  }
}
