import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:repository/models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';

part 'pokedex_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokedexDataModel extends Equatable {
  final int? id;
  final String? name;
  final List<PokedexPokemonDataModel>? pokemonEntries;

  const PokedexDataModel(this.id, this.name, this.pokemonEntries);

  factory PokedexDataModel.fromJson(json) => _$PokedexDataModelFromJson(json);

  toJson() => _$PokedexDataModelToJson(this);

  @override
  List<Object?> get props => [id, name, pokemonEntries];
}
