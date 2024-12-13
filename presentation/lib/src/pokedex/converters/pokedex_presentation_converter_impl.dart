import 'package:domain/domain.dart';
import 'package:presentation/src/l10n/gen/presentation_localizations.dart';
import 'package:presentation/src/pokedex/converters/pokedex_pokemon_presentation_converter.dart';
import 'package:presentation/src/pokedex/converters/pokedex_presentation_converter.dart';
import 'package:presentation/src/pokedex/models/pokedex_presentation_model.dart';
import 'package:collection/collection.dart';

import '../models/pokedex_group_presentation_model.dart';

class PokedexPresentationConverterImpl implements PokedexPresentationConverter {
  late final PokedexPokemonPresentationConverter _pokemonConverter;
  late final PresentationLocalizations _localizations;

  PokedexPresentationConverterImpl(this._pokemonConverter, this._localizations);

  @override
  List<PokedexGroupPresentationModel> convertAndOrder(
          List<PokedexModel> pokedexList) =>
      pokedexList
          .map(convert)
          .groupListsBy((pokedex) => pokedex.regionName)
          .entries
          .map((entry) => PokedexGroupPresentationModel(entry.key, entry.value))
          .toList();

  @override
  PokedexPresentationModel convert(PokedexModel pokedex) =>
      PokedexPresentationModel(
        id: pokedex.id,
        regionName: _convertRegionName(pokedex.region),
        versionAbbreviation: _convertVersionsAbbreviation(pokedex.versions),
        displayNames: _getDisplayNames(pokedex.name),
        pokemon: _pokemonConverter.convertList(pokedex.pokemon, pokedex.id),
      );

  String _convertRegionName(PokemonRegion? region) => switch (region) {
        PokemonRegion.national => _localizations.national,
        PokemonRegion.kanto => _localizations.kanto,
        PokemonRegion.johto => _localizations.johto,
        PokemonRegion.hoenn => _localizations.hoenn,
        PokemonRegion.sinnoh => _localizations.sinnoh,
        PokemonRegion.unova => _localizations.unova,
        PokemonRegion.ransei => _localizations.ransei,
        PokemonRegion.kalos => _localizations.kalos,
        PokemonRegion.alola => _localizations.alola,
        PokemonRegion.melemele => _localizations.melemele,
        PokemonRegion.akala => _localizations.akala,
        PokemonRegion.ulaula => _localizations.ulaula,
        PokemonRegion.poni => _localizations.poni,
        PokemonRegion.galar => _localizations.galar,
        PokemonRegion.hisui => _localizations.hisui,
        PokemonRegion.paldea => _localizations.paldea,
        null => "",
      };

  String _convertVersionsAbbreviation(List<PokemonVersion> versions) => versions
      .map((version) => _pokemonVersionAbbreviations(version))
      .join(" & ");

  String _pokemonVersionAbbreviations(PokemonVersion version) =>
      switch (version) {
        PokemonVersion.redBlueYellow => _localizations.rby,
        PokemonVersion.goldSilverCrystal => _localizations.gsc,
        PokemonVersion.rubySapphireEmerald => _localizations.rse,
        PokemonVersion.fireRedLeafGreen => _localizations.frlg,
        PokemonVersion.diamondPearl => _localizations.dp,
        PokemonVersion.platinum => _localizations.pt,
        PokemonVersion.heartGoldSoulSilver => _localizations.hgss,
        PokemonVersion.blackWhite => _localizations.bw,
        PokemonVersion.black2White2 => _localizations.b2w2,
        PokemonVersion.xY => _localizations.xy,
        PokemonVersion.omegaRubyAlphaSapphire => _localizations.oras,
        PokemonVersion.sunMoon => _localizations.sm,
        PokemonVersion.ultraSunUltraMoon => _localizations.usum,
        PokemonVersion.letsGo => _localizations.lgo,
        PokemonVersion.swordShield => _localizations.swsh,
        PokemonVersion.isleOfArmor => _localizations.swsh,
        PokemonVersion.crownTundra => _localizations.swsh,
        PokemonVersion.brilliantDiamondShiningPearl => _localizations.bdsp,
        PokemonVersion.legendsArceus => _localizations.pla,
        PokemonVersion.scarletViolet => _localizations.sv,
        PokemonVersion.theTealMask => _localizations.sv,
        PokemonVersion.theIndigoDisk => _localizations.sv,
        PokemonVersion.legendsZA => _localizations.lza,
        PokemonVersion.conquest => _localizations.conq,
      };

  List<String> _getDisplayNames(PokedexName? pokedexName) {
    var sunMoon = _localizations.sunMoon;
    var ultraSunUltraMoon = _localizations.ultraSunUltraMoon;
    return switch (pokedexName) {
      PokedexName.national => [_localizations.national],
      PokedexName.kanto => [
          _localizations.redBlueYellow,
          _localizations.fireRedLeafGreen
        ],
      PokedexName.letsGoKanto => [_localizations.letsGoPikachuEevee],
      PokedexName.originalJohto => [_localizations.goldSilverCrystal],
      PokedexName.hoenn => [_localizations.rubySapphireEmerald],
      PokedexName.originalSinnoh => [
          _localizations.diamondPearl,
          _localizations.brilliantDiamondShiningPearl
        ],
      PokedexName.extendedSinnoh => [_localizations.platinum],
      PokedexName.updatedJohto => [_localizations.heartGoldSoulSilver],
      PokedexName.originalUnova => [_localizations.blackWhite],
      PokedexName.updatedUnova => [_localizations.black2White2],
      PokedexName.conquestGallery => [_localizations.conquest],
      PokedexName.kalosCentral => [_localizations.central],
      PokedexName.kalosCoastal => [_localizations.coastal],
      PokedexName.kalosMountain => [_localizations.mountain],
      PokedexName.updatedHoenn => [_localizations.omegaRubyAlphaSapphire],
      PokedexName.originalAlola => [sunMoon],
      PokedexName.originalAkala => [sunMoon],
      PokedexName.originalUlaula => [sunMoon],
      PokedexName.originalPoni => [sunMoon],
      PokedexName.originalMelemele => [sunMoon],
      PokedexName.updatedAlola => [ultraSunUltraMoon],
      PokedexName.updatedAkala => [ultraSunUltraMoon],
      PokedexName.updatedUlaula => [ultraSunUltraMoon],
      PokedexName.updatedPoni => [ultraSunUltraMoon],
      PokedexName.updatedMelemele => [ultraSunUltraMoon],
      PokedexName.galar => [_localizations.swordShield],
      PokedexName.isleOfArmor => [_localizations.isleOfArmor],
      PokedexName.crownTundra => [_localizations.crownTundra],
      PokedexName.hisui => [_localizations.legendsArceus],
      PokedexName.paldea => [_localizations.scarlettViolet],
      PokedexName.kitakami => [_localizations.theTealMask],
      PokedexName.blueberry => [_localizations.theIndigoDisk],
      null => [""],
    };
  }
}
