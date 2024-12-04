import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../stat/pokemon_stat_data_model.dart';

part 'pokemon_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokemonDataModel extends Equatable {
  final int? id;
  final String? name;
  final List<String>? types;
  final String? frontSpriteUrl;
  final List<PokemonStatDataModel> stats;

  const PokemonDataModel({
    required this.id,
    required this.name,
    required this.types,
    required this.frontSpriteUrl,
    required this.stats,
  });

  factory PokemonDataModel.fromJson(Map<String, dynamic> json) {
    return PokemonDataModel(
      id: json['id'],
      name: json['species']['name'],
      types: (json['types'] as List<dynamic>)
          .map((type) => type['type']['name'] as String)
          .toList(),
      frontSpriteUrl: json['sprites']['front_default'],
      stats: (json['stats'] as List<dynamic>)
          .map((stat) =>
              PokemonStatDataModel.fromJson(stat as Map<String, dynamic>))
          .toList(),
    );
  }

  toJson() => _$PokemonDataModelToJson(this);

  static List<PokemonDataModel> fromJsonList(List? json) {
    return json?.map((e) => PokemonDataModel.fromJson(e)).toList() ?? [];
  }

  @override
  List<Object?> get props => [id, name, types, frontSpriteUrl, stats];

  PokemonStatDataModel getStat(String statName) =>
      stats.where((stat) => stat.name == statName).first;
}
