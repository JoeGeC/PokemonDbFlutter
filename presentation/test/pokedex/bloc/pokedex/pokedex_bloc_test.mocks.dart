// Mocks generated by Mockito 5.4.4 from annotations
// in presentation/test/pokedex/bloc/pokedex/pokedex_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i2;
import 'package:domain/domain.dart' as _i4;
import 'package:domain/src/models/failure.dart' as _i6;
import 'package:domain/src/models/pokedex_model.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:presentation/src/pokedex/converters/pokedex_presentation_converter.dart'
    as _i8;
import 'package:presentation/src/pokedex/models/pokedex_group_presentation_model.dart'
    as _i9;
import 'package:presentation/src/pokedex/models/pokedex_presentation_model.dart'
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

class _FakePokedexPresentationModel_1 extends _i1.SmartFake
    implements _i3.PokedexPresentationModel {
  _FakePokedexPresentationModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PokedexUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokedexUseCase extends _i1.Mock implements _i4.PokedexUseCase {
  MockPokedexUseCase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i5.Future<_i2.Either<_i6.Failure, _i7.PokedexModel>> getPokedex(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #getPokedex,
          [id],
        ),
        returnValue:
            _i5.Future<_i2.Either<_i6.Failure, _i7.PokedexModel>>.value(
                _FakeEither_0<_i6.Failure, _i7.PokedexModel>(
          this,
          Invocation.method(
            #getPokedex,
            [id],
          ),
        )),
      ) as _i5.Future<_i2.Either<_i6.Failure, _i7.PokedexModel>>);
}

/// A class which mocks [PokedexPresentationConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokedexPresentationConverter extends _i1.Mock
    implements _i8.PokedexPresentationConverter {
  MockPokedexPresentationConverter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.PokedexPresentationModel convert(_i7.PokedexModel? pokedex) =>
      (super.noSuchMethod(
        Invocation.method(
          #convert,
          [pokedex],
        ),
        returnValue: _FakePokedexPresentationModel_1(
          this,
          Invocation.method(
            #convert,
            [pokedex],
          ),
        ),
      ) as _i3.PokedexPresentationModel);

  @override
  List<_i9.PokedexGroupPresentationModel> convertAndOrder(
          List<_i7.PokedexModel>? pokedex) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertAndOrder,
          [pokedex],
        ),
        returnValue: <_i9.PokedexGroupPresentationModel>[],
      ) as List<_i9.PokedexGroupPresentationModel>);
}
