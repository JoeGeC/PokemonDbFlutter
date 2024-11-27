// Mocks generated by Mockito 5.4.4 from annotations
// in repository/test/converters/pokedex_repository_converter_should.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:domain/models/pokemon_model.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;
import 'package:repository/converters/pokemon/pokemon_repository_converter.dart'
    as _i3;
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart'
    as _i6;
import 'package:repository/models/data/pokemon/pokemon_data_model.dart' as _i5;
import 'package:repository/models/local/pokemon_local_model.dart' as _i4;

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

class _FakePokemonModel_0 extends _i1.SmartFake implements _i2.PokemonModel {
  _FakePokemonModel_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [PokemonRepositoryConverter].
///
/// See the documentation for Mockito's code generation for more information.
class MockPokemonRepositoryConverter extends _i1.Mock
    implements _i3.PokemonRepositoryConverter {
  MockPokemonRepositoryConverter() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.PokemonModel convertToDomain(_i4.PokemonLocalModel? pokemon) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertToDomain,
          [pokemon],
        ),
        returnValue: _FakePokemonModel_0(
          this,
          Invocation.method(
            #convertToDomain,
            [pokemon],
          ),
        ),
      ) as _i2.PokemonModel);

  @override
  _i4.PokemonLocalModel? convertToLocal(_i5.PokemonDataModel? pokemon) =>
      (super.noSuchMethod(Invocation.method(
        #convertToLocal,
        [pokemon],
      )) as _i4.PokemonLocalModel?);

  @override
  List<_i2.PokemonModel> convertListToDomain(
          List<_i4.PokemonLocalModel>? pokemon) =>
      (super.noSuchMethod(
        Invocation.method(
          #convertListToDomain,
          [pokemon],
        ),
        returnValue: <_i2.PokemonModel>[],
      ) as List<_i2.PokemonModel>);

  @override
  List<_i4.PokemonLocalModel>? convertPokedexListToLocal(
    List<_i6.PokedexPokemonDataModel>? pokemon,
    int? pokedexId,
  ) =>
      (super.noSuchMethod(Invocation.method(
        #convertPokedexListToLocal,
        [
          pokemon,
          pokedexId,
        ],
      )) as List<_i4.PokemonLocalModel>?);
}
