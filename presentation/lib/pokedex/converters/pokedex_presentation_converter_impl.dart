import 'package:domain/models/pokedex_constants/pokemon_region.dart';
import 'package:domain/models/pokedex_constants/pokemon_version.dart';
import 'package:domain/models/pokedex_constants/pokedex_name.dart';
import 'package:domain/models/pokedex_model.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';
import 'package:collection/collection.dart';

import '../../pokemon/converters/pokemon_presentation_converter.dart';

class PokedexPresentationConverterImpl implements PokedexPresentationConverter {
  late PokedexPokemonPresentationConverter pokemonConverter;

  PokedexPresentationConverterImpl(this.pokemonConverter);

  @override
  Map<String, List<PokedexPresentationModel>> convertAndOrder(
      List<PokedexModel> pokedexList) {
    return pokedexList
        .map(convert)
        .groupListsBy((pokedex) => pokedex.regionName);
  }

  @override
  PokedexPresentationModel convert(PokedexModel pokedex) =>
      PokedexPresentationModel(
        id: pokedex.id,
        regionName: _convertRegionName(pokedex.region),
        versionAbbreviation: _convertVersionsAbbreviation(pokedex.versions),
        displayNames: _getDisplayNames(pokedex.name),
        pokemon: pokemonConverter.convertList(pokedex.pokemon, pokedex.id),
      );

  String _convertRegionName(PokemonRegion? region) => switch (region) {
        PokemonRegion.national => "National",
        PokemonRegion.kanto => "Kanto",
        PokemonRegion.johto => "Johto",
        PokemonRegion.hoenn => "Hoenn",
        PokemonRegion.sinnoh => "Sinnoh",
        PokemonRegion.unova => "Unova",
        PokemonRegion.ransei => "Ransei",
        PokemonRegion.kalos => "Kalos",
        PokemonRegion.alola => "Alola",
        PokemonRegion.melemele => "Melemele",
        PokemonRegion.akala => "Akala",
        PokemonRegion.ulaula => "Ulaula",
        PokemonRegion.poni => "Poni",
        PokemonRegion.galar => "Galar",
        PokemonRegion.hisui => "Hisui",
        PokemonRegion.paldea => "Paldea",
        null => "",
      };

  String _convertVersionsAbbreviation(List<PokemonVersion> versions) => versions
      .map((version) => _pokemonVersionAbbreviations[version])
      .where((abbreviation) => abbreviation != null)
      .join(" & ");

  final Map<PokemonVersion, String> _pokemonVersionAbbreviations = {
    PokemonVersion.redBlueYellow: "RBY",
    PokemonVersion.goldSilverCrystal: "GSC",
    PokemonVersion.rubySapphireEmerald: "RSE",
    PokemonVersion.fireRedLeafGreen: "FRLG",
    PokemonVersion.diamondPearl: "DP",
    PokemonVersion.platinum: "Pt",
    PokemonVersion.heartGoldSoulSilver: "HGSS",
    PokemonVersion.blackWhite: "BW",
    PokemonVersion.black2White2: "B2W2",
    PokemonVersion.xY: "XY",
    PokemonVersion.omegaRubyAlphaSapphire: "ORAS",
    PokemonVersion.sunMoon: "SM",
    PokemonVersion.ultraSunUltraMoon: "USUM",
    PokemonVersion.letsGo: "LGo",
    PokemonVersion.swordShield: "SwSh",
    PokemonVersion.isleOfArmor: "SwSh",
    PokemonVersion.crownTundra: "SwSh",
    PokemonVersion.brilliantDiamondShiningPearl: "BDSP",
    PokemonVersion.legendsArceus: "PLA",
    PokemonVersion.scarletViolet: "SV",
    PokemonVersion.theTealMask: "SV",
    PokemonVersion.theIndigoDisk: "SV",
    PokemonVersion.legendsZA: "LZA",
    PokemonVersion.conquest: "Conq",
  };

