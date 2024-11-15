import 'package:flutter/material.dart';
import 'package:pokemon_db/injections.dart';
import 'package:pokemon_db/theme/colors.dart';
import 'package:pokemon_db/theme/text_styles.dart';
import 'package:presentation/pokedex/pages/pokedex_page.dart';

Future<void> main() async {
  await setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon DB',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: TextTheme(
          labelMedium: labelMedium,
          titleMedium: titleMedium,
        ),
      ),
      home: const PokedexPage(),
    );
  }
}
