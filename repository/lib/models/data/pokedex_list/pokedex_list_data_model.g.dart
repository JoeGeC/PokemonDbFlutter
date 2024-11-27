// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_list_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokedexListDataModel _$PokedexListDataModelFromJson(
        Map<String, dynamic> json) =>
    PokedexListDataModel(
      (json['results'] as List<dynamic>?)
          ?.map(PokedexListItemDataModel.fromJson)
          .toList(),
    );

Map<String, dynamic> _$PokedexListDataModelToJson(
        PokedexListDataModel instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
