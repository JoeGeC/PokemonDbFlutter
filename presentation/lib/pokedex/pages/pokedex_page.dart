import 'package:domain/usecases/pokedex_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/common/assetConstants.dart';
import 'package:presentation/common/text_theme.dart';
import 'package:presentation/common/widgets/header.dart';
import 'package:presentation/common/widgets/scroll_up_header_list_widget.dart';
import 'package:presentation/pokedex/bloc/pokedex/pokedex_bloc.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter.dart';
import 'package:presentation/pokedex/pages/pokedex_list_page.dart';
import 'package:presentation/pokedex/pages/pokedex_loading_page.dart';

import '../../common/pages/error_page.dart';
import '../../common/widgets/shimmer.dart';
import '../../injections.dart';
import '../models/pokedex_presentation_model.dart';
import '../widgets/pokedex_header_widget.dart';
import '../widgets/pokemon_entry_widget.dart';

class PokedexPage extends StatefulWidget {
  const PokedexPage({super.key});

  @override
  State<PokedexPage> createState() => _PokedexPageState();
}

class _PokedexPageState extends State<PokedexPage> {
  final PokedexBloc _bloc = PokedexBloc(
      getIt<PokedexUseCase>(), getIt<PokedexPresentationConverter>());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final double _headerHeight = 80;
  final double _pokemonImageSize = 100;

  @override
  void initState() {
    getPokedex(1);
    super.initState();
  }

  void getPokedex(int id, {bool isLoading = true}) {
    _bloc.add(GetPokedexEvent(id, isLoading: isLoading));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: theme.colorScheme.primary,
      drawer: _buildDrawer(theme),
      body: SafeArea(
        child: BlocConsumer<PokedexBloc, PokedexState>(
          bloc: _bloc,
          listener: (context, state) {},
          builder: (context, state) => switch (state) {
            PokedexSuccessState() => _buildSuccessPage(theme, state.pokedex),
            PokedexLoadingState() => _buildPage(
                title: buildShimmer(),
                body: PokedexLoadingPage(_pokemonImageSize)),
            PokedexState() => _buildPage(body: ErrorPage()),
          },
        ),
      ),
    );
  }

  Widget _buildPage({Widget? title, Widget? body}) => Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AssetConstants.pokedexBackground,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildPokedexHeader(
                  scaffoldKey: _scaffoldKey,
                  title: title,
                  height: _headerHeight),
              body ?? Container(),
            ],
          ),
        ],
      );

  Widget _buildSuccessPage(ThemeData theme, PokedexPresentationModel pokedex) =>
      ScrollUpHeaderListView(
        key: ValueKey(pokedex.id),
        headerBuilder: (headerKey) => buildPokedexHeader(
          scaffoldKey: _scaffoldKey,
          title: _buildSuccessPageTitle(headerKey, pokedex, theme),
        ),
        itemCount: pokedex.pokemon.length,
        itemBuilder: (context, index) => buildPokemonEntry(
            pokedex.pokemon[index], pokedex.id, theme,
            imageSize: _pokemonImageSize),
        backgroundAsset: AssetConstants.pokedexBackground,
        headerHeight: _headerHeight,
      );

  Row _buildSuccessPageTitle(GlobalKey<State<StatefulWidget>> headerKey,
          PokedexPresentationModel pokedex, ThemeData theme) =>
      Row(
        key: headerKey,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            pokedex.regionName,
            style: theme.textTheme.headlineMedium!.copyWith(),
          ),
          SizedBox(width: 10),
          if (pokedex.versionAbbreviation.isNotEmpty)
            _buildTitleAbbreviation(pokedex)
        ],
      );

  Padding _buildTitleAbbreviation(PokedexPresentationModel pokedex) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          "(${pokedex.versionAbbreviation})",
          style: CustomTextTheme().labelMediumAlt.copyWith(),
        ),
      );

  Widget _buildDrawer(ThemeData theme) => Drawer(
        backgroundColor: theme.colorScheme.primary,
        child: SafeArea(
          child: Container(
            color: theme.colorScheme.surface,
            child: Column(
              children: <Widget>[
                buildHeader(
                  child: _buildDrawerHeader(theme),
                ),
                PokedexListPage(onSelected: onPokedexSelected),
              ],
            ),
          ),
        ),
      );

  SizedBox _buildDrawerHeader(ThemeData theme) => SizedBox(
        width: double.infinity,
        child: Text(
          "Pokedex",
          style: theme.textTheme.headlineMedium,
          textAlign: TextAlign.center,
        ),
      );

  onPokedexSelected(int id) {
    getPokedex(id);
    _scaffoldKey.currentState?.closeDrawer();
  }
}
