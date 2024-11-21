import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokemon_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokemonDataModel extends Equatable {
  final int? id;
  final String? name;
  final List<String>? types;
  final String? frontSpriteUrl;

  const PokemonDataModel(this.id, this.name, this.types, this.frontSpriteUrl);

  factory PokemonDataModel.fromJson(Map<String, dynamic> json) {
    return PokemonDataModel(
      json['id'],
      json['name'],
      (json['types'] as List<dynamic>)
          .map((type) => type['type']['name'] as String)
          .toList(),
      json['sprites']['front_default']
    );
  }

  toJson() => _$PokemonDataModelToJson(this);

  static List<PokemonDataModel> fromJsonList(List? json) {
    return json?.map((e) => PokemonDataModel.fromJson(e)).toList() ?? [];
  }

  @override
  List<Object?> get props => [id, name, types, frontSpriteUrl];
}
