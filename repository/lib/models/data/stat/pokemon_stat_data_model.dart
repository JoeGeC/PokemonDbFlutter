import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokemonStatDataModel extends Equatable {
  final int? baseStat;
  final int? effort;
  final String name;
  final String url;

  const PokemonStatDataModel(
    this.baseStat,
    this.effort,
    this.name,
    this.url,
  );

  factory PokemonStatDataModel.fromJson(Map<String, dynamic> json) =>
      PokemonStatDataModel(
        json['base_stat'],
        json['effort'],
        json['stat']['name'],
        json['stat']['url'],
      );

  @override
  List<Object?> get props => [baseStat, effort, name, url];
}
