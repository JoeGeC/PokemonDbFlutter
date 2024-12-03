import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/usecases/pokemon_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/pokedex/bloc/pokedex_pokemon/pokedex_pokemon_bloc.dart';
import 'package:presentation/pokemon/converters/pokemon_presentation_converter.dart';

import '../../model_mocks.dart';
import 'pokedex_pokemon_bloc_should.mocks.dart';

@GenerateMocks([PokemonUseCase, PokedexPokemonPresentationConverter])
void main() {
  late MockPokemonUseCase mockPokemonUseCase;
  late MockPokedexPokemonPresentationConverter mockConverter;
  late PokedexPokemonBloc bloc;
  const errorMessage = 'Error fetching Pokémon details';

  setUp(() {
    mockPokemonUseCase = MockPokemonUseCase();
    mockConverter = MockPokedexPokemonPresentationConverter();
    bloc = PokedexPokemonBloc(mockPokemonUseCase, mockConverter);
  });

  tearDown(() {
    bloc.close();
  });

  group('get pokedex pokemon', () {
    test('Initial state is PokedexPokemonInitialState', () {
      expect(bloc.state, isA<PokedexPokemonInitialState>());
    });

    blocTest<PokedexPokemonBloc, PokedexPokemonState>(
      'emit [PokedexPokemonLoadingState, PokedexPokemonSuccessState] when Pokémon details are already present',
      build: () => bloc,
      act: (bloc) => bloc.add(GetPokedexPokemonEvent(
        pokedexPokemonPresentationModel,
        pokedexId1,
      )),
      expect: () => [
        isA<PokedexPokemonLoadingState>(),
        PokedexPokemonSuccessState(pokedexPokemonPresentationModel),
      ],
    );

    blocTest<PokedexPokemonBloc, PokedexPokemonState>(
      'emit [PokedexPokemonLoadingState, PokedexPokemonErrorState] when fetching Pokémon details fails',
      build: () {
        when(mockPokemonUseCase.getPokemon(pokemonId)).thenAnswer(
              (_) async => Left(Failure(errorMessage)),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(GetPokedexPokemonEvent(
        pokedexPokemonPresentationModelUndetailed,
        pokedexId1,
      )),
      expect: () => [
        isA<PokedexPokemonLoadingState>(),
        PokedexPokemonErrorState(pokemonId, errorMessage),
      ],
      verify: (_) {
        verify(mockPokemonUseCase.getPokemon(pokemonId)).called(1);
      },
    );

    blocTest<PokedexPokemonBloc, PokedexPokemonState>(
      'emit [PokedexPokemonLoadingState, PokedexPokemonSuccessState] when fetching Pokémon details succeeds',
      build: () {
        when(mockPokemonUseCase.getPokemon(pokemonId)).thenAnswer(
              (_) async => Right(pokemonModel),
        );
        when(mockConverter.convert(pokemonModel, pokedexId1))
            .thenReturn(pokedexPokemonPresentationModel);
        return bloc;
      },
      act: (bloc) => bloc.add(GetPokedexPokemonEvent(
        pokedexPokemonPresentationModelUndetailed,
        pokedexId1,
      )),
      expect: () => [
        isA<PokedexPokemonLoadingState>(),
        PokedexPokemonSuccessState(pokedexPokemonPresentationModel),
      ],
      verify: (_) {
        verify(mockPokemonUseCase.getPokemon(pokemonId)).called(1);
        verify(mockConverter.convert(pokemonModel, pokedexId1)).called(1);
      },
    );
  });
}
