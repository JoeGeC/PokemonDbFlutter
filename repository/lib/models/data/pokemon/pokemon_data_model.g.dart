// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDataModel _$PokemonDataModelFromJson(Map<String, dynamic> json) =>
    PokemonDataModel(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['front_sprite_url'] as String?,
    );

Map<String, dynamic> _$PokemonDataModelToJson(PokemonDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'types': instance.types,
      'front_sprite_url': instance.frontSpriteUrl,
    };
