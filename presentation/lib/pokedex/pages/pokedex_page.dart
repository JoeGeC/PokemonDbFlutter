import 'package:domain/usecases/pokedex_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/common/asset_constants.dart';
import 'package:presentation/common/widgets/refresh_page_with_background.dart';
import 'package:presentation/common/widgets/scroll_up_header_list_widget.dart';
import 'package:presentation/pokedex/bloc/pokedex/pokedex_bloc.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter.dart';
import 'package:presentation/pokedex/pages/pokedex_list_drawer_page.dart';
import 'package:presentation/pokedex/pages/pokedex_loading_page.dart';
import 'package:presentation/pokemon/pages/pokemon_page.dart';

import '../../common/bloc/base_state.dart';
import '../../common/pages/error_page.dart';
import '../../common/utils/is_dark_mode.dart';
import '../../common/widgets/header.dart';
import '../../common/widgets/header_title.dart';
import '../../common/widgets/menu_icon_button.dart';
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
        child: BlocConsumer<PokedexBloc, BaseState>(
          bloc: _bloc,
          listener: (context, state) {},
          builder: (context, state) => RefreshIndicator(
              color: theme.colorScheme.primary,
              backgroundColor: theme.colorScheme.onPrimary,
              onRefresh: onRefresh,
              child: getPageState(state, theme)),
        ),
      ),
    );
  }

  Widget getPageState(BaseState state, ThemeData theme) => switch (state) {
        PokedexSuccessState() => _buildSuccessPage(theme, state.pokedex),
        LoadingState() => _buildLoadingPage(theme),
        BaseState() => _buildErrorPage(theme),
      };

  Widget _buildLoadingPage(ThemeData theme) =>
      buildRefreshablePageWithBackground(
        title: _buildHeader(title: buildShimmer()),
        body: PokedexLoadingPage(_pokemonImageSize),
        theme: theme,
        context: context,
        headerHeight: _headerHeight,
      );

  Widget _buildErrorPage(ThemeData theme) => buildRefreshablePageWithBackground(
        title: _buildHeader(),
        body: ErrorPage(),
        theme: theme,
        context: context,
        headerHeight: _headerHeight,
      );

  Widget _buildHeader({Widget? title}) => buildPokedexHeader(
        icon: buildMenuIconButton(scaffoldKey: _scaffoldKey),
        title: title ?? Container(),
        height: _headerHeight,
      );

  Widget _buildSuccessPage(ThemeData theme, PokedexPresentationModel pokedex) =>
      ScrollUpHeaderListView(
        key: ValueKey(pokedex.id),
        headerBuilder: (headerKey) => buildPokedexHeader(
          icon: buildMenuIconButton(scaffoldKey: _scaffoldKey),
          title: buildPageTitle(
              theme: theme,
              headerKey: headerKey,
              title: pokedex.regionName,
              subtitle: pokedex.versionAbbreviation),
        ),
        itemCount: pokedex.pokemon.length,
        itemBuilder: (context, index) => buildPokemonEntry(
            pokedex.pokemon[index], pokedex.id, theme,
            imageSize: _pokemonImageSize),
        backgroundAsset: AssetConstants.pokedexBackground(isDarkMode(theme)),
        headerHeight: _headerHeight,
        onItemTap: openPokemonPage,
      );

  Widget _buildDrawer(ThemeData theme) => Drawer(
        backgroundColor: theme.colorScheme.primary,
        child: SafeArea(
          child: Container(
            color: theme.colorScheme.surface,
            child: Column(
              children: <Widget>[
                buildHeader(child: _buildDrawerTitle(theme)),
                PokedexListDrawerPage(onSelected: onPokedexSelected),
              ],
            ),
          ),
        ),
      );

  SizedBox _buildDrawerTitle(ThemeData theme) => SizedBox(
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

  Future<void> onRefresh() async {
    _bloc.addLastEvent();
  }

  openPokemonPage(int index) {
    int? pokemonId = getPokemonIdOf(index);
    if (pokemonId == null) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PokemonPage(pokemonId: pokemonId),
      ),
    );
  }

  int? getPokemonIdOf(int index) {
    if (_bloc.state is PokedexSuccessState) {
      return (_bloc.state as PokedexSuccessState).pokedex.pokemon[index].id;
    }
    return null;
  }
}
