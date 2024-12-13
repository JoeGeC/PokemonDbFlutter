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
        ExistingPokemonLoadingState() => _buildSuccessPage(state.pokemon),
        LoadingState() => buildLoadingPage(),
        BaseState() => buildErrorPage(),
      };

  Widget buildLoadingPage() => buildRefreshablePageWithBackground(
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

  Column _buildSections(PokemonPresentationModel pokemon) => Column(
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
              context: context,
              alignment: MainAxisAlignment.center),
          _buildSection(context.localizations.baseStats, _buildStats(pokemon)),
          _buildSection(
              context.localizations.evYield, _buildEvYieldSection(pokemon)),
        ],
      );

  Widget _buildSection(String title, Widget child) => PokemonSection(
        backgroundColor: context.theme.colorScheme.primary,
        titleBackgroundColor: context.theme.colorScheme.secondary,
        titleTextStyle: context.theme.textTheme.titleMediumWhite,
        title: title,
        child: child,
      );

  Widget _buildPokemonName(PokemonPresentationModel pokemon) => Row(
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
    var localizations = context.localizations;
    return pokemon.statsNotNull
        ? Semantics(
            label:
                "${localizations.baseStats}: ${localizations.hp}: ${pokemon.hp}, ${localizations.attack}: ${pokemon.attack}, ${localizations.defense}: ${pokemon.defense}, ${localizations.specialAttack}: ${pokemon.specialAttack}, ${localizations.specialDefense}: ${pokemon.specialDefense}, ${localizations.speed}: ${pokemon.speed}",
            child: Column(
              children: [
                buildPokemonStatRow(theme, localizations.hp, pokemon.hp),
                buildPokemonStatRow(theme, localizations.attack, pokemon.attack),
                buildPokemonStatRow(theme, localizations.defense, pokemon.defense),
                buildPokemonStatRow(
                    theme, localizations.specialAttackShort, pokemon.specialAttack),
                buildPokemonStatRow(
                    theme, localizations.specialDefenseShort, pokemon.specialDefense),
                buildPokemonStatRow(theme, localizations.speed, pokemon.speed),
              ],
            ),
          )
        : _bloc.state is ExistingPokemonLoadingState
            ? buildShimmer()
            : ErrorPage(textStyle: theme.textTheme.labelMediumWhite);
  }

  Widget _buildEvYieldSection(PokemonPresentationModel pokemon) {
    var localizations = context.localizations;
    return pokemon.statsNotNull
      ? Semantics(
          label:
              "${localizations.evYield}: ${localizations.hp}: ${pokemon.hpEvYield}, ${localizations.attack}: ${pokemon.attackEvYield}, ${localizations.defense}: ${pokemon.defenseEvYield}, ${localizations.specialAttack}: ${pokemon.specialAttackEvYield}, ${localizations.specialDefense}: ${pokemon.specialDefenseEvYield}, ${localizations.speed}: ${pokemon.speedEvYield}",
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildEvYield(localizations.hp, pokemon.hpEvYield),
              _buildEvYield(localizations.attackShort, pokemon.attackEvYield),
              _buildEvYield(localizations.defenseShort, pokemon.defenseEvYield),
              _buildEvYield(localizations.specialAttackShort, pokemon.specialAttackEvYield),
              _buildEvYield(localizations.specialDefenseShort, pokemon.specialDefenseEvYield),
              _buildEvYield(localizations.speedShort, pokemon.speedEvYield),
            ],
          ),
        )
      : _bloc.state is ExistingPokemonLoadingState
          ? buildShimmer()
          : ErrorPage(textStyle: context.theme.textTheme.labelMediumWhite);
  }

  Widget _buildEvYield(String label, int? value) => LabelValueColumn(
        valueBackgroundColor: context.theme.colorScheme.secondary,
        valueTextStyle: context.theme.textTheme.labelMediumWhite,
        labelBackgroundColor: Colors.transparent,
        labelTextStyle: context.theme.textTheme.labelSmallWhite,
        label: label,
        value: value?.toString() ?? context.localizations.zero,
      );

  goBack() {
    Navigator.pop(context);
  }
}
