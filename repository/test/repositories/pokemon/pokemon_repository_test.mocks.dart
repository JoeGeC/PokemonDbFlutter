// Mocks generated by Mockito 5.4.4 from annotations
// in repository/test/repositories/pokemon/pokemon_repository_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i2;
import 'package:domain/domain.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:repository/src/boundary/local/pokemon_local.dart' as _i8;
import 'package:repository/src/boundary/remote/pokemon_data.dart' as _i4;
import 'package:repository/src/converters/pokemon/pokemon_repository_converter.dart'
    as _i10;
import 'package:repository/src/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart'
    as _i11;
import 'package:repository/src/models/data/pokemon/pokemon_data_model.dart' as _i7;
import 'package:repository/src/models/data_failure.dart' as _i6;
import 'package:repository/src/models/local/pokemon_local_model.dart' as _i9;

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

class _FakePokemonModel_1 extends _i1.SmartFake implements _i3.PokemonModel {
  _FakePokemonModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PokemonData].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonData extends _i1.Mock implements _i4.PokemonData {
  MockPokemonData() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.DataFailure, _i7.PokemonDataModel>> get(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [id],
        ),
        returnValue:
            _i5.Future<_i2.Either<_i6.DataFailure, _i7.PokemonDataModel>>.value(
                _FakeEither_0<_i6.DataFailure, _i7.PokemonDataModel>(
          this,
          Invocation.method(
            #get,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.DataFailure, _i7.PokemonDataModel>>);
}

/// A class which mocks [PokemonLocal].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonLocal extends _i1.Mock implements _i8.PokemonLocal {
  MockPokemonLocal() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<dynamic> store(_i9.PokemonLocalModel? model) =>
      (super.noSuchMethod(
        Invocation.method(
          #store,
          [model],
        ),
        returnValue: _i5.Future<dynamic>.value(),
      ) as _i5.Future<dynamic>);

  @override
  _i5.Future<_i2.Either<_i6.DataFailure, _i9.PokemonLocalModel>> get(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [id],
        ),
        returnValue: _i5
            .Future<_i2.Either<_i6.DataFailure, _i9.PokemonLocalModel>>.value(
            _FakeEither_0<_i6.DataFailure, _i9.PokemonLocalModel>(
          this,
          Invocation.method(
            #get,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.DataFailure, _i9.PokemonLocalModel>>);
}

/// A class which mocks [PokemonRepositoryConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonRepositoryConverter extends _i1.Mock
    implements _i10.PokemonRepositoryConverter {
  MockPokemonRepositoryConverter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.PokemonModel convertToDomain(_i9.PokemonLocalModel? pokemon) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertToDomain,
          [pokemon],
        ),
        returnValue: _FakePokemonModel_1(
          this,
          Invocation.method(
            #convertToDomain,
            [pokemon],
          ),
        ),
      ) as _i3.PokemonModel);

  @override
  _i9.PokemonLocalModel? convertToLocal(_i7.PokemonDataModel? pokemon) =>
      (super.noSuchMethod(Invocation.method(
        #convertToLocal,
        [pokemon],
      )) as _i9.PokemonLocalModel?);

  @override
  List<_i3.PokemonModel> convertListToDomain(
          List<_i9.PokemonLocalModel>? pokemon) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertListToDomain,
          [pokemon],
        ),
        returnValue: <_i3.PokemonModel>[],
      ) as List<_i3.PokemonModel>);

  @override
  List<_i9.PokemonLocalModel>? convertPokedexListToLocal(
    List<_i11.PokedexPokemonDataModel>? pokemon,
    int? pokedexId,
  ) =>
      (super.noSuchMethod(Invocation.method(
        #convertPokedexListToLocal,
        [
          pokemon,
          pokedexId,
        ],
      )) as List<_i9.PokemonLocalModel>?);
}