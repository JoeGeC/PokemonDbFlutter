import 'package:domain/models/pokedex_model.dart';
import 'package:domain/usecases/pokedex_list_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';

import '../../pokedex/converters/pokedex_presentation_converter.dart';

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

  Stream<PokedexListState> _getPokedexListEvent(
      GetPokedexListEvent event, Emitter<PokedexListState> emitter) async* {
    yield PokedexListLoadingState();

    await for (var result in _pokedexListUseCase.getAllPokedexes()) {
      yield result.fold(
        (failure) => PokedexListErrorState(failure.errorMessage),
        (pokedexList) => PokedexListSuccessState(pokedexList
            .map((pokedex) => _pokedexConverter.convert(pokedex))
            .toList()),
      );
    }
  }
}
