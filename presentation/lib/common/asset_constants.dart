class AssetConstants {
  static String pokemonFallback = 'assets/pokemon_fallback.png';
  static String pokedexHeaderBackground = 'assets/pokedex_header_background.png';
  static String missingno = 'assets/missingno.png';
  static String whiteArrow = 'assets/arrow_white.svg';
  static String blackArrow = 'assets/arrow_black.svg';

  static String pokeballBackground(bool isDarkMode) => isDarkMode
      ? 'assets/pokeball_background_dark.svg'
      : 'assets/pokeball_background.svg';

  static String pokedexBackground(bool isDarkMode) => isDarkMode
      ? 'assets/pokedex_background_dark.png'
      : 'assets/pokedex_background.png';

  static String drawerBackground(bool isDarkMode) => isDarkMode
      ? 'assets/drawer_background_dark.png'
      : 'assets/pokedex_background.png';
}