  List<String> _getDisplayNames(PokedexName? pokedexName) {
    return switch (pokedexName) {
      PokedexName.national => ["National"],
      PokedexName.kanto => ["Red, Blue & Yellow", "FireRed & LeafGreen"],
      PokedexName.letsGoKanto => ["Let's Go Pikachu & Eevee"],
      PokedexName.originalJohto => ["Gold, Silver & Crystal"],
      PokedexName.hoenn => ["Ruby, Sapphire & Emerald"],
      PokedexName.originalSinnoh => [
          "Diamond & Pearl",
          "Brilliant Diamond & Shining Pearl"
        ],
      PokedexName.extendedSinnoh => ["Platinum"],
      PokedexName.updatedJohto => ["HeartGold & SoulSilver"],
      PokedexName.originalUnova => ["Black & White"],
      PokedexName.updatedUnova => ["Black 2 & White 2"],
      PokedexName.conquestGallery => ["Conquest"],
      PokedexName.kalosCentral => ["Central"],
      PokedexName.kalosCoastal => ["Coastal"],
      PokedexName.kalosMountain => ["Mountain"],
      PokedexName.updatedHoenn => ["Omega Ruby & Alpha Sapphire"],
      PokedexName.originalAlola => ["Sun & Moon"],
      PokedexName.originalMelemele => ["Sun & Moon"],
      PokedexName.originalUlaula => ["Sun & Moon"],
      PokedexName.originalPoni => ["Sun & Moon"],
      PokedexName.updatedAkala => ["Ultra Sun & Ultra Moon"],
      PokedexName.updatedUlaula => ["Ultra Sun & Ultra Moon"],
      PokedexName.updatedPoni => ["Ultra Sun & Ultra Moon"],
      PokedexName.updatedMelemele => ["Ultra Sun & Ultra Moon"],
      PokedexName.galar => ["Sword & Shield"],
      PokedexName.isleOfArmor => ["Isle of Armor"],
      PokedexName.crownTundra => ["Crown Tundra"],
      null => [""],
    };
  }

  final Map<PokemonVersion, String> _pokemonVersionLabels = {
    PokemonVersion.redBlueYellow: "Red, Blue, Yellow",
    PokemonVersion.goldSilverCrystal: "Gold, Silver, Crystal",
    PokemonVersion.rubySapphireEmerald: "Ruby, Sapphire, Emerald",
    PokemonVersion.fireRedLeafGreen: "FireRed, LeafGreen",
    PokemonVersion.diamondPearl: "Diamond, Pearl",
    PokemonVersion.platinum: "Platinum",
    PokemonVersion.heartGoldSoulSilver: "HeartGold, SoulSilver",
    PokemonVersion.blackWhite: "Black, White",
    PokemonVersion.black2White2: "Black 2, White 2",
    PokemonVersion.xY: "X, Y",
    PokemonVersion.omegaRubyAlphaSapphire: "Omega Ruby, Alpha Sapphire",
    PokemonVersion.sunMoon: "Sun, Moon",
    PokemonVersion.ultraSunUltraMoon: "Ultra Sun, Ultra Moon",
    PokemonVersion.letsGo: "Let's Go Pikachu & Eevee",
    PokemonVersion.swordShield: "Sword, Shield",
    PokemonVersion.isleOfArmor: "Isle of Armor",
    PokemonVersion.crownTundra: "Crown Tundra",
    PokemonVersion.brilliantDiamondShiningPearl:
        "Brilliant Diamond, Shining Pearl",
    PokemonVersion.legendsArceus: "Legends Arceus",
    PokemonVersion.scarletViolet: "Scarlett, Violet",
    PokemonVersion.theTealMask: "The Teal Mask",
    PokemonVersion.theIndigoDisk: "The Indigo Disk",
    PokemonVersion.legendsZA: "Legends Z-A",
    PokemonVersion.conquest: "Conquest",
  };
}
