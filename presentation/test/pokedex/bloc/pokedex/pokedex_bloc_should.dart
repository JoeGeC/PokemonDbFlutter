import 'package:bloc_test/bloc_test.dart';
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokedex_constants/pokedex_name.dart';
import 'package:domain/models/pokedex_constants/pokemon_region.dart';
import 'package:domain/models/pokedex_constants/pokemon_version.dart';
import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokemon_model.dart';
import 'package:domain/usecases/pokedex_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:dartz/dartz.dart';
import 'package:presentation/pokedex/bloc/pokedex/pokedex_bloc.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter.dart';
import 'package:presentation/pokedex/models/pokedex_pokemon_presentation_model.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';

import 'pokedex_bloc_should.mocks.dart';

@GenerateMocks([PokedexUseCase, PokedexPresentationConverter])
void main() {
  late MockPokedexUseCase mockPokedexUseCase;
  late MockPokedexPresentationConverter mockConverter;
  late PokedexBloc pokedexBloc;

  int pokedexId = 10;
  String pokedexRegion = "Kanto";
  String pokedexVersionAbbreviation = "RBY";
  int pokedexEntryNumber = 100;
  PokedexName pokedexName = PokedexName.kanto;
  int pokemonId = 1;
  String pokedexEntryNumberPresentation = "100";
  String pokemonNationalDexNumber = "0001";
  String pokemonName = "Example Pokemon";
  List<String> pokemonTypes = ["Grass"];
  Map<int, int> pokedexEntryNumbers = {pokedexId: pokedexEntryNumber};

  PokemonModel pokemonModel = PokemonModel(
    id: pokemonId,
    name: pokemonName,
    pokedexEntryNumbers: pokedexEntryNumbers,
  );
  PokedexPokemonPresentationModel pokemonPresentationModel =
      PokedexPokemonPresentationModel(
    id: pokemonId,
    nationalDexNumber: pokemonNationalDexNumber,
    pokedexEntryNumber: pokedexEntryNumberPresentation,
    name: pokemonName,
    types: pokemonTypes,
  );

  PokedexModel pokedexModel = PokedexModel(
    id: pokedexId,
    name: pokedexName,
    versions: [PokemonVersion.redBlueYellow],
    region: PokemonRegion.kanto,
    pokemon: [pokemonModel],
  );
  PokedexPresentationModel pokedexPresentationModel = PokedexPresentationModel(
    id: pokedexId,
    regionName: pokedexRegion,
    versionAbbreviation: pokedexVersionAbbreviation,
    displayNames: [pokedexRegion],
    pokemon: [pokemonPresentationModel],
  );

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
      expect(pokedexBloc.state, isA<PokedexLoadingState>());
    });

    blocTest<PokedexBloc, PokedexState>(
      'emit [PokedexLoadingState, PokedexSuccessState] when GetPokedexEvent is successful',
      build: () {
        when(mockPokedexUseCase.getPokedex(any))
            .thenAnswer((_) async => Right(pokedexModel));
        when(mockConverter.convert(any)).thenReturn(pokedexPresentationModel);
        return pokedexBloc;
      },
      act: (bloc) => bloc.add(GetPokedexEvent(1)),
      expect: () => [
        isA<PokedexLoadingState>(),
        PokedexSuccessState(pokedexPresentationModel),
      ],
      verify: (_) {
        verify(mockPokedexUseCase.getPokedex(1)).called(1);
        verify(mockConverter.convert(any)).called(1);
      },
    );

    blocTest<PokedexBloc, PokedexState>(
      'emit [PokedexLoadingState, PokedexErrorState] when GetPokedexEvent fails',
      build: () {
        when(mockPokedexUseCase.getPokedex(any))
            .thenAnswer((_) async => Left(Failure('Error')));
        return pokedexBloc;
      },
      act: (bloc) => bloc.add(GetPokedexEvent(1)),
      expect: () => [
        isA<PokedexLoadingState>(),
        PokedexErrorState('Error'),
      ],
    );

    blocTest<PokedexBloc, PokedexState>(
      're-add the last event when addLastEvent is called',
      build: () {
        when(mockPokedexUseCase.getPokedex(any))
            .thenAnswer((_) async => Right(pokedexModel));
        when(mockConverter.convert(any)).thenReturn(pokedexPresentationModel);
        return pokedexBloc;
      },
      act: (bloc) {
        bloc.add(GetPokedexEvent(1));
        bloc.addLastEvent();
      },
      expect: () => [
        isA<PokedexLoadingState>(),
        PokedexSuccessState(pokedexPresentationModel),
        isA<PokedexLoadingState>(),
        PokedexSuccessState(pokedexPresentationModel),
      ],
    );
  });
}
