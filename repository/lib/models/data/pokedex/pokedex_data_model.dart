import 'package:json_annotation/json_annotation.dart';
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';

import '../data_model.dart';

part 'pokedex_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokedexDataModel extends DataModel {
  int? id;
  String? name;
  List<PokedexPokemonDataModel>? pokemonEntries;

  PokedexDataModel(this.id, this.name, this.pokemonEntries);

  factory PokedexDataModel.fromJson(json) => _$PokedexDataModelFromJson(json);

  toJson() => _$PokedexDataModelToJson(this);

  @override
  bool operator ==(Object other) {
    if (other is PokedexDataModel) return other.id == id;
    return super == other;
  }

}