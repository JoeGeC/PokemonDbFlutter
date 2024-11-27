import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import '../pokedex_list/pokedex_list_item_data_model.dart';

part 'pokedex_list_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokedexListDataModel extends Equatable {
  final List<PokedexListItemDataModel>? results;

  const PokedexListDataModel(this.results);

  factory PokedexListDataModel.fromJson(json) =>
      _$PokedexListDataModelFromJson(json);

  toJson() => _$PokedexListDataModelToJson(this);

  @override
  List<Object?> get props => [results];
}
