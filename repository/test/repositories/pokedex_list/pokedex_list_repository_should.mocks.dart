// Mocks generated by Mockito 5.4.4 from annotations
// in repository/test/repositories/pokedex_list/pokedex_list_repository_should.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:dartz/dartz.dart' as _i2;
import 'package:domain/models/pokedex_model.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:repository/boundary/local/pokedex_local.dart' as _i9;
import 'package:repository/boundary/remote/pokedex_list_data.dart' as _i5;
import 'package:repository/converters/pokedex/pokedex_repository_converter.dart'
    as _i10;
import 'package:repository/models/data/pokedex/pokedex_data_model.dart' as _i11;
import 'package:repository/models/data/pokedex_list/pokedex_list_data_model.dart'
    as _i8;
import 'package:repository/models/data_failure.dart' as _i7;
import 'package:repository/models/local/pokedex_local_model.dart' as _i4;

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

class _FakePokedexModel_1 extends _i1.SmartFake implements _i3.PokedexModel {
  _FakePokedexModel_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakePokedexLocalModel_2 extends _i1.SmartFake
    implements _i4.PokedexLocalModel {
  _FakePokedexLocalModel_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PokedexListData].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokedexListData extends _i1.Mock implements _i5.PokedexListData {
  MockPokedexListData() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<_i2.Either<_i7.DataFailure, _i8.PokedexListDataModel>> getAll() =>
      (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: _i6.Future<
                _i2.Either<_i7.DataFailure, _i8.PokedexListDataModel>>.value(
            _FakeEither_0<_i7.DataFailure, _i8.PokedexListDataModel>(
          this,
          Invocation.method(
            #getAll,
            [],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.DataFailure, _i8.PokedexListDataModel>>);
}

/// A class which mocks [PokedexLocal].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokedexLocal extends _i1.Mock implements _i9.PokedexLocal {
  MockPokedexLocal() {
    _i1.throwOnMissingStub(this);
  }

  @override
  void store(_i4.PokedexLocalModel? model) => super.noSuchMethod(
        Invocation.method(
          #store,
          [model],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<void> storeList(List<_i4.PokedexLocalModel>? models) =>
      (super.noSuchMethod(
        Invocation.method(
          #storeList,
          [models],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  _i6.Future<_i2.Either<_i7.DataFailure, _i4.PokedexLocalModel>> get(int? id) =>
      (super.noSuchMethod(
        Invocation.method(
          #get,
          [id],
        ),
        returnValue: _i6
            .Future<_i2.Either<_i7.DataFailure, _i4.PokedexLocalModel>>.value(
            _FakeEither_0<_i7.DataFailure, _i4.PokedexLocalModel>(
          this,
          Invocation.method(
            #get,
            [id],
          ),
        )),
      ) as _i6.Future<_i2.Either<_i7.DataFailure, _i4.PokedexLocalModel>>);

  @override
  _i6.Future<_i2.Either<_i7.DataFailure, List<_i4.PokedexLocalModel>>>
      getAll() => (super.noSuchMethod(
            Invocation.method(
              #getAll,
              [],
            ),
            returnValue: _i6.Future<
                    _i2.Either<_i7.DataFailure,
                        List<_i4.PokedexLocalModel>>>.value(
                _FakeEither_0<_i7.DataFailure, List<_i4.PokedexLocalModel>>(
              this,
              Invocation.method(
                #getAll,
                [],
              ),
            )),
          ) as _i6.Future<
              _i2.Either<_i7.DataFailure, List<_i4.PokedexLocalModel>>>);
}

/// A class which mocks [PokedexRepositoryConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokedexRepositoryConverter extends _i1.Mock
    implements _i10.PokedexRepositoryConverter {
  MockPokedexRepositoryConverter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.PokedexModel convertToDomain(_i4.PokedexLocalModel? pokedexLocal) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertToDomain,
          [pokedexLocal],
        ),
        returnValue: _FakePokedexModel_1(
          this,
          Invocation.method(
            #convertToDomain,
            [pokedexLocal],
          ),
        ),
      ) as _i3.PokedexModel);

  @override
  List<_i3.PokedexModel> convertListToDomain(
          List<_i4.PokedexLocalModel>? pokedexLocalList) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertListToDomain,
          [pokedexLocalList],
        ),
        returnValue: <_i3.PokedexModel>[],
      ) as List<_i3.PokedexModel>);

  @override
  _i4.PokedexLocalModel convertToLocal(_i11.PokedexDataModel? pokedexData) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertToLocal,
          [pokedexData],
        ),
        returnValue: _FakePokedexLocalModel_2(
          this,
          Invocation.method(
            #convertToLocal,
            [pokedexData],
          ),
        ),
      ) as _i4.PokedexLocalModel);

  @override
  List<_i4.PokedexLocalModel> convertListToLocal(
          List<_i11.PokedexDataModel>? pokedexDataList) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertListToLocal,
          [pokedexDataList],
        ),
        returnValue: <_i4.PokedexLocalModel>[],
      ) as List<_i4.PokedexLocalModel>);
}
