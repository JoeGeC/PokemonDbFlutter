import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokedex_list_item_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokedexListItemDataModel extends Equatable {
  final String name;
  final String url;

  const PokedexListItemDataModel(this.name, this.url);

  factory PokedexListItemDataModel.fromJson(json) =>
      _$PokedexListItemDataModelFromJson(json);

  toJson() => _$PokedexListItemDataModelToJson(this);

  @override
  List<Object?> get props => [name, url];
}
