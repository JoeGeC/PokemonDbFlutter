import 'package:bloc_test/bloc_test.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/usecases/pokedex_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:presentation/common/bloc/base_state.dart';
import 'package:presentation/pokedex/bloc/pokedex/pokedex_bloc.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter.dart';

import '../../model_mocks.dart';
import 'pokedex_bloc_should.mocks.dart';

@GenerateMocks([PokedexUseCase, PokedexPresentationConverter])
void main() {
  late MockPokedexUseCase mockPokedexUseCase;
  late MockPokedexPresentationConverter mockConverter;
  late PokedexBloc pokedexBloc;

  setUp(() {
    mockPokedexUseCase = MockPokedexUseCase();
    mockConverter = MockPokedexPresentationConverter();
    pokedexBloc = PokedexBloc(mockPokedexUseCase, mockConverter);
  });

  tearDown(() {
    pokedexBloc.close();
  });

  group('get pokedex', () {
    test('be PokedexLoadingState on start', () {
      expect(pokedexBloc.state, isA<LoadingState>());
    });

    blocTest<PokedexBloc, BaseState>(
      'emit [PokedexLoadingState, PokedexSuccessState] when GetPokedexEvent is successful',
      build: () {
        when(mockPokedexUseCase.getPokedex(any))
            .thenAnswer((_) async => Right(pokedexModel1));
        when(mockConverter.convert(any)).thenReturn(pokedexPresentationModel1);
        return pokedexBloc;
      },
      act: (bloc) => bloc.add(GetPokedexEvent(1)),
      expect: () => [
        isA<LoadingState>(),
        PokedexSuccessState(pokedexPresentationModel1),
      ],
      verify: (_) {
        verify(mockPokedexUseCase.getPokedex(1)).called(1);
        verify(mockConverter.convert(any)).called(1);
      },
    );

    blocTest<PokedexBloc, BaseState>(
      'emit [PokedexLoadingState, PokedexErrorState] when GetPokedexEvent fails',
      build: () {
        when(mockPokedexUseCase.getPokedex(any))
            .thenAnswer((_) async => Left(Failure('Error')));
        return pokedexBloc;
      },
      act: (bloc) => bloc.add(GetPokedexEvent(1)),
      expect: () => [
        isA<LoadingState>(),
        ErrorState('Error'),
      ],
    );

    blocTest<PokedexBloc, BaseState>(
      're-add the last event when addLastEvent is called',
      build: () {
        when(mockPokedexUseCase.getPokedex(any))
            .thenAnswer((_) async => Right(pokedexModel1));
        when(mockConverter.convert(any)).thenReturn(pokedexPresentationModel1);
        return pokedexBloc;
      },
      act: (bloc) {
        bloc.add(GetPokedexEvent(1));
        bloc.addLastEvent();
      },
      expect: () => [
        isA<LoadingState>(),
        PokedexSuccessState(pokedexPresentationModel1),
        isA<LoadingState>(),
        PokedexSuccessState(pokedexPresentationModel1),
      ],
    );
  });
}
