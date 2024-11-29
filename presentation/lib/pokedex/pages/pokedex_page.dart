import 'package:domain/usecases/pokedex_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/common/assetConstants.dart';
import 'package:presentation/common/widgets/header.dart';
import 'package:presentation/common/widgets/scroll_up_header_list_widget.dart';
import 'package:presentation/pokedex/bloc/pokedex/pokedex_bloc.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter.dart';
import 'package:presentation/pokedex/pages/pokedex_list_page.dart';

import '../../common/pages/empty_page.dart';
import '../../common/pages/error_page.dart';
import '../../common/pages/loading_page.dart';
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
      drawer: buildDrawer(theme),
      body: SafeArea(
        child: BlocConsumer<PokedexBloc, PokedexState>(
          bloc: _bloc,
          listener: (context, state) {},
          builder: (context, state) => switch (state) {
            PokedexSuccessState() => _buildSuccessPage(theme, state.pokedex),
            PokedexLoadingState() => LoadingPage(),
            PokedexState() => ErrorPage(),
          },
        ),
      ),
    );
  }

  Widget _buildSuccessPage(ThemeData theme, PokedexPresentationModel pokedex) =>
      pokedex.pokemon.isEmpty
          ? EmptyPage()
          : ScrollUpHeaderListView(
              key: ValueKey(pokedex.id),
              headerBuilder: (headerKey) => buildPokedexHeader(
                  theme, headerKey, pokedex.regionName, _scaffoldKey),
              itemCount: pokedex.pokemon.length,
              itemBuilder: (context, index) =>
                  buildPokemonEntry(pokedex.pokemon[index], pokedex.id, theme),
              backgroundAsset: AssetConstants.pokedexBackground,
            );

  Widget buildDrawer(ThemeData theme) => Drawer(
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
