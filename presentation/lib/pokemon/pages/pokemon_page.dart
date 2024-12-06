import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/common/text_theme.dart';
import 'package:presentation/common/widgets/animated_bar.dart';
import 'package:presentation/common/widgets/pokemon_image_with_background.dart';
import 'package:presentation/common/widgets/pokemon_types_widget.dart';
import 'package:presentation/pokedex/widgets/pokedex_header_widget.dart';
import 'package:presentation/pokemon/models/pokemon_presentation_model.dart';

import '../../common/bloc/base_state.dart';
import '../../common/pages/error_page.dart';
import '../../common/pages/loading_page.dart';
import '../../common/widgets/header_title.dart';
import '../../common/widgets/refresh_page_with_background.dart';
import '../../common/widgets/shimmer.dart';
import '../../injections.dart';
import '../bloc/pokemon_bloc.dart';

class PokemonPage extends StatefulWidget {
  final int pokemonId;

  const PokemonPage({super.key, required this.pokemonId});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final PokemonBloc _bloc = PokemonBloc(getIt(), getIt());

  @override
  void initState() {
    getPokemon(widget.pokemonId);
    super.initState();
  }

  void getPokemon(int id) {
    _bloc.add(GetPokemonEvent(id));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: BlocConsumer<PokemonBloc, BaseState>(
        bloc: _bloc,
        listener: (context, state) {},
        builder: (context, state) => RefreshIndicator(
            color: theme.colorScheme.primary,
            backgroundColor: theme.colorScheme.onPrimary,
            onRefresh: onRefresh,
            child: getPageState(state, theme)),
      ),
    );
  }

  Future<void> onRefresh() async {
    getPokemon(widget.pokemonId);
  }

  Widget getPageState(BaseState state, ThemeData theme) => switch (state) {
        PokemonSuccessState() => _buildSuccessPage(theme, state.pokemon),
        LoadingState() => buildLoadingPage(theme),
        BaseState() => buildErrorPage(theme),
      };

  Widget buildLoadingPage(ThemeData theme) =>
      buildRefreshablePageWithBackground(
        title: buildShimmer(),
        body: LoadingPage(),
        theme: theme,
        context: context,
      );

  Widget buildErrorPage(ThemeData theme) => buildRefreshablePageWithBackground(
        body: ErrorPage(),
        theme: theme,
        context: context,
      );

  Widget _buildSuccessPage(ThemeData theme, PokemonPresentationModel pokemon) =>
      buildRefreshablePageWithBackground(
        title: buildPokedexHeader(
            title: buildPageTitle(
                theme: theme, title: pokemon.name, leftPadding: 50)),
        theme: theme,
        context: context,
        body: Center(
          child: Column(
            children: [
              buildPokemonImageWithBackground(
                _bloc.state,
                pokemon.imageUrl,
                theme,
                context,
                size: 250,
              ),
              _buildPokemonName(pokemon, theme),
              buildPokemonTypes(
                  types: pokemon.types,
                  theme: theme,
                  alignment: MainAxisAlignment.center),
              _buildSection(theme, _buildPokemonStats(theme, pokemon)),
            ],
          ),
        ),
      );

  Text _buildPokemonName(PokemonPresentationModel pokemon, ThemeData theme) =>
      Text(
        pokemon.name,
        style: theme.textTheme.titleMedium,
      );

  Padding _buildSection(ThemeData theme, Widget child) => Padding(
        padding: EdgeInsets.all(16),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: child,
        ),
      );

  Widget _buildPokemonStats(
          ThemeData theme, PokemonPresentationModel pokemon) =>
      Column(
        children: [
          Text("Base Stats", style: theme.textTheme.titleMedium),
          buildPokemonStatRow(theme, "HP", pokemon.hp),
          buildPokemonStatRow(theme, "Attack", pokemon.attack),
          buildPokemonStatRow(theme, "Defense", pokemon.defense),
          buildPokemonStatRow(theme, "Sp. Attack", pokemon.specialAttack),
          buildPokemonStatRow(theme, "Sp. Defense", pokemon.specialDefense),
          buildPokemonStatRow(theme, "Speed", pokemon.speed),
        ],
      );

  Row buildPokemonStatRow(ThemeData theme, String label, int? value) => Row(
        children: [
          SizedBox(
            width: 130,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(label, style: theme.textTheme.labelMedium),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                AnimatedBar(targetValue: value ?? 0, height: 30),
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(value.toString(),
                      style: theme.textTheme.labelMediumWhite),
                ),
              ],
            ),
          )
        ],
      );
}
