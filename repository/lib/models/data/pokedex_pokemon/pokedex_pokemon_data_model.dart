import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pokedex_pokemon_data_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PokedexPokemonDataModel extends Equatable {
  final int? entryNumber;
  final String? name;
  final String? url;

  const PokedexPokemonDataModel(this.entryNumber, this.name, this.url);

  factory PokedexPokemonDataModel.fromJson(Map<String, dynamic> json) {
    return PokedexPokemonDataModel(
      json['entry_number'],
      json['pokemon_species']['name'],
      json['pokemon_species']['url'],
    );
  }

  toJson() => _$PokedexPokemonDataModelToJson(this);

  static List<PokedexPokemonDataModel> fromJsonList(List? json) {
    return json?.map((e) => PokedexPokemonDataModel.fromJson(e)).toList() ?? [];
  }

  @override
  List<Object?> get props => [entryNumber, name, url];
}
