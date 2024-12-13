import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/src/common/text_theme.dart';
import 'package:presentation/src/common/utils/extensions.dart';
import 'package:presentation/src/common/widgets/back_button.dart';
import 'package:presentation/src/common/widgets/pokemon_image_with_background.dart';
import 'package:presentation/src/common/widgets/pokemon_types_widget.dart';
import 'package:presentation/src/pokedex/widgets/pokedex_header_widget.dart';
import 'package:presentation/src/pokemon/models/pokemon_presentation_model.dart';
import 'package:presentation/src/pokemon/widgets/label_value_column.dart';

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
    return SafeArea(
      child: BlocConsumer<PokemonBloc, BaseState>(
        bloc: _bloc,
        listener: (context, state) {},
        builder: (context, state) => RefreshIndicator(
          color: context.theme.colorScheme.primary,
          backgroundColor: context.theme.colorScheme.onPrimary,
          onRefresh: onRefresh,
          child: getPageState(state),
        ),
      ),
    );
  }

  Future<void> onRefresh() async {
    _bloc.onRefresh(widget.pokemonId);
  }

  Widget getPageState(BaseState state) => switch (state) {
        PokemonSuccessState() => _buildSuccessPage(state.pokemon),
        ExistingPokemonLoadingState() =>
          _buildSuccessPage(state.pokemon),
        LoadingState() => buildLoadingPage(),
        BaseState() => buildErrorPage(),
      };

  Widget buildLoadingPage() =>
      buildRefreshablePageWithBackground(
        title: buildPokedexHeader(
            icon: PixelBackButton(onTap: goBack), title: buildShimmer()),
        body: LoadingPage(),
        context: context,
      );

  Widget buildErrorPage() => buildRefreshablePageWithBackground(
        title: buildPokedexHeader(icon: PixelBackButton(onTap: goBack)),
        body: ErrorPage(),
        context: context,
      );

  Widget _buildSuccessPage(PokemonPresentationModel pokemon) =>
      buildRefreshablePageWithBackground(
        title: buildPokedexHeader(
            icon: PixelBackButton(onTap: goBack),
            title: buildPageTitle(theme: context.theme, title: pokemon.name)),
        context: context,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: _buildSections(pokemon),
          ),
        ),
      );

  Column _buildSections(PokemonPresentationModel pokemon) =>
      Column(
        children: [
          buildPokemonImageWithBackground(
            _bloc.state,
            pokemon.artworkUrl,
            context,
            pokemon.name,
            size: 250,
          ),
          _buildPokemonName(pokemon),
          buildPokemonTypes(
              types: pokemon.types,
              theme: context.theme,
              alignment: MainAxisAlignment.center),
          _buildSection("Base Stats", _buildStats(pokemon)),
          _buildSection("EV Yield", _buildEvYieldSection(pokemon)),
        ],
      );

  Widget _buildSection(String title, Widget child) =>
      PokemonSection(
        backgroundColor: context.theme.colorScheme.primary,
        titleBackgroundColor: context.theme.colorScheme.secondary,
        titleTextStyle: context.theme.textTheme.titleMediumWhite,
        title: title,
        child: child,
      );

  Widget _buildPokemonName(PokemonPresentationModel pokemon) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${pokemon.nationalDexNumber}: ",
            style: context.theme.textTheme.titleMedium,
          ),
          Text(
            pokemon.name,
            style: context.theme.textTheme.titleMedium,
          ),
        ],
      );

  Widget _buildStats(PokemonPresentationModel pokemon) {
    var theme = context.theme;
    return pokemon.statsNotNull
          ? Semantics(
              label:
                  "Base stats: HP: ${pokemon.hp}, attack: ${pokemon.attack}, defense: ${pokemon.defense}, special attack: ${pokemon.specialAttack}, special defense: ${pokemon.specialDefense}, speed: ${pokemon.speed}",
              child: Column(
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
              ),
            )
          : _bloc.state is ExistingPokemonLoadingState
              ? buildShimmer()
              : ErrorPage(textStyle: theme.textTheme.labelMediumWhite);
  }

  Widget _buildEvYieldSection(PokemonPresentationModel pokemon) =>
      pokemon.statsNotNull
          ? Semantics(
              label:
                  "EV Yield: HP: ${pokemon.hpEvYield}, attack: ${pokemon.attackEvYield}, defense: ${pokemon.defenseEvYield}, special attack: ${pokemon.specialAttackEvYield}, special defense: ${pokemon.specialDefenseEvYield}, speed: ${pokemon.speedEvYield}",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildEvYield(hpLabel, pokemon.hpEvYield),
                  _buildEvYield(attackShortLabel, pokemon.attackEvYield),
                  _buildEvYield(defenseShortLabel, pokemon.defenseEvYield),
                  _buildEvYield(specialAttackLabel, pokemon.specialAttackEvYield),
                  _buildEvYield(specialDefenseLabel, pokemon.specialDefenseEvYield),
                  _buildEvYield(speedShortLabel, pokemon.speedEvYield),
                ],
              ),
            )
          : _bloc.state is ExistingPokemonLoadingState
              ? buildShimmer()
              : ErrorPage(textStyle: context.theme.textTheme.labelMediumWhite);

  Widget _buildEvYield(String label, int? value) =>
      LabelValueColumn(
        valueBackgroundColor: context.theme.colorScheme.secondary,
        valueTextStyle: context.theme.textTheme.labelMediumWhite,
        labelBackgroundColor: Colors.transparent,
        labelTextStyle: context.theme.textTheme.labelSmallWhite,
        label: label,
        value: value?.toString() ?? "0",
      );

  goBack() {
    Navigator.pop(context);
  }
}
