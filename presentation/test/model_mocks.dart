import 'package:domain/domain.dart';
import 'package:presentation/src/pokedex/models/pokedex_group_presentation_model.dart';
import 'package:presentation/src/pokedex/models/pokedex_pokemon_presentation_model.dart';
import 'package:presentation/src/pokedex/models/pokedex_presentation_model.dart';
import 'package:presentation/src/pokemon/models/pokemon_presentation_model.dart';

String errorMessage = "Error message";

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
List<String> pokemonPresenterTypes = ["Grass", "Psychic"];
List<PokemonType> pokemonDomainTypes = [PokemonType.grass, PokemonType.psychic];
Map<int, int> pokedexEntryNumbers = {pokedexId1: pokedexEntryNumber};
String pokemonSpriteUrl = "https://pokeapi.com/image-sprite.png";
String pokemonArtworkUrl = "https://pokeapi.com/image-artwork.png";

int pokemonId2 = 2;
int pokedexEntryNumber2 = 102;
String pokedexEntryNumberPresentation2 = "102";
String pokemonNationalDexNumber2 = "0002";
String pokemonName2 = "Example Pokemon 2";
List<String> pokemonPresenterTypes2 = ["Fire", "Fighting"];
List<PokemonType> pokemonDomainTypes2 = [
  PokemonType.fire,
  PokemonType.fighting
];
Map<int, int> pokedexEntryNumbers2 = {pokedexId1: pokedexEntryNumber2};
String pokemonSpriteUrl2 = "https://pokeapi.com/image-sprite2.png";
String pokemonArtworkUrl2 = "https://pokeapi.com/image-artwork2.png";

int baseStatHp = 11;
int statEffortHp = 1;
int baseStatAttack = 12;
int statEffortAttack = 0;
int baseStatDefense = 13;
int statEffortDefense = 0;
int baseStatSpecialAttack = 14;
int statEffortSpecialAttack = 0;
int baseStatSpecialDefense = 15;
int statEffortSpecialDefense = 0;
int baseStatSpeed = 16;
int statEffortSpeed = 0;

PokemonModel pokemonModel = PokemonModel(
  id: pokemonId,
  name: pokemonName,
  pokedexEntryNumbers: pokedexEntryNumbers,
  spriteUrl: pokemonSpriteUrl,
  artworkUrl: pokemonArtworkUrl,
  types: pokemonDomainTypes,
  hp: baseStatHp,
  attack: baseStatAttack,
  defense: baseStatDefense,
  specialAttack: baseStatSpecialAttack,
  specialDefense: baseStatSpecialDefense,
  speed: baseStatSpeed,
  hpEvYield: statEffortHp,
  attackEvYield: statEffortAttack,
  defenseEvYield: statEffortDefense,
  specialAttackEvYield: statEffortSpecialAttack,
  specialDefenseEvYield: statEffortSpecialDefense,
  speedEvYield: statEffortSpeed,
);

PokemonModel pokemonModelUndetailed = PokemonModel(
  id: pokemonId,
  name: pokemonName,
  pokedexEntryNumbers: pokedexEntryNumbers,
  spriteUrl: pokemonSpriteUrl,
  artworkUrl: pokemonArtworkUrl,
  types: pokemonDomainTypes,
);

PokemonModel pokemonModelUndetailed2 = PokemonModel(
  id: pokemonId2,
  name: pokemonName2,
  pokedexEntryNumbers: pokedexEntryNumbers2,
  spriteUrl: pokemonSpriteUrl2,
  artworkUrl: pokemonArtworkUrl2,
  types: pokemonDomainTypes2,
);

PokemonPresentationModel pokemonPresentationModel = PokemonPresentationModel(
  id: pokemonId,
  name: pokemonName,
  spriteUrl: pokemonSpriteUrl,
  artworkUrl: pokemonArtworkUrl,
  nationalDexNumber: pokemonNationalDexNumber,
  types: pokemonPresenterTypes,
  hp: baseStatHp,
  attack: baseStatAttack,
  defense: baseStatDefense,
  specialAttack: baseStatSpecialAttack,
  specialDefense: baseStatSpecialDefense,
  speed: baseStatSpeed,
  hpEvYield: statEffortHp,
  attackEvYield: statEffortAttack,
  defenseEvYield: statEffortDefense,
  specialAttackEvYield: statEffortSpecialAttack,
  specialDefenseEvYield: statEffortSpecialDefense,
  speedEvYield: statEffortSpeed,
);

PokemonPresentationModel pokemonPresentationModel2 = PokemonPresentationModel(
  id: pokemonId2,
  name: pokemonName2,
  spriteUrl: pokemonSpriteUrl2,
  artworkUrl: pokemonArtworkUrl2,
  nationalDexNumber: pokemonNationalDexNumber2,
  types: pokemonPresenterTypes2,
);

PokedexPokemonPresentationModel pokedexPokemonPresentationModel =
    PokedexPokemonPresentationModel(
        id: pokemonId,
        nationalDexNumber: pokemonNationalDexNumber,
        pokedexEntryNumber: pokedexEntryNumberPresentation,
        name: pokemonName,
        types: pokemonPresenterTypes,
        imageUrl: pokemonSpriteUrl);

PokedexPokemonPresentationModel pokedexPokemonPresentationModel2 =
    PokedexPokemonPresentationModel(
        id: pokemonId2,
        nationalDexNumber: pokemonNationalDexNumber2,
        pokedexEntryNumber: pokedexEntryNumberPresentation2,
        name: pokemonName2,
        types: pokemonPresenterTypes2,
        imageUrl: pokemonSpriteUrl2);

PokedexPokemonPresentationModel pokedexPokemonPresentationModelUndetailed =
    PokedexPokemonPresentationModel(
  id: pokemonId,
  nationalDexNumber: pokemonNationalDexNumber,
  pokedexEntryNumber: pokedexEntryNumberPresentation,
  name: pokemonName,
  types: [],
);

List<PokemonModel> pokemonModelList = [
  pokemonModelUndetailed,
  pokemonModelUndetailed2
];

List<PokemonPresentationModel> pokemonPresentationModelList = [
  pokemonPresentationModel,
  pokemonPresentationModel2
];

List<PokedexPokemonPresentationModel> pokedexPokemonPresentationModelList = [
  pokedexPokemonPresentationModel,
  pokedexPokemonPresentationModel2
];

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
