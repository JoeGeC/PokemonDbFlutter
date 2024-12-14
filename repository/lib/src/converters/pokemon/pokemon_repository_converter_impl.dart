import 'package:domain/domain.dart';
import 'package:repository/src/converters/BaseRepositoryConverter.dart';
import 'package:repository/src/converters/pokemon/pokemon_constants.dart';
import 'package:repository/src/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/src/models/data/pokemon/pokemon_data_model.dart';
import 'package:repository/src/models/exceptions/NullException.dart';
import 'package:repository/src/models/local/pokemon_local_model.dart';

import '../../models/data/pokedex_pokemon/pokedex_pokemon_data_model.dart';

class PokemonRepositoryConverterImpl extends BaseRepositoryConverter
    implements PokemonRepositoryConverter {

  @override
  List<PokemonModel> convertListToDomain(
          List<PokemonLocalModel>? localPokemonList) =>
      localPokemonList?.map(convertToDomain).toList() ?? [];

  @override
  PokemonModel convertToDomain(PokemonLocalModel pokemon) => PokemonModel(
        id: pokemon.id,
        name: pokemon.name,
        pokedexEntryNumbers: pokemon.pokedexEntryNumbers,
        types: convertTypes(pokemon.types),
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
        hp: pokemon.getBaseStat(PokemonStatString.hp),
        attack: pokemon.getBaseStat(PokemonStatString.attack),
        defense: pokemon.getBaseStat(PokemonStatString.defense),
        specialAttack: pokemon.getBaseStat(PokemonStatString.specialAttack),
        specialDefense: pokemon.getBaseStat(PokemonStatString.specialDefense),
        speed: pokemon.getBaseStat(PokemonStatString.speed),
        hpEvYield: pokemon.getEffortValue(PokemonStatString.hp),
        attackEvYield: pokemon.getEffortValue(PokemonStatString.attack),
        defenseEvYield: pokemon.getEffortValue(PokemonStatString.defense),
        specialAttackEvYield: pokemon.getEffortValue(PokemonStatString.specialAttack),
        specialDefenseEvYield: pokemon.getEffortValue(PokemonStatString.specialDefense),
        speedEvYield: pokemon.getEffortValue(PokemonStatString.speed),
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

  List<PokemonType> convertTypes(List<String>? types) {
    if (types == null) return [];
    const typeMap = {
      PokemonTypeString.normal: PokemonType.normal,
      PokemonTypeString.fighting: PokemonType.fighting,
      PokemonTypeString.flying: PokemonType.flying,
      PokemonTypeString.poison: PokemonType.poison,
      PokemonTypeString.ground: PokemonType.ground,
      PokemonTypeString.rock: PokemonType.rock,
      PokemonTypeString.bug: PokemonType.bug,
      PokemonTypeString.ghost: PokemonType.ghost,
      PokemonTypeString.steel: PokemonType.steel,
      PokemonTypeString.fire: PokemonType.fire,
      PokemonTypeString.water: PokemonType.water,
      PokemonTypeString.grass: PokemonType.grass,
      PokemonTypeString.electric: PokemonType.electric,
      PokemonTypeString.psychic: PokemonType.psychic,
      PokemonTypeString.ice: PokemonType.ice,
      PokemonTypeString.dragon: PokemonType.dragon,
      PokemonTypeString.dark: PokemonType.dark,
      PokemonTypeString.fairy: PokemonType.fairy,
    };
    return types
        .map((type) => typeMap[type])
        .whereType<PokemonType>()
        .toList();
  }
}
