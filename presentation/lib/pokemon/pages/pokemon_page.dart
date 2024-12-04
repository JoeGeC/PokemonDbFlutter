import 'package:flutter/cupertino.dart';

class PokemonPage extends StatelessWidget{
  final int pokemonId;

  const PokemonPage({super.key, required this.pokemonId});

  @override
  Widget build(BuildContext context) {
    return Text(pokemonId.toString());
  }

}