// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_pokemon_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokedexPokemonDataModel _$PokedexPokemonDataModelFromJson(
        Map<String, dynamic> json) =>
    PokedexPokemonDataModel(
      (json['entry_number'] as num?)?.toInt(),
      json['name'] as String?,
      json['url'] as String?,
    );

Map<String, dynamic> _$PokedexPokemonDataModelToJson(
        PokedexPokemonDataModel instance) =>
    <String, dynamic>{
      'entry_number': instance.entryNumber,
      'name': instance.name,
      'url': instance.url,
    };
