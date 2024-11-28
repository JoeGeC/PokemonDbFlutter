import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokemon_region.dart';
import 'package:domain/models/pokemon_version.dart';
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
        regionName: convertRegionName(pokedex.region),
        versionAbbreviation: convertVersionsAbbreviation(pokedex.versions),
        pokemon: pokemonConverter.convertList(pokedex.pokemon, pokedex.id),
      );

  String convertRegionName(PokemonRegion? region) => switch (region) {
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

  String convertVersionsAbbreviation(List<PokemonVersion> versions) {
    var result = "";
    for (var version in versions) {
      if (result.isNotEmpty) {
        result += " & ";
      }
      var abbreviation = pokemonVersionAbbreviations[version];
      if (abbreviation != null) {
        result += abbreviation;
      }
    }
    return result;
  }

  Map<PokemonVersion, String> pokemonVersionAbbreviations = {
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
}
