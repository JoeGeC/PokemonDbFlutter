import 'package:flutter/material.dart';
import 'package:pokemon_db/injections.dart';
import 'package:pokemon_db/text_styles.dart';
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: TextTheme(
          labelMedium: labelMedium,
          titleMedium: titleMedium,
        ),
      ),
      home: const PokedexPage(),
    );
  }
}
