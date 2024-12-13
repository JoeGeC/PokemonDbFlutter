import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/src/common/asset_constants.dart';
import 'package:presentation/src/common/utils/extensions.dart';
import 'package:presentation/src/common/widgets/refresh_page_with_background.dart';
import 'package:presentation/src/common/widgets/scroll_up_header_list_widget.dart';
import 'package:presentation/src/pokedex/bloc/pokedex/pokedex_bloc.dart';
import 'package:presentation/src/pokedex/converters/pokedex_presentation_converter.dart';
import 'package:presentation/src/pokedex/pages/pokedex_list_drawer_page.dart';
import 'package:presentation/src/pokedex/pages/pokedex_loading_page.dart';
import 'package:presentation/src/pokemon/pages/pokemon_page.dart';

import '../../common/bloc/base_state.dart';
import '../../common/pages/error_page.dart';
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
  Widget build(BuildContext context) => Scaffold(
        key: _scaffoldKey,
        backgroundColor: context.theme.colorScheme.primary,
        drawer: _buildDrawer(),
        body: SafeArea(
          child: BlocConsumer<PokedexBloc, BaseState>(
            bloc: _bloc,
            listener: (context, state) {},
            builder: (context, state) => RefreshIndicator(
                color: context.theme.colorScheme.primary,
                backgroundColor: context.theme.colorScheme.onPrimary,
                onRefresh: onRefresh,
                child: getPageState(state)),
          ),
        ),
      );

  Widget getPageState(BaseState state) => switch (state) {
        PokedexSuccessState() => _buildSuccessPage(state.pokedex),
        LoadingState() => _buildLoadingPage(),
        BaseState() => _buildErrorPage(),
      };

  Widget _buildLoadingPage() => buildRefreshablePageWithBackground(
        title: _buildHeader(title: buildShimmer()),
        body: PokedexLoadingPage(_pokemonImageSize),
        context: context,
        headerHeight: _headerHeight,
      );

  Widget _buildErrorPage() => buildRefreshablePageWithBackground(
        title: _buildHeader(),
        body: ErrorPage(),
        context: context,
        headerHeight: _headerHeight,
      );

  Widget _buildHeader({Widget? title}) => buildPokedexHeader(
        icon: buildMenuIconButton(scaffoldKey: _scaffoldKey),
        title: title ?? Container(),
        height: _headerHeight,
      );

  Widget _buildSuccessPage(PokedexPresentationModel pokedex) =>
      ScrollUpHeaderListView(
        key: ValueKey(pokedex.id),
        headerBuilder: (headerKey) => buildPokedexHeader(
          icon: buildMenuIconButton(scaffoldKey: _scaffoldKey),
          title: buildPageTitle(
              theme: context.theme,
              headerKey: headerKey,
              title: pokedex.regionName,
              subtitle: pokedex.versionAbbreviation),
        ),
        itemCount: pokedex.pokemon.length,
        itemBuilder: (context, index) => buildPokemonEntry(
            pokedex.pokemon[index], pokedex.id,
            imageSize: _pokemonImageSize),
        backgroundAsset: AssetConstants.pokedexBackground(context.isDarkMode),
        headerHeight: _headerHeight,
        onItemTap: openPokemonPage,
      );

  Widget _buildDrawer() => Drawer(
        backgroundColor: context.theme.colorScheme.primary,
        child: SafeArea(
          child: Container(
            color: context.theme.colorScheme.surface,
            child: Column(
              children: <Widget>[
                buildHeader(child: _buildDrawerTitle()),
                PokedexListDrawerPage(onSelected: onPokedexSelected),
              ],
            ),
          ),
        ),
      );

  SizedBox _buildDrawerTitle() => SizedBox(
        width: double.infinity,
        child: Text(
          context.localizations.pokedex,
          style: context.theme.textTheme.headlineMedium,
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
