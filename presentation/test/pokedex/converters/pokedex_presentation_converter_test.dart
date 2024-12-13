import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:presentation/presentation.dart';
import 'package:presentation/src/pokedex/converters/pokedex_pokemon_presentation_converter.dart';
import 'package:presentation/src/pokedex/converters/pokedex_presentation_converter_impl.dart';
import 'package:presentation/src/pokedex/models/pokedex_group_presentation_model.dart';
import 'package:presentation/src/pokedex/models/pokedex_pokemon_presentation_model.dart';
import 'package:presentation/src/pokedex/models/pokedex_presentation_model.dart';

import 'pokedex_presentation_converter_test.mocks.dart';

@GenerateMocks([PokedexPokemonPresentationConverter, PresentationLocalizations])
void main() {
  var pokedexId1 = 11;
  var pokedexId2 = 12;
  var pokedexId3 = 13;
  var pokedexName1 = PokedexName.kanto;
  var pokedexName2 = PokedexName.originalJohto;
  var pokedexName3 = PokedexName.updatedJohto;
  var displayNameFRLG = "FireRed, LeafGreen";
  var displayNameGSC = "Gold, Silver, Crystal";
  var displayNameHGSS = "HeartGold, SoulSilver";
  PokemonModel pokemonModel = PokemonModel(
    id: 1,
    name: "pokemon",
    pokedexEntryNumbers: {pokedexId1: 2, pokedexId2: 1},
    spriteUrl: "url/asd/asd/asd/",
    types: ["grass", "flying"],
  );
  PokedexPokemonPresentationModel pokedexPokemonPresentation =
      PokedexPokemonPresentationModel(
          id: 1,
          nationalDexNumber: "0001",
          pokedexEntryNumber: "002",
          name: "Pokemon",
          imageUrl: "url/asd/asd/asd/",
          types: ["Grass", "Flying"]);
  PokedexModel pokedexModel1 = PokedexModel(
    id: pokedexId1,
    name: pokedexName1,
    region: PokemonRegion.kanto,
    versions: [PokemonVersion.redBlueYellow, PokemonVersion.fireRedLeafGreen],
    pokemon: [pokemonModel],
  );
  PokedexModel pokedexModel2 = PokedexModel(
    id: pokedexId2,
    name: pokedexName2,
    region: PokemonRegion.johto,
    versions: [PokemonVersion.goldSilverCrystal],
    pokemon: [],
  );
  PokedexModel pokedexModel3 = PokedexModel(
    id: pokedexId3,
    name: pokedexName3,
    region: PokemonRegion.johto,
    versions: [PokemonVersion.heartGoldSoulSilver],
    pokemon: [],
  );
  PokedexPresentationModel pokedexPresentationModel1 = PokedexPresentationModel(
    id: pokedexId1,
    regionName: "Kanto",
    versionAbbreviation: "RBY & FRLG",
    displayNames: [displayNameFRLG, displayNameFRLG],
    pokemon: [pokedexPokemonPresentation],
  );
  PokedexPresentationModel pokedexPresentationModel2 = PokedexPresentationModel(
    id: pokedexId2,
    regionName: "Johto",
    versionAbbreviation: "GSC",
    displayNames: [displayNameGSC],
    pokemon: [],
  );
  PokedexPresentationModel pokedexPresentationModel3 = PokedexPresentationModel(
    id: pokedexId3,
    regionName: "Johto",
    versionAbbreviation: "HGSS",
    displayNames: [displayNameHGSS],
    pokemon: [],
  );
  var mockPokemonConverter = MockPokedexPokemonPresentationConverter();
  var mockLocalizations = MockPresentationLocalizations();
  var converter = PokedexPresentationConverterImpl(mockPokemonConverter, mockLocalizations);

  setUp(() {
    when(mockLocalizations.kanto).thenReturn("Kanto");
    when(mockLocalizations.rby).thenReturn("RBY");
    when(mockLocalizations.redBlueYellow).thenReturn("Red, Blue & Yellow");
    when(mockLocalizations.frlg).thenReturn("FRLG");
    when(mockLocalizations.fireRedLeafGreen).thenReturn("FireRed & LeafGreen");
    when(mockLocalizations.johto).thenReturn("Johto");
    when(mockLocalizations.gsc).thenReturn("GSC");
    when(mockLocalizations.goldSilverCrystal).thenReturn("Gold, Silver & Crystal");
    when(mockLocalizations.hgss).thenReturn("HGSS");
    when(mockLocalizations.heartGoldSoulSilver).thenReturn("HeartGold & SoulSilver");
    when(mockLocalizations.sunMoon).thenReturn("Sun & Moon");
    when(mockLocalizations.ultraSunUltraMoon).thenReturn("Ultra Sun & Ultra Moon");
  });

  group('convert', () {
    test('convert pokedex', () {
      when(mockPokemonConverter.convertList([pokemonModel], pokedexId1))
          .thenReturn([pokedexPokemonPresentation]);

      var result = converter.convert(pokedexModel1);

      expect(result, pokedexPresentationModel1);
    });
  });

  group('order', () {
    test('order list', () {
      when(mockPokemonConverter.convertList([pokemonModel], pokedexId1))
          .thenReturn([pokedexPokemonPresentation]);
      when(mockPokemonConverter.convertList([], any)).thenReturn([]);

      var result = converter
          .convertAndOrder([pokedexModel1, pokedexModel2, pokedexModel3]);

      var expected = [
        PokedexGroupPresentationModel("Kanto", [pokedexPresentationModel1]),
        PokedexGroupPresentationModel(
            "Johto", [pokedexPresentationModel2, pokedexPresentationModel3]),
      ];

      expect(result, expected);
    });
  });
}
