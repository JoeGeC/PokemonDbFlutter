import 'package:domain/models/pokedex_constants/pokedex_name.dart';
import 'package:domain/models/pokedex_constants/pokemon_region.dart';
import 'package:domain/models/pokedex_constants/pokemon_version.dart';
import 'package:domain/models/pokedex_model.dart';
import 'package:domain/models/pokemon_model.dart';
import 'package:presentation/pokedex/models/pokedex_group_presentation_model.dart';
import 'package:presentation/pokedex/models/pokedex_pokemon_presentation_model.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';

int pokedexId1 = 11;
int pokedexId2 = 12;
int pokedexId3 = 13;
String pokedexRegion1 = "Kanto";
String pokedexRegion2 = "Johto";
String pokedexVersionAbbreviation1 = "RBY";
String pokedexVersionAbbreviation2 = "GSC";
String pokedexVersionAbbreviation3 = "HGSS";
PokedexName pokedexName1 = PokedexName.kanto;
PokedexName pokedexName2 = PokedexName.originalJohto;
PokedexName pokedexName3 = PokedexName.updatedJohto;

int pokemonId = 1;
int pokedexEntryNumber = 101;
String pokedexEntryNumberPresentation = "101";
String pokemonNationalDexNumber = "0001";
String pokemonName = "Example Pokemon";
List<String> pokemonTypes = ["Grass"];
Map<int, int> pokedexEntryNumbers = {pokedexId1: pokedexEntryNumber};
String pokemonImageUrl1 = "https://pokeapi.com/asd.png";

PokemonModel pokemonModel = PokemonModel(
  id: pokemonId,
  name: pokemonName,
  pokedexEntryNumbers: pokedexEntryNumbers,
  imageUrl: pokemonImageUrl1
);

PokedexPokemonPresentationModel pokedexPokemonPresentationModel =
    PokedexPokemonPresentationModel(
  id: pokemonId,
  nationalDexNumber: pokemonNationalDexNumber,
  pokedexEntryNumber: pokedexEntryNumberPresentation,
  name: pokemonName,
  types: pokemonTypes,
  imageUrl: pokemonImageUrl1
);

PokedexPokemonPresentationModel pokedexPokemonPresentationModelUndetailed =
    PokedexPokemonPresentationModel(
  id: pokemonId,
  nationalDexNumber: pokemonNationalDexNumber,
  pokedexEntryNumber: pokedexEntryNumberPresentation,
  name: pokemonName,
  types: [],
);

PokedexModel pokedexModel1 = PokedexModel(
  id: pokedexId1,
  name: pokedexName1,
  versions: [PokemonVersion.redBlueYellow],
  region: PokemonRegion.kanto,
  pokemon: [pokemonModel],
);

PokedexModel pokedexModel2 = PokedexModel(
  id: pokedexId2,
  name: pokedexName2,
  versions: [PokemonVersion.goldSilverCrystal],
  region: PokemonRegion.johto,
  pokemon: [],
);

PokedexModel pokedexModel3 = PokedexModel(
  id: pokedexId3,
  name: pokedexName3,
  versions: [PokemonVersion.heartGoldSoulSilver],
  region: PokemonRegion.johto,
  pokemon: [],
);

PokedexPresentationModel pokedexPresentationModel1 = PokedexPresentationModel(
  id: pokedexId1,
  regionName: pokedexRegion1,
  versionAbbreviation: pokedexVersionAbbreviation1,
  displayNames: [pokedexRegion1],
  pokemon: [pokedexPokemonPresentationModel],
);

PokedexPresentationModel pokedexPresentationModel2 = PokedexPresentationModel(
  id: pokedexId2,
  regionName: pokedexRegion2,
  versionAbbreviation: pokedexVersionAbbreviation2,
  displayNames: [pokedexRegion2],
  pokemon: [],
);

PokedexPresentationModel pokedexPresentationModel3 = PokedexPresentationModel(
  id: pokedexId3,
  regionName: pokedexRegion2,
  versionAbbreviation: pokedexVersionAbbreviation3,
  displayNames: [pokedexRegion2],
  pokemon: [],
);

List<PokedexModel> pokedexModelList1 = [pokedexModel1];

List<PokedexModel> pokedexModelList2 = [
  pokedexModel1,
  pokedexModel2,
  pokedexModel3
];

List<PokedexPresentationModel> pokedexPresentationModelListKanto = [
  pokedexPresentationModel1,
];

List<PokedexPresentationModel> pokedexPresentationModelListJohto = [
  pokedexPresentationModel2,
  pokedexPresentationModel3,
];

PokedexGroupPresentationModel pokedexGroupKanto = PokedexGroupPresentationModel(
    pokedexRegion1, pokedexPresentationModelListKanto);

PokedexGroupPresentationModel pokedexGroupJohto = PokedexGroupPresentationModel(
    pokedexRegion2, pokedexPresentationModelListJohto);

List<PokedexGroupPresentationModel> pokedexGroupList1 = [
  pokedexGroupKanto,
];

List<PokedexGroupPresentationModel> pokedexGroupList2 = [
  pokedexGroupKanto,
  pokedexGroupJohto
];
