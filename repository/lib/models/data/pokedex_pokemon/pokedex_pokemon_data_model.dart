import 'package:json_annotation/json_annotation.dart';

import '../data_model.dart';

part 'pokedex_pokemon_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokedexPokemonDataModel extends DataModel {
  int? entryNumber;
  String? name;
  String? url;

  PokedexPokemonDataModel(this.entryNumber, this.name, this.url);

  factory PokedexPokemonDataModel.fromJson(json) => _$PokedexPokemonDataModelFromJson(json);

  toJson() => _$PokedexPokemonDataModelToJson(this);

  static List<PokedexPokemonDataModel> fromJsonList(List? json) {
    return json?.map((e) => PokedexPokemonDataModel.fromJson(e)).toList() ?? [];
  }

  @override
  bool operator ==(Object other) {
    if (other is PokedexPokemonDataModel) return other.url == url;
    return super == other;
  }

  @override
  int get hashCode => url.hashCode;

}