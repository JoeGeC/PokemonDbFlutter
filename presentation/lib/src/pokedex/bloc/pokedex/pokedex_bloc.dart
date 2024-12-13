import 'package:domain/domain.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/bloc/base_state.dart';
import '../../converters/pokedex_presentation_converter.dart';
import '../../models/pokedex_presentation_model.dart';

part 'pokedex_event.dart';
part 'pokedex_state.dart';

class PokedexBloc extends Bloc<PokedexEvent, BaseState> {
  final PokedexUseCase _pokedexUseCase;
  final PokedexPresentationConverter _pokedexConverter;
  PokedexEvent? _lastEvent;

  PokedexBloc(
      PokedexUseCase pokedexUseCase, PokedexPresentationConverter pokedexConverter)
      : _pokedexUseCase = pokedexUseCase,
        _pokedexConverter = pokedexConverter,
        super(LoadingState()) {
    on<GetPokedexEvent>(_getPokedexEvent);
  }

  _getPokedexEvent(GetPokedexEvent event, Emitter<BaseState> emitter) async {
    if (event.isLoading) {
      emitter(LoadingState());
    }

    final result = await _pokedexUseCase.getPokedex(event.id);
    result.fold((failure) {
      emitter(ErrorState(failure.errorMessage));
    }, (pokedexModel) {
      var presentationPokedex = _pokedexConverter.convert(pokedexModel);
      emitter(PokedexSuccessState(presentationPokedex));
    });
  }

  @override
  void add(PokedexEvent event) {
    _lastEvent = event;
    super.add(event);
  }

  void addLastEvent() {
    if(_lastEvent == null) return;
    add(_lastEvent!);
  }
}
