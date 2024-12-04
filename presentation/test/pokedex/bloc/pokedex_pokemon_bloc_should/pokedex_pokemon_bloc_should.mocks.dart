// Mocks generated by Mockito 5.4.4 from annotations
// in presentation/test/pokedex/bloc/pokedex_pokemon_bloc_should/pokedex_pokemon_bloc_should.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i2;
import 'package:domain/models/Failure.dart';
import 'package:domain/models/pokemon_model.dart' as _i6;
import 'package:domain/usecases/pokemon_usecase.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:presentation/pokedex/converters/pokedex_pokemon_presentation_converter.dart'
    as _i7;
import 'package:presentation/pokedex/models/pokedex_pokemon_presentation_model.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePokedexPokemonPresentationModel_1 extends _i1.SmartFake
    implements _i3.PokedexPokemonPresentationModel {
  _FakePokedexPokemonPresentationModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PokemonUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonUseCase extends _i1.Mock implements _i4.PokemonUseCase {
  MockPokemonUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<Failure, _i6.PokemonModel>> getPokemon(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPokemon,
          [id],
        ),
        returnValue: _i5.Future<_i2.Either<Failure, _i6.PokemonModel>>.value(
            _FakeEither_0<Failure, _i6.PokemonModel>(
          this,
          Invocation.method(
            #getPokemon,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<Failure, _i6.PokemonModel>>);
}

/// A class which mocks [PokedexPokemonPresentationConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokedexPokemonPresentationConverter extends _i1.Mock
    implements _i7.PokedexPokemonPresentationConverter {
  MockPokedexPokemonPresentationConverter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i3.PokedexPokemonPresentationModel> convertList(
    List<_i6.PokemonModel>? pokemonList,
    int? pokedexId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertList,
          [
            pokemonList,
            pokedexId,
          ],
        ),
        returnValue: <_i3.PokedexPokemonPresentationModel>[],
      ) as List<_i3.PokedexPokemonPresentationModel>);

  @override
  _i3.PokedexPokemonPresentationModel convert(
    _i6.PokemonModel? pokemon,
    int? pokedexId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #convert,
          [
            pokemon,
            pokedexId,
          ],
        ),
        returnValue: _FakePokedexPokemonPresentationModel_1(
          this,
          Invocation.method(
            #convert,
            [
              pokemon,
              pokedexId,
            ],
          ),
        ),
      ) as _i3.PokedexPokemonPresentationModel);
}
