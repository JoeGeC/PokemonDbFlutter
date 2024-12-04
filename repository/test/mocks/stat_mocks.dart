import 'package:repository/models/data/stat/pokemon_stat_data_model.dart';

class StatRepoMocks {
  static final int baseStatHp = 11;
  static final int statEffortHp = 1;
  static final String statNameHp = "hp";
  static final String statUrlHp = "https://pokeapi.co/api/v2/stat/1/";

  static final int baseStatAttack = 12;
  static final int statEffortAttack = 0;
  static final String statNameAttack = "attack";
  static final String statUrlAttack = "https://pokeapi.co/api/v2/stat/2/";

  static final int baseStatDefense = 13;
  static final int statEffortDefense = 0;
  static final String statNameDefense = "defense";
  static final String statUrlDefense = "https://pokeapi.co/api/v2/stat/3/";

  static final int baseStatSpecialAttack = 14;
  static final int statEffortSpecialAttack = 0;
  static final String statNameSpecialAttack = "special-attack";
  static final String statUrlSpecialAttack =
      "https://pokeapi.co/api/v2/stat/4/";

  static final int baseStatSpecialDefense = 15;
  static final int statEffortSpecialDefense = 0;
  static final String statNameSpecialDefense = "special-defense";
  static final String statUrlSpecialDefense =
      "https://pokeapi.co/api/v2/stat/5/";

  static final int baseStatSpeed = 16;
  static final int statEffortSpeed = 0;
  static final String statNameSpeed = "speed";
  static final String statUrlSpeed = "https://pokeapi.co/api/v2/stat/6/";

  static final PokemonStatDataModel statHp = PokemonStatDataModel(
    baseStatHp,
    statEffortHp,
    statNameHp,
    statUrlHp,
  );
  static final PokemonStatDataModel statAttack = PokemonStatDataModel(
    baseStatAttack,
    statEffortAttack,
    statNameAttack,
    statUrlAttack,
  );
  static final PokemonStatDataModel statDefense = PokemonStatDataModel(
    baseStatDefense,
    statEffortDefense,
    statNameDefense,
    statUrlDefense,
  );
  static final PokemonStatDataModel statSpecialAttack = PokemonStatDataModel(
    baseStatSpecialAttack,
    statEffortSpecialAttack,
    statNameSpecialAttack,
    statUrlSpecialAttack,
  );
  static final PokemonStatDataModel statSpecialDefense = PokemonStatDataModel(
    baseStatSpecialDefense,
    statEffortSpecialDefense,
    statNameSpecialDefense,
    statUrlSpecialDefense,
  );
  static final PokemonStatDataModel statSpeed = PokemonStatDataModel(
    baseStatSpeed,
    statEffortSpeed,
    statNameSpeed,
    statUrlSpeed,
  );

  static final List<PokemonStatDataModel> pokemonStats = [
    statHp,
    statAttack,
    statDefense,
    statSpecialAttack,
    statSpecialDefense,
    statSpeed,
  ];
}
