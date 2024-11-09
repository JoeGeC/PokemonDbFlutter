// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokedexDataModel _$PokedexDataModelFromJson(Map<String, dynamic> json) =>
    PokedexDataModel(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      (json['pokemon_entries'] as List<dynamic>?)
          ?.map((e) =>
              PokedexPokemonDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokedexDataModelToJson(PokedexDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'pokemon_entries': instance.pokemonEntries,
    };
