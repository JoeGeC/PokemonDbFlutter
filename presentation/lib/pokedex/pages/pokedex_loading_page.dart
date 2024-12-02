import 'package:flutter/cupertino.dart';

import '../../common/widgets/shimmer.dart';

class PokedexLoadingPage extends StatelessWidget {
  final double _pokemonImageSize;

  const PokedexLoadingPage(this._pokemonImageSize, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _buildPokemonLoadingWidgets(4),
      ),
    );
  }

  List<Widget> _buildPokemonLoadingWidgets(int amount) => List.generate(
      amount, (_) => _pokemonEntryLoadingWidget(imageSize: _pokemonImageSize),);

  Widget _pokemonEntryLoadingWidget({ double imageSize = 100 }) =>
      Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildShimmer(height: _pokemonImageSize,
                width: _pokemonImageSize,
                borderRadius: 100),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildShimmer(height: 40, width: 200),
                  const SizedBox(height: 20),
                  buildShimmer(height: 40, width: 150),
                ],
              ),
            ),
          ],
        ),
      );

}