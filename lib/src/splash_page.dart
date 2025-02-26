import 'package:flutter/material.dart';
import 'package:pokemon_db/src/injections.dart';
import 'package:presentation/presentation.dart';
import 'package:sqflite/sqlite_api.dart';

import 'asset_constants.dart';

class SplashPage extends StatefulWidget {
  final Database? database;

  const SplashPage({this.database, super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) => FutureBuilder<void>(
        future: _setupDependencies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return const PokedexPage();
          }
          return _buildSplashPage();
        },
      );

  Scaffold _buildSplashPage() => Scaffold(
        body: Center(
          child: Image.asset(
            AssetConstants.appIcon,
            width: 150,
            height: 150,
          ),
        ),
      );

  Future<void> _setupDependencies() async {
    final localizations = PresentationLocalizations.of(context);
    await setupDependencies(localizations, database: widget.database);
  }
}