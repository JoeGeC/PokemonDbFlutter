import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/common/asset_constants.dart';
import 'package:presentation/common/text_theme.dart';
import 'package:presentation/common/widgets/back_button.dart';
import 'package:presentation/common/widgets/pokemon_image_with_background.dart';
import 'package:presentation/common/widgets/pokemon_types_widget.dart';
import 'package:presentation/pokedex/widgets/pokedex_header_widget.dart';
import 'package:presentation/pokemon/models/pokemon_presentation_model.dart';
import 'package:presentation/pokemon/widgets/label_value_column.dart';

import '../../common/bloc/base_state.dart';
import '../../common/pages/error_page.dart';
import '../../common/pages/loading_page.dart';
import '../../common/widgets/header_title.dart';
import '../../common/widgets/refresh_page_with_background.dart';
import '../../common/widgets/shimmer.dart';
import '../../injections.dart';
import '../bloc/pokemon_bloc.dart';
import '../widgets/pokemon_section.dart';
import '../widgets/pokemon_stats.dart';

class PokemonPage extends StatefulWidget {
  final int pokemonId;

  const PokemonPage({super.key, required this.pokemonId});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  final PokemonBloc _bloc = PokemonBloc(getIt(), getIt());
  final String hpLabel = "HP";
  final String attackLabel = "Attack";
  final String attackShortLabel = "Atk";
  final String defenseLabel = "Defense";
  final String defenseShortLabel = "Def";
  final String specialAttackLabel = "Sp.Atk";
  final String specialAttackTwoLineLabel = "Sp.\nAtk";
  final String specialDefenseLabel = "Sp.Def";
  final String specialDefenseTwoLineLabel = "Sp.\nDef";
  final String speedLabel = "Speed";
  final String speedShortLabel = "Spd";

  @override
  void initState() {
    _bloc.add(GetPokemonEvent(widget.pokemonId));
    super.initState();
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
          child: getPageState(state, theme),
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    _bloc.onRefresh(widget.pokemonId);
  }

  Widget getPageState(BaseState state, ThemeData theme) => switch (state) {
        PokemonSuccessState() => _buildSuccessPage(theme, state.pokemon),
        ExistingPokemonLoadingState() =>
          _buildSuccessPage(theme, state.pokemon),
        LoadingState() => buildLoadingPage(theme),
        BaseState() => buildErrorPage(theme),
      };

  Widget buildLoadingPage(ThemeData theme) =>
      buildRefreshablePageWithBackground(
        title: buildPokedexHeader(icon: PixelBackButton(onTap: goBack), title: buildShimmer()),
        body: LoadingPage(),
        theme: theme,
        context: context,
      );

  Widget buildErrorPage(ThemeData theme) => buildRefreshablePageWithBackground(
        title: buildPokedexHeader(icon: PixelBackButton(onTap: goBack)),
        body: ErrorPage(),
        theme: theme,
        context: context,
      );

  Widget _buildSuccessPage(ThemeData theme, PokemonPresentationModel pokemon) =>
      buildRefreshablePageWithBackground(
        title: buildPokedexHeader(
            icon: PixelBackButton(onTap: goBack),
            title: buildPageTitle(theme: theme, title: pokemon.name)),
        theme: theme,
        context: context,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: _buildSections(pokemon, theme),
          ),
        ),
      );

  Column _buildSections(PokemonPresentationModel pokemon, ThemeData theme) =>
      Column(
        children: [
          buildPokemonImageWithBackground(
            _bloc.state,
            pokemon.artworkUrl,
            theme,
            context,
            size: 250,
          ),
          _buildPokemonName(pokemon, theme),
          buildPokemonTypes(
              types: pokemon.types,
              theme: theme,
              alignment: MainAxisAlignment.center),
          _buildSection(theme, "Base Stats", _buildStats(theme, pokemon)),
          _buildSection(
              theme, "EV Yield", _buildEvYieldSection(theme, pokemon)),
        ],
      );

  Widget _buildSection(ThemeData theme, String title, Widget child) =>
      PokemonSection(
        backgroundColor: theme.colorScheme.primary,
        titleBackgroundColor: theme.colorScheme.secondary,
        titleTextStyle: theme.textTheme.titleMediumWhite,
        title: title,
        child: child,
      );

  Widget _buildPokemonName(PokemonPresentationModel pokemon, ThemeData theme) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${pokemon.nationalDexNumber}: ",
            style: theme.textTheme.titleMedium,
          ),
          Text(
            pokemon.name,
            style: theme.textTheme.titleMedium,
          ),
        ],
      );

  Widget _buildStats(ThemeData theme, PokemonPresentationModel pokemon) =>
      pokemon.statsNotNull
          ? Column(
              children: [
                buildPokemonStatRow(theme, hpLabel, pokemon.hp),
                buildPokemonStatRow(theme, attackLabel, pokemon.attack),
                buildPokemonStatRow(theme, defenseLabel, pokemon.defense),
                buildPokemonStatRow(
                    theme, specialAttackLabel, pokemon.specialAttack),
                buildPokemonStatRow(
                    theme, specialDefenseLabel, pokemon.specialDefense),
                buildPokemonStatRow(theme, speedLabel, pokemon.speed),
              ],
            )
          : _bloc.state is ExistingPokemonLoadingState
              ? buildShimmer()
              : ErrorPage(textStyle: theme.textTheme.labelMediumWhite);

  Widget _buildEvYieldSection(
          ThemeData theme, PokemonPresentationModel pokemon) =>
      pokemon.statsNotNull
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildEvYield(theme, hpLabel, pokemon.hpEvYield),
                _buildEvYield(theme, attackShortLabel, pokemon.attackEvYield),
                _buildEvYield(theme, defenseShortLabel, pokemon.defenseEvYield),
                _buildEvYield(
                    theme, specialAttackLabel, pokemon.specialAttackEvYield),
                _buildEvYield(
                    theme, specialDefenseLabel, pokemon.specialDefenseEvYield),
                _buildEvYield(theme, speedShortLabel, pokemon.speedEvYield),
              ],
            )
          : _bloc.state is ExistingPokemonLoadingState
              ? buildShimmer()
              : ErrorPage(textStyle: theme.textTheme.labelMediumWhite);

  Widget _buildEvYield(ThemeData theme, String label, int? value) =>
      LabelValueColumn(
        valueBackgroundColor: theme.colorScheme.secondary,
        valueTextStyle: theme.textTheme.labelMediumWhite,
        labelBackgroundColor: Colors.transparent,
        labelTextStyle: theme.textTheme.labelSmallWhite,
        label: label,
        value: value?.toString() ?? "0",
      );

  goBack() {
    Navigator.pop(context);
  }
}
