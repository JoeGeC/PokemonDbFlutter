import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/usecases/pokedex_list_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/common/bloc/base_state.dart';
import 'package:presentation/pokedex/bloc/pokedex_list/pokedex_list_bloc.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter.dart';

import '../../../model_mocks.dart';
import 'pokedex_list_bloc_should.mocks.dart';

@GenerateMocks([PokedexListUseCase, PokedexPresentationConverter])
void main() {
  late MockPokedexListUseCase mockPokedexListUseCase;
  late MockPokedexPresentationConverter mockConverter;
  late PokedexListBloc bloc;
  var errorMessage = 'Error fetching data';

  setUp(() {
    mockPokedexListUseCase = MockPokedexListUseCase();
    mockConverter = MockPokedexPresentationConverter();
    bloc = PokedexListBloc(mockPokedexListUseCase, mockConverter);
  });

  tearDown(() {
    bloc.close();
  });

  group('get pokedex list', () {
    test('Initial state is PokedexListLoadingState', () {
      expect(bloc.state, isA<LoadingState>());
    });

    blocTest<PokedexListBloc, BaseState>(
      'emit [PokedexListLoadingState, PokedexListSuccessState] when GetPokedexListEvent succeeds',
      build: () {
        when(mockPokedexListUseCase.getAllPokedexes()).thenAnswer(
          (_) => Stream.value(Right(pokedexModelList2)),
        );
        when(mockConverter.convertAndOrder(pokedexModelList2))
            .thenReturn(pokedexGroupList2);

        return bloc;
      },
      act: (bloc) => bloc.add(GetPokedexListEvent()),
      expect: () => [
        isA<LoadingState>(),
        PokedexListSuccessState(pokedexGroupList2),
      ],
      verify: (_) {
        verify(mockPokedexListUseCase.getAllPokedexes()).called(1);
        verify(mockConverter.convertAndOrder(any)).called(1);
      },
    );

    blocTest<PokedexListBloc, BaseState>(
      'emit [PokedexListLoadingState, PokedexListErrorState] when GetPokedexListEvent fails',
      build: () {
        when(mockPokedexListUseCase.getAllPokedexes()).thenAnswer(
          (_) => Stream.value(Left(Failure(errorMessage))),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetPokedexListEvent()),
      expect: () {
        return [
          isA<BaseState>(),
          ErrorState(errorMessage),
        ];
      },
      verify: (_) {
        verify(mockPokedexListUseCase.getAllPokedexes()).called(1);
      },
    );

    blocTest<PokedexListBloc, BaseState>(
      'Handles multiple results from getAllPokedexes stream',
      build: () {
        when(mockPokedexListUseCase.getAllPokedexes()).thenAnswer(
          (_) => Stream.fromIterable([
            Right(pokedexModelList1),
            Right(pokedexModelList2),
          ]),
        );
        when(mockConverter.convertAndOrder(pokedexModelList1))
            .thenReturn(pokedexGroupList1);
        when(mockConverter.convertAndOrder(pokedexModelList2))
            .thenReturn(pokedexGroupList2);
        return bloc;
      },
      act: (bloc) => bloc.add(GetPokedexListEvent()),
      expect: () => [
        isA<LoadingState>(),
        PokedexListSuccessState(pokedexGroupList1),
        PokedexListSuccessState(pokedexGroupList2),
      ],
    );
  });
}
