import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/usecases/pokemon_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/common/bloc/base_state.dart';
import 'package:presentation/pokemon/bloc/pokemon_bloc.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter.dart';

import '../../model_mocks.dart';
import 'pokemon_bloc_should.mocks.dart';

@GenerateMocks([PokemonUseCase, PokemonPresentationConverter])
void main() {
  late MockPokemonUseCase mockPokemonUseCase;
  late MockPokemonPresentationConverter mockConverter;
  late PokemonBloc pokemonBloc;

  setUp(() {
    mockPokemonUseCase = MockPokemonUseCase();
    mockConverter = MockPokemonPresentationConverter();
    pokemonBloc = PokemonBloc(mockPokemonUseCase, mockConverter);
  });

  tearDown(() {
    pokemonBloc.close();
  });

  group('get pokemon', () {
    test('be LoadingState on start', () {
      expect(pokemonBloc.state, isA<LoadingState>());
    });

    blocTest<PokemonBloc, BaseState>(
      'emit [PokemonSuccessState] when GetPokemonEvent is successful',
      build: () {
        when(mockPokemonUseCase.getPokemon(any))
            .thenAnswer((_) async => Right(pokemonModel));
        when(mockConverter.convert(any)).thenReturn(pokemonPresentationModel);
        return pokemonBloc;
      },
      act: (bloc) => bloc.add(GetPokemonEvent(1)),
      expect: () => [
        LoadingState(),
        PokemonSuccessState(pokemonPresentationModel),
      ],
      verify: (_) {
        verify(mockPokemonUseCase.getPokemon(1)).called(1);
        verify(mockConverter.convert(any)).called(1);
      },
    );

    blocTest<PokemonBloc, BaseState>(
      'emit [ErrorState] when GetPokemonEvent is failure',
      build: () {
        when(mockPokemonUseCase.getPokemon(any))
            .thenAnswer((_) async => Left(Failure(errorMessage)));
        return pokemonBloc;
      },
      act: (bloc) => bloc.add(GetPokemonEvent(1)),
      expect: () => [
        LoadingState(),
        ErrorState(errorMessage),
      ],
      verify: (_) {
        verify(mockPokemonUseCase.getPokemon(1)).called(1);
      },
    );
  });
}
