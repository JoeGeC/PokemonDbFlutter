import 'package:flutter/material.dart';
import 'package:pokemon_db/src/injections.dart';
import 'package:pokemon_db/src/theme/colors.dart';
import 'package:presentation/presentation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Pokemon DB',
        themeMode: ThemeMode.system,
        theme: lightModeTheme(),
        darkTheme: darkModeTheme(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: PokedexPage(),
      );

  lightModeTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: getTextTheme(lightColorScheme),
        highlightColor: lightColorScheme.secondary,
      );

  darkModeTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        textTheme: getTextTheme(darkColorScheme),
        highlightColor: darkColorScheme.secondary,
      );

  getTextTheme(ColorScheme colorScheme) => TextTheme(
        headlineMedium: headlineTextStyle(colorScheme).copyWith(fontSize: 60),
        headlineSmall: headlineTextStyle(colorScheme).copyWith(fontSize: 50),
        titleMedium: baseTextStyle(colorScheme).copyWith(fontSize: 40),
        labelMedium: baseTextStyle(colorScheme).copyWith(fontSize: 30),
        labelSmall: baseTextStyle(colorScheme).copyWith(
            fontSize: 20, shadows: smallTextShadow(colorScheme), height: .95),
      );
}
