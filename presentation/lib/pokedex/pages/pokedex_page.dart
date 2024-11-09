import 'package:flutter/material.dart';
import 'package:presentation/pokedex/bloc/pokedex_bloc.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  final PokedexBloc _bloc = PokedexBloc(pokedexUseCase: getIt<PokedexUseCase>());

  @override
  Widget build(BuildContext context) {

  }
}