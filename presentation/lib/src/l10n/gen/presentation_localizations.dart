import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'presentation_localizations_en.dart';
import 'presentation_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of PresentationLocalizations
/// returned by `PresentationLocalizations.of(context)`.
///
/// Applications need to include `PresentationLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/presentation_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: PresentationLocalizations.localizationsDelegates,
///   supportedLocales: PresentationLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the PresentationLocalizations.supportedLocales
/// property.
abstract class PresentationLocalizations {
  PresentationLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static PresentationLocalizations of(BuildContext context) {
    return Localizations.of<PresentationLocalizations>(context, PresentationLocalizations)!;
  }

  static const LocalizationsDelegate<PresentationLocalizations> delegate = _PresentationLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong :('**
  String get somethingWentWrong;

  /// No description provided for @emptyError.
  ///
  /// In en, this message translates to:
  /// **'Empty! :('**
  String get emptyError;

  /// No description provided for @backButton.
  ///
  /// In en, this message translates to:
  /// **'Back button'**
  String get backButton;

  /// No description provided for @openNavigationMenu.
  ///
  /// In en, this message translates to:
  /// **'Open navigation menu'**
  String get openNavigationMenu;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get image;

  /// No description provided for @pokemonTypes.
  ///
  /// In en, this message translates to:
  /// **'Pokemon types: '**
  String get pokemonTypes;

  /// No description provided for @national.
  ///
  /// In en, this message translates to:
  /// **'National'**
  String get national;

  /// No description provided for @kanto.
  ///
  /// In en, this message translates to:
  /// **'Kanto'**
  String get kanto;

  /// No description provided for @johto.
  ///
  /// In en, this message translates to:
  /// **'Johto'**
  String get johto;

  /// No description provided for @hoenn.
  ///
  /// In en, this message translates to:
  /// **'Hoenn'**
  String get hoenn;

  /// No description provided for @sinnoh.
  ///
  /// In en, this message translates to:
  /// **'Sinnoh'**
  String get sinnoh;

  /// No description provided for @unova.
  ///
  /// In en, this message translates to:
  /// **'Unova'**
  String get unova;

  /// No description provided for @ransei.
  ///
  /// In en, this message translates to:
  /// **'Ransei'**
  String get ransei;

  /// No description provided for @kalos.
  ///
  /// In en, this message translates to:
  /// **'Kalos'**
  String get kalos;

  /// No description provided for @alola.
  ///
  /// In en, this message translates to:
  /// **'Alola'**
  String get alola;

  /// No description provided for @melemele.
  ///
  /// In en, this message translates to:
  /// **'Melemele'**
  String get melemele;

  /// No description provided for @akala.
  ///
  /// In en, this message translates to:
  /// **'Akala'**
  String get akala;

  /// No description provided for @ulaula.
  ///
  /// In en, this message translates to:
  /// **'Ulaula'**
  String get ulaula;

  /// No description provided for @poni.
  ///
  /// In en, this message translates to:
  /// **'Poni'**
  String get poni;

  /// No description provided for @galar.
  ///
  /// In en, this message translates to:
  /// **'Galar'**
  String get galar;

  /// No description provided for @hisui.
  ///
  /// In en, this message translates to:
  /// **'Hisui'**
  String get hisui;

  /// No description provided for @paldea.
  ///
  /// In en, this message translates to:
  /// **'Paldea'**
  String get paldea;

  /// No description provided for @rby.
  ///
  /// In en, this message translates to:
  /// **'RBY'**
  String get rby;

  /// No description provided for @gsc.
  ///
  /// In en, this message translates to:
  /// **'GSC'**
  String get gsc;

  /// No description provided for @rse.
  ///
  /// In en, this message translates to:
  /// **'RSE'**
  String get rse;

  /// No description provided for @frlg.
  ///
  /// In en, this message translates to:
  /// **'FRLG'**
  String get frlg;

  /// No description provided for @dp.
  ///
  /// In en, this message translates to:
  /// **'DP'**
  String get dp;

  /// No description provided for @pt.
  ///
  /// In en, this message translates to:
  /// **'Pt'**
  String get pt;

  /// No description provided for @hgss.
  ///
  /// In en, this message translates to:
  /// **'HGSS'**
  String get hgss;

  /// No description provided for @bw.
  ///
  /// In en, this message translates to:
  /// **'BW'**
  String get bw;

  /// No description provided for @b2w2.
  ///
  /// In en, this message translates to:
  /// **'B2W2'**
  String get b2w2;

  /// No description provided for @xy.
  ///
  /// In en, this message translates to:
  /// **'XY'**
  String get xy;

  /// No description provided for @oras.
  ///
  /// In en, this message translates to:
  /// **'ORAS'**
  String get oras;

  /// No description provided for @sm.
  ///
  /// In en, this message translates to:
  /// **'SM'**
  String get sm;

  /// No description provided for @usum.
  ///
  /// In en, this message translates to:
  /// **'USUM'**
  String get usum;

  /// No description provided for @lgo.
  ///
  /// In en, this message translates to:
  /// **'LGo'**
  String get lgo;

  /// No description provided for @swsh.
  ///
  /// In en, this message translates to:
  /// **'SwSh'**
  String get swsh;

  /// No description provided for @bdsp.
  ///
  /// In en, this message translates to:
  /// **'BDSP'**
  String get bdsp;

  /// No description provided for @pla.
  ///
  /// In en, this message translates to:
  /// **'PLA'**
  String get pla;

  /// No description provided for @sv.
  ///
  /// In en, this message translates to:
  /// **'SV'**
  String get sv;

  /// No description provided for @lza.
  ///
  /// In en, this message translates to:
  /// **'LZA'**
  String get lza;

  /// No description provided for @conq.
  ///
  /// In en, this message translates to:
  /// **'Conq'**
  String get conq;

  /// No description provided for @sunMoon.
  ///
  /// In en, this message translates to:
  /// **'Sun & Moon'**
  String get sunMoon;

  /// No description provided for @ultraSunUltraMoon.
  ///
  /// In en, this message translates to:
  /// **'Ultra Sun & Ultra Moon'**
  String get ultraSunUltraMoon;

  /// No description provided for @redBlueYellow.
  ///
  /// In en, this message translates to:
  /// **'Red, Blue & Yellow'**
  String get redBlueYellow;

  /// No description provided for @fireRedLeafGreen.
  ///
  /// In en, this message translates to:
  /// **'FireRed & LeafGreen'**
  String get fireRedLeafGreen;

  /// No description provided for @letsGoPikachuEevee.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Go Pikachu & Eevee'**
  String get letsGoPikachuEevee;

  /// No description provided for @goldSilverCrystal.
  ///
  /// In en, this message translates to:
  /// **'Gold, Silver & Crystal'**
  String get goldSilverCrystal;

  /// No description provided for @rubySapphireEmerald.
  ///
  /// In en, this message translates to:
  /// **'Ruby, Sapphire & Emerald'**
  String get rubySapphireEmerald;

  /// No description provided for @diamondPearl.
  ///
  /// In en, this message translates to:
  /// **'Diamond & Pearl'**
  String get diamondPearl;

  /// No description provided for @brilliantDiamondShiningPearl.
  ///
  /// In en, this message translates to:
  /// **'Brilliant Diamond & Shining Pearl'**
  String get brilliantDiamondShiningPearl;

  /// No description provided for @platinum.
  ///
  /// In en, this message translates to:
  /// **'Platinum'**
  String get platinum;

  /// No description provided for @heartGoldSoulSilver.
  ///
  /// In en, this message translates to:
  /// **'HeartGold & SoulSilver'**
  String get heartGoldSoulSilver;

  /// No description provided for @blackWhite.
  ///
  /// In en, this message translates to:
  /// **'Black & White'**
  String get blackWhite;

  /// No description provided for @black2White2.
  ///
  /// In en, this message translates to:
  /// **'Black 2 & White 2'**
  String get black2White2;

  /// No description provided for @conquest.
  ///
  /// In en, this message translates to:
  /// **'Conquest'**
  String get conquest;

  /// No description provided for @central.
  ///
  /// In en, this message translates to:
  /// **'Central'**
  String get central;

  /// No description provided for @coastal.
  ///
  /// In en, this message translates to:
  /// **'Coastal'**
  String get coastal;

  /// No description provided for @mountain.
  ///
  /// In en, this message translates to:
  /// **'Mountain'**
  String get mountain;

  /// No description provided for @omegaRubyAlphaSapphire.
  ///
  /// In en, this message translates to:
  /// **'Omega Ruby & Alpha Sapphire'**
  String get omegaRubyAlphaSapphire;

  /// No description provided for @swordShield.
  ///
  /// In en, this message translates to:
  /// **'Sword & Shield'**
  String get swordShield;

  /// No description provided for @isleOfArmor.
  ///
  /// In en, this message translates to:
  /// **'Isle of Armor'**
  String get isleOfArmor;

  /// No description provided for @crownTundra.
  ///
  /// In en, this message translates to:
  /// **'Crown Tundra'**
  String get crownTundra;

  /// No description provided for @legendsArceus.
  ///
  /// In en, this message translates to:
  /// **'Legends Arceus'**
  String get legendsArceus;

  /// No description provided for @scarlettViolet.
  ///
  /// In en, this message translates to:
  /// **'Scarlett & Violet'**
  String get scarlettViolet;

  /// No description provided for @theTealMask.
  ///
  /// In en, this message translates to:
  /// **'The Teal Mask'**
  String get theTealMask;

  /// No description provided for @theIndigoDisk.
  ///
  /// In en, this message translates to:
  /// **'The Indigo Disk'**
  String get theIndigoDisk;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @fire.
  ///
  /// In en, this message translates to:
  /// **'Fire'**
  String get fire;

  /// No description provided for @water.
  ///
  /// In en, this message translates to:
  /// **'Water'**
  String get water;

  /// No description provided for @electric.
  ///
  /// In en, this message translates to:
  /// **'Electric'**
  String get electric;

  /// No description provided for @grass.
  ///
  /// In en, this message translates to:
  /// **'Grass'**
  String get grass;

  /// No description provided for @ice.
  ///
  /// In en, this message translates to:
  /// **'Ice'**
  String get ice;

  /// No description provided for @fighting.
  ///
  /// In en, this message translates to:
  /// **'Fighting'**
  String get fighting;

  /// No description provided for @poison.
  ///
  /// In en, this message translates to:
  /// **'Poison'**
  String get poison;

  /// No description provided for @ground.
  ///
  /// In en, this message translates to:
  /// **'Ground'**
  String get ground;

  /// No description provided for @flying.
  ///
  /// In en, this message translates to:
  /// **'Flying'**
  String get flying;

  /// No description provided for @psychic.
  ///
  /// In en, this message translates to:
  /// **'Psychic'**
  String get psychic;

  /// No description provided for @bug.
  ///
  /// In en, this message translates to:
  /// **'Bug'**
  String get bug;

  /// No description provided for @rock.
  ///
  /// In en, this message translates to:
  /// **'Rock'**
  String get rock;

  /// No description provided for @ghost.
  ///
  /// In en, this message translates to:
  /// **'Ghost'**
  String get ghost;

  /// No description provided for @dragon.
  ///
  /// In en, this message translates to:
  /// **'Dragon'**
  String get dragon;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @steel.
  ///
  /// In en, this message translates to:
  /// **'Steel'**
  String get steel;

  /// No description provided for @fairy.
  ///
  /// In en, this message translates to:
  /// **'Fairy'**
  String get fairy;

  /// No description provided for @baseStats.
  ///
  /// In en, this message translates to:
  /// **'Base Stats'**
  String get baseStats;

  /// No description provided for @evYield.
  ///
  /// In en, this message translates to:
  /// **'EV Yield'**
  String get evYield;

  /// No description provided for @hp.
  ///
  /// In en, this message translates to:
  /// **'HP'**
  String get hp;

  /// No description provided for @attack.
  ///
  /// In en, this message translates to:
  /// **'Attack'**
  String get attack;

  /// No description provided for @attackShort.
  ///
  /// In en, this message translates to:
  /// **'Atk'**
  String get attackShort;

  /// No description provided for @defense.
  ///
  /// In en, this message translates to:
  /// **'Defense'**
  String get defense;

  /// No description provided for @defenseShort.
  ///
  /// In en, this message translates to:
  /// **'Def'**
  String get defenseShort;

  /// No description provided for @specialAttack.
  ///
  /// In en, this message translates to:
  /// **'Special Attack'**
  String get specialAttack;

  /// No description provided for @specialAttackShort.
  ///
  /// In en, this message translates to:
  /// **'Sp.Atk'**
  String get specialAttackShort;

  /// No description provided for @specialAttackTwoLine.
  ///
  /// In en, this message translates to:
  /// **'Sp.\nAtk'**
  String get specialAttackTwoLine;

  /// No description provided for @specialDefense.
  ///
  /// In en, this message translates to:
  /// **'Special Defense'**
  String get specialDefense;

  /// No description provided for @specialDefenseShort.
  ///
  /// In en, this message translates to:
  /// **'Sp.Def'**
  String get specialDefenseShort;

  /// No description provided for @specialDefenseTwoLine.
  ///
  /// In en, this message translates to:
  /// **'Sp.\nDef'**
  String get specialDefenseTwoLine;

  /// No description provided for @speed.
  ///
  /// In en, this message translates to:
  /// **'Speed'**
  String get speed;

  /// No description provided for @speedShort.
  ///
  /// In en, this message translates to:
  /// **'Spd'**
  String get speedShort;

  /// No description provided for @zero.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get zero;

  /// No description provided for @pokedex.
  ///
  /// In en, this message translates to:
  /// **'Pokedex'**
  String get pokedex;

  /// No description provided for @pokedexEntryNumber.
  ///
  /// In en, this message translates to:
  /// **'Pokedex entry number'**
  String get pokedexEntryNumber;

  /// No description provided for @pokemonName.
  ///
  /// In en, this message translates to:
  /// **'Pokemon Name'**
  String get pokemonName;
}

class _PresentationLocalizationsDelegate extends LocalizationsDelegate<PresentationLocalizations> {
  const _PresentationLocalizationsDelegate();

  @override
  Future<PresentationLocalizations> load(Locale locale) {
    return SynchronousFuture<PresentationLocalizations>(lookupPresentationLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_PresentationLocalizationsDelegate old) => false;
}

PresentationLocalizations lookupPresentationLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return PresentationLocalizationsEn();
    case 'es': return PresentationLocalizationsEs();
  }

  throw FlutterError(
    'PresentationLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
