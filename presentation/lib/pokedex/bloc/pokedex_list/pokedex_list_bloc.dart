import 'package:domain/models/pokedex_model.dart';
import 'package:domain/usecases/pokedex_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';

import '../../converters/pokedex_presentation_converter.dart';

part 'pokedex_list_event.dart';

part 'pokedex_list_state.dart';

class PokedexListBloc extends Bloc<PokedexListEvent, PokedexListState> {
  final PokedexListUseCase _pokedexListUseCase;
  final PokedexPresentationConverter _pokedexConverter;

  PokedexListBloc(PokedexListUseCase pokedexListUseCase,
      PokedexPresentationConverter pokedexConverter)
      : _pokedexListUseCase = pokedexListUseCase,
        _pokedexConverter = pokedexConverter,
        super(PokedexListInitialState()) {
    on<GetPokedexListEvent>(_getPokedexListEvent);
  }

  void _getPokedexListEvent(
      GetPokedexListEvent event, Emitter<PokedexListState> emit) async {
    emit(PokedexListLoadingState());

    await for (final result in _pokedexListUseCase.getAllPokedexes()) {
        result.fold(
          (failure) => emit(PokedexListErrorState(failure.errorMessage)),
          (pokedexList) => emit(PokedexListSuccessState(
            pokedexList
                .map((pokedex) => _pokedexConverter.convert(pokedex))
                .toList(),
          )),
        );
      }
  }
}
