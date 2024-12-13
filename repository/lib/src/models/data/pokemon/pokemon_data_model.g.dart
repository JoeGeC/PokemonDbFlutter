// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonDataModel _$PokemonDataModelFromJson(Map<String, dynamic> json) =>
    PokemonDataModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList(),
      frontSpriteUrl: json['front_sprite_url'] as String?,
      artworkUrl: json['artwork_url'] as String?,
      stats: (json['stats'] as List<dynamic>)
          .map((e) => PokemonStatDataModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokemonDataModelToJson(PokemonDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'types': instance.types,
      'front_sprite_url': instance.frontSpriteUrl,
      'artwork_url': instance.artworkUrl,
      'stats': instance.stats,
    };
