import 'package:domain/domain.dart';
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
  PokedexModel convertToDomain(PokedexLocalModel pokedexLocalModel) {
    var pokedexName = convertName(pokedexLocalModel.name);
    return PokedexModel(
        id: pokedexLocalModel.id,
        name: pokedexName,
        versions: getVersionsFromName(pokedexName),
        region: getRegionFromName(pokedexName),
        pokemon:
            pokemonConverter.convertListToDomain(pokedexLocalModel.pokemon));
  }

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

  List<PokemonVersion> getVersionsFromName(PokedexName? name) => switch (name) {
        PokedexName.national => [],
        PokedexName.kanto => [
            PokemonVersion.redBlueYellow,
            PokemonVersion.fireRedLeafGreen
          ],
        PokedexName.originalJohto => [PokemonVersion.goldSilverCrystal],
        PokedexName.hoenn => [PokemonVersion.rubySapphireEmerald],
        PokedexName.originalSinnoh => [
            PokemonVersion.diamondPearl,
            PokemonVersion.brilliantDiamondShiningPearl,
          ],
        PokedexName.extendedSinnoh => [PokemonVersion.platinum],
        PokedexName.updatedJohto => [PokemonVersion.heartGoldSoulSilver],
        PokedexName.originalUnova => [PokemonVersion.blackWhite],
        PokedexName.updatedUnova => [PokemonVersion.black2White2],
        PokedexName.conquestGallery => [PokemonVersion.conquest],
        PokedexName.kalosCentral => [PokemonVersion.xY],
        PokedexName.kalosCoastal => [PokemonVersion.xY],
        PokedexName.kalosMountain => [PokemonVersion.xY],
        PokedexName.updatedHoenn => [PokemonVersion.omegaRubyAlphaSapphire],
        PokedexName.originalAlola => [PokemonVersion.sunMoon],
        PokedexName.originalMelemele => [PokemonVersion.sunMoon],
        PokedexName.originalAkala => [PokemonVersion.sunMoon],
        PokedexName.originalUlaula => [PokemonVersion.sunMoon],
        PokedexName.originalPoni => [PokemonVersion.sunMoon],
        PokedexName.updatedAlola => [PokemonVersion.ultraSunUltraMoon],
        PokedexName.updatedAkala => [PokemonVersion.ultraSunUltraMoon],
        PokedexName.updatedUlaula => [PokemonVersion.ultraSunUltraMoon],
        PokedexName.updatedPoni => [PokemonVersion.ultraSunUltraMoon],
        PokedexName.updatedMelemele => [PokemonVersion.ultraSunUltraMoon],
        PokedexName.letsGoKanto => [PokemonVersion.letsGo],
        PokedexName.galar => [PokemonVersion.swordShield],
        PokedexName.isleOfArmor => [PokemonVersion.swordShield],
        PokedexName.crownTundra => [PokemonVersion.swordShield],
        PokedexName.hisui => [PokemonVersion.legendsArceus],
        PokedexName.paldea => [PokemonVersion.scarletViolet],
        PokedexName.kitakami => [PokemonVersion.scarletViolet],
        PokedexName.blueberry => [PokemonVersion.scarletViolet],
        null => [],
      };

  PokemonRegion? getRegionFromName(PokedexName? name) => switch (name) {
        PokedexName.national => PokemonRegion.national,
        PokedexName.kanto => PokemonRegion.kanto,
        PokedexName.originalJohto => PokemonRegion.johto,
        PokedexName.hoenn => PokemonRegion.hoenn,
        PokedexName.originalSinnoh => PokemonRegion.sinnoh,
        PokedexName.extendedSinnoh => PokemonRegion.sinnoh,
        PokedexName.updatedJohto => PokemonRegion.johto,
        PokedexName.originalUnova => PokemonRegion.unova,
        PokedexName.updatedUnova => PokemonRegion.unova,
        PokedexName.conquestGallery => PokemonRegion.ransei,
        PokedexName.kalosCentral => PokemonRegion.kalos,
        PokedexName.kalosCoastal => PokemonRegion.kalos,
        PokedexName.kalosMountain => PokemonRegion.kalos,
        PokedexName.updatedHoenn => PokemonRegion.hoenn,
        PokedexName.originalAlola => PokemonRegion.alola,
        PokedexName.originalAkala => PokemonRegion.akala,
        PokedexName.originalMelemele => PokemonRegion.melemele,
        PokedexName.originalUlaula => PokemonRegion.ulaula,
        PokedexName.originalPoni => PokemonRegion.poni,
        PokedexName.updatedAkala => PokemonRegion.akala,
        PokedexName.updatedUlaula => PokemonRegion.ulaula,
        PokedexName.updatedPoni => PokemonRegion.poni,
        PokedexName.updatedAlola => PokemonRegion.alola,
        PokedexName.updatedMelemele => PokemonRegion.melemele,
        PokedexName.letsGoKanto => PokemonRegion.kanto,
        PokedexName.galar => PokemonRegion.galar,
        PokedexName.isleOfArmor => PokemonRegion.galar,
        PokedexName.crownTundra => PokemonRegion.galar,
        PokedexName.hisui => PokemonRegion.hisui,
        PokedexName.paldea => PokemonRegion.paldea,
        PokedexName.kitakami => PokemonRegion.paldea,
        PokedexName.blueberry => PokemonRegion.paldea,
        null => null,
      };

  PokedexName? convertName(String name) => switch (name) {
        "national" => PokedexName.national,
        "kanto" => PokedexName.kanto,
        "original-johto" => PokedexName.originalJohto,
        "hoenn" => PokedexName.hoenn,
        "original-sinnoh" => PokedexName.originalSinnoh,
        "extended-sinnoh" => PokedexName.extendedSinnoh,
        "updated-johto" => PokedexName.updatedJohto,
        "original-unova" => PokedexName.originalUnova,
        "updated-unova" => PokedexName.updatedUnova,
        "conquest-gallery" => PokedexName.conquestGallery,
        "kalos-central" => PokedexName.kalosCentral,
        "kalos-coastal" => PokedexName.kalosCoastal,
        "kalos-mountain" => PokedexName.kalosMountain,
        "updated-hoenn" => PokedexName.updatedHoenn,
        "original-alola" => PokedexName.originalAlola,
        "original-melemele" => PokedexName.originalMelemele,
        "original-akala" => PokedexName.originalAkala,
        "original-ulaula" => PokedexName.originalUlaula,
        "original-poni" => PokedexName.originalPoni,
        "updated-akala" => PokedexName.updatedAkala,
        "updated-alola" => PokedexName.updatedAlola,
        "updated-ulaula" => PokedexName.updatedUlaula,
        "updated-poni" => PokedexName.updatedPoni,
        "updated-melemele" => PokedexName.updatedMelemele,
        "letsgo-kanto" => PokedexName.letsGoKanto,
        "galar" => PokedexName.galar,
        "isle-of-armor" => PokedexName.isleOfArmor,
        "crown-tundra" => PokedexName.crownTundra,
        "hisui" => PokedexName.hisui,
        "paldea" => PokedexName.paldea,
        "kitakami" => PokedexName.kitakami,
        "blueberry" => PokedexName.blueberry,
        String() => null,
      };
}
