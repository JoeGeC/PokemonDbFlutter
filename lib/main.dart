import 'package:flutter/material.dart';
import 'package:pokemon_db/injections.dart';
import 'package:pokemon_db/theme/colors.dart';
import 'package:presentation/presentation.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon DB',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: getTextTheme(lightColorScheme),
        highlightColor: lightColorScheme.secondary,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
        textTheme: getTextTheme(darkColorScheme),
        highlightColor: darkColorScheme.secondary,
      ),
      home: PokedexPage(),
    );
  }

  getTextTheme(ColorScheme colorScheme) => TextTheme(
        headlineMedium: headlineTextStyle(colorScheme).copyWith(fontSize: 60),
        headlineSmall: headlineTextStyle(colorScheme).copyWith(fontSize: 50),
        titleMedium: baseTextStyle(colorScheme).copyWith(fontSize: 40),
        labelMedium: baseTextStyle(colorScheme).copyWith(fontSize: 30),
        labelSmall: baseTextStyle(colorScheme).copyWith(
            fontSize: 20, shadows: smallTextShadow(colorScheme), height: .95),
      );
}
