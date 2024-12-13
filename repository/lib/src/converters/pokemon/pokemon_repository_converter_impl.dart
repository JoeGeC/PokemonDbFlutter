import 'package:domain/domain.dart';
import 'package:repository/src/converters/BaseRepositoryConverter.dart';
import 'package:repository/src/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/src/models/data/pokemon/pokemon_data_model.dart';
import 'package:repository/src/models/exceptions/NullException.dart';
import 'package:repository/src/models/local/pokemon_local_model.dart';

import '../../models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';

class PokemonRepositoryConverterImpl extends BaseRepositoryConverter
    implements PokemonRepositoryConverter {
  final String hpName = "hp";
  final String attackName = "attack";
  final String defenseName = "defense";
  final String specialAttackName = "special-attack";
  final String specialDefenseName = "special-defense";
  final String speed = "speed";

  @override
  List<PokemonModel> convertListToDomain(
          List<PokemonLocalModel>? localPokemonList) =>
      localPokemonList?.map(convertToDomain).toList() ?? [];

  @override
  PokemonModel convertToDomain(PokemonLocalModel pokemon) => PokemonModel(
        id: pokemon.id,
        name: pokemon.name,
        pokedexEntryNumbers: pokemon.pokedexEntryNumbers,
        types: pokemon.types,
        spriteUrl: pokemon.frontSpriteUrl,
        artworkUrl: pokemon.artworkUrl,
        hp: pokemon.hp,
        attack: pokemon.attack,
        defense: pokemon.defense,
        specialAttack: pokemon.specialAttack,
        specialDefense: pokemon.specialDefense,
        speed: pokemon.speed,
        hpEvYield: pokemon.hpEvYield,
        attackEvYield: pokemon.attackEvYield,
        defenseEvYield: pokemon.defenseEvYield,
        specialAttackEvYield: pokemon.specialAttackEvYield,
        specialDefenseEvYield: pokemon.specialDefenseEvYield,
        speedEvYield: pokemon.speedEvYield,
      );

  @override
  PokemonLocalModel? convertToLocal(PokemonDataModel pokemon) {
    try {
      return PokemonLocalModel(
        id: getPokemonId(pokemon.id),
        name: getPokemonName(pokemon.name),
        types: pokemon.types,
        frontSpriteUrl: pokemon.frontSpriteUrl,
        artworkUrl: pokemon.artworkUrl,
        hp: pokemon.getBaseStat(hpName),
        attack: pokemon.getBaseStat(attackName),
        defense: pokemon.getBaseStat(defenseName),
        specialAttack: pokemon.getBaseStat(specialAttackName),
        specialDefense: pokemon.getBaseStat(specialDefenseName),
        speed: pokemon.getBaseStat(speed),
        hpEvYield: pokemon.getEffortValue(hpName),
        attackEvYield: pokemon.getEffortValue(attackName),
        defenseEvYield: pokemon.getEffortValue(defenseName),
        specialAttackEvYield: pokemon.getEffortValue(specialAttackName),
        specialDefenseEvYield: pokemon.getEffortValue(specialDefenseName),
        speedEvYield: pokemon.getEffortValue(speed),
      );
    } catch (e) {
      return null;
    }
  }

  int getPokemonId(int? id) => id ?? (throw NullException(NullType.id));

  @override
  List<PokemonLocalModel>? convertPokedexListToLocal(
      List<PokedexPokemonDataModel>? dataPokemonList, int pokedexId) {
    return dataPokemonList
        ?.map((pokemon) {
          try {
            return PokemonLocalModel(
                id: getIdFromUrl(pokemon.url),
                pokedexEntryNumbers:
                    getEntryNumberAsMap(pokemon.entryNumber, pokedexId),
                name: getPokemonName(pokemon.name));
          } catch (e) {
            return null;
          }
        })
        .whereType<PokemonLocalModel>()
        .toList();
  }

  Map<int, int> getEntryNumberAsMap(int? entryNumber, int pokedexId) =>
      {pokedexId: entryNumber ?? (throw NullException(NullType.entryNumber))};

  String getPokemonName(String? pokemonName) =>
      pokemonName ?? (throw NullException(NullType.name));
}
