import 'package:flutter/material.dart';
import 'package:pokemon_db/injections.dart';
import 'package:pokemon_db/theme/colors.dart';
import 'package:pokemon_db/theme/text_styles.dart';
import 'package:presentation/common/text_theme.dart';
import 'package:presentation/pokedex/pages/pokedex_page.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        textTheme: initialiseTextTheme(),
      ),
      home: PokedexPage(),
    );
  }

  TextTheme initialiseTextTheme() {
    var textTheme = TextTheme(
          headlineMedium: headlineMedium,
          titleMedium: titleMedium,
          labelSmall: labelSmall,
        );
    CustomTextTheme().initialize(textTheme);
    return textTheme;
  }
}