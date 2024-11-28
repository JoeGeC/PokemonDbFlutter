import 'package:domain/models/pokedex_constants/pokedex_name.dart';
import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokedex_constants/pokemon_region.dart';
import 'package:domain/models/pokedex_constants/pokemon_version.dart';
import 'package:repository/converters/pokedex/pokedex_repository_converter.dart';
import 'package:repository/converters/pokemon/pokemon_repository_converter.dart';
import 'package:repository/models/data/pokedex/pokedex_data_model.dart';
import 'package:repository/models/data/pokedex_list/pokedex_list_item_data_model.dart';
import 'package:repository/models/exceptions/NullException.dart';
import 'package:repository/models/local/pokedex_local_model.dart';

import '../../models/data/pokedex_list/pokedex_list_data_model.dart';
import '../BaseRepositoryConverter.dart';

class PokedexRepositoryConverterImpl extends BaseRepositoryConverter
    implements PokedexRepositoryConverter {
  PokemonRepositoryConverter pokemonConverter;

  PokedexRepositoryConverterImpl(this.pokemonConverter);

  @override
  PokedexModel convertToDomain(PokedexLocalModel pokedexLocalModel) =>
      PokedexModel(
          id: pokedexLocalModel.id,
          name: convertName(pokedexLocalModel.name),
          versions: getVersionsFromName(pokedexLocalModel.name),
          region: getRegionFromName(pokedexLocalModel.name),
          pokemon:
              pokemonConverter.convertListToDomain(pokedexLocalModel.pokemon));

  @override
  PokedexLocalModel convertToLocal(PokedexDataModel pokedexDataModel) {
    _validateNotNull(pokedexDataModel);
    return PokedexLocalModel(
        id: pokedexDataModel.id!,
        name: pokedexDataModel.name!,
        pokemon: pokemonConverter.convertPokedexListToLocal(
            pokedexDataModel.pokemonEntries, pokedexDataModel.id!));
  }

  void _validateNotNull(PokedexDataModel pokedexDataModel) {
    if (pokedexDataModel.id == null) throw NullException(NullType.id);
    if (pokedexDataModel.name == null) throw NullException(NullType.name);
  }

  @override
  List<PokedexModel> convertListToDomain(
          List<PokedexLocalModel> pokedexLocalList) =>
      pokedexLocalList.map((pokedex) => convertToDomain(pokedex)).toList();

  @override
  List<PokedexLocalModel> convertListToLocal(
          PokedexListDataModel pokedexDataList) =>
      pokedexDataList.results
          ?.map((pokedex) => convertListItemToLocal(pokedex))
          .toList() ??
      [];

  PokedexLocalModel convertListItemToLocal(PokedexListItemDataModel pokedex) =>
      PokedexLocalModel(
        id: getIdFromUrl(pokedex.url),
        name: pokedex.name,
      );

  List<PokemonVersion> getVersionsFromName(String name) => switch (name) {
        "national" => [],
        "kanto" => [
            PokemonVersion.redBlueYellow,
            PokemonVersion.fireRedLeafGreen
          ],
        "original-johto" => [
            PokemonVersion.goldSilverCrystal,
          ],
        "hoenn" => [
            PokemonVersion.rubySapphireEmerald,
          ],
        "original-sinnoh" => [
            PokemonVersion.diamondPearl,
            PokemonVersion.brilliantDiamondShiningPearl,
          ],
        "extended-sinnoh" => [
            PokemonVersion.platinum,
          ],
        "updated-johto" => [
            PokemonVersion.heartGoldSoulSilver,
          ],
        "original-unova" => [
            PokemonVersion.blackWhite,
          ],
        "updated-unova" => [
            PokemonVersion.black2White2,
          ],
        "conquest-gallery" => [PokemonVersion.conquest],
        "kalos-central" => [
            PokemonVersion.xY,
          ],
        "kalos-coastal" => [
            PokemonVersion.xY,
          ],
        "kalos-mountain" => [
            PokemonVersion.xY,
          ],
        "updated-hoenn" => [
            PokemonVersion.omegaRubyAlphaSapphire,
          ],
        "original-alola" => [
            PokemonVersion.sunMoon,
          ],
        "original-melemele" => [
            PokemonVersion.sunMoon,
          ],
        "original-akala" => [
            PokemonVersion.sunMoon,
          ],
        "original-ulaula" => [
            PokemonVersion.sunMoon,
          ],
        "original-poni" => [
            PokemonVersion.sunMoon,
          ],
        "updated-alola" => [
            PokemonVersion.ultraSunUltraMoon,
          ],
        "updated-akala" => [
            PokemonVersion.ultraSunUltraMoon,
          ],
        "updated-ulaula" => [
            PokemonVersion.ultraSunUltraMoon,
          ],
        "updated-poni" => [
            PokemonVersion.ultraSunUltraMoon,
          ],
        "updated-melemele" => [
            PokemonVersion.ultraSunUltraMoon,
          ],
        "letsgo-kanto" => [PokemonVersion.letsGo],
        "galar" => [
            PokemonVersion.swordShield,
          ],
        "isle-of-armor" => [
            PokemonVersion.swordShield,
          ],
        "crown-tundra" => [
            PokemonVersion.swordShield,
          ],
        String() => [],
      };

  PokemonRegion? getRegionFromName(String name) => switch (name) {
        "national" => PokemonRegion.national,
        "kanto" => PokemonRegion.kanto,
        "original-johto" => PokemonRegion.johto,
        "hoenn" => PokemonRegion.hoenn,
        "original-sinnoh" => PokemonRegion.sinnoh,
        "extended-sinnoh" => PokemonRegion.sinnoh,
        "updated-johto" => PokemonRegion.johto,
        "original-unova" => PokemonRegion.unova,
        "updated-unova" => PokemonRegion.unova,
        "conquest-gallery" => PokemonRegion.ransei,
        "kalos-central" => PokemonRegion.kalos,
        "kalos-coastal" => PokemonRegion.kalos,
        "kalos-mountain" => PokemonRegion.kalos,
        "updated-hoenn" => PokemonRegion.hoenn,
        "original-alola" => PokemonRegion.alola,
        "original-melemele" => PokemonRegion.melemele,
        "original-akala" => PokemonRegion.akala,
        "original-ulaula" => PokemonRegion.ulaula,
        "original-poni" => PokemonRegion.poni,
        "updated-akala" => PokemonRegion.akala,
        "updated-ulaula" => PokemonRegion.ulaula,
        "updated-poni" => PokemonRegion.poni,
        "updated-alola" => PokemonRegion.alola,
        "updated-melemele" => PokemonRegion.melemele,
        "letsgo-kanto" => PokemonRegion.kanto,
        "galar" => PokemonRegion.galar,
        "isle-of-armor" => PokemonRegion.galar,
        "crown-tundra" => PokemonRegion.galar,
        String() => null,
      };

  PokedexName? convertName(String name) => switch(name) {
      "national"  => PokedexName.national,
      "kanto"  => PokedexName.kanto,
      "original-johto"  => PokedexName.originalJohto,
      "hoenn"  => PokedexName.hoenn,
      "original-sinnoh"  => PokedexName.originalSinnoh,
      "extended-sinnoh"  => PokedexName.extendedSinnoh,
      "updated-johto"  => PokedexName.updatedJohto,
      "original-unova"  => PokedexName.originalUnova,
      "updated-unova"  => PokedexName.updatedUnova,
      "conquest-gallery"  => PokedexName.conquestGallery,
      "kalos-central"  => PokedexName.kalosCentral,
      "kalos-coastal"  => PokedexName.kalosCoastal,
      "kalos-mountain"  => PokedexName.kalosMountain,
      "updated-hoenn"  => PokedexName.updatedHoenn,
      "original-alola"  => PokedexName.originalAlola,
      "original-melemele"  => PokedexName.originalMelemele,
      "original-akala"  => PokedexName.originalAlola,
      "original-ulaula"  => PokedexName.originalUlaula,
      "original-poni"  => PokedexName.originalPoni,
      "updated-akala"  => PokedexName.updatedAkala,
      "updated-ulaula"  => PokedexName.updatedUlaula,
      "updated-poni"  => PokedexName.updatedPoni,
      "updated-alola"  => PokedexName.updatedAkala,
      "updated-melemele"  => PokedexName.updatedMelemele,
      "letsgo-kanto"  => PokedexName.letsGoKanto,
      "galar"  => PokedexName.galar,
      "isle-of-armor"  => PokedexName.isleOfArmor,
      "crown-tundra"  => PokedexName.crownTundra,
      String() => null,
    };
}
