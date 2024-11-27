import 'package:domain/usecases/pokedex_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/common/widgets/header.dart';
import 'package:presentation/common/widgets/scroll_up_header_list_widget.dart';
import 'package:presentation/pokedex/bloc/pokedex/pokedex_bloc.dart';
import 'package:presentation/pokedex/converters/pokedex_presentation_converter.dart';

import '../../common/pages/empty_page.dart';
import '../../common/pages/error_page.dart';
import '../../common/pages/loading_page.dart';
import '../../injections.dart';
import '../bloc/pokedex_list/pokedex_list_bloc.dart';
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
  late PokedexPresentationModel pokedex;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    getPokedex();
    super.initState();
  }

  void getPokedex({bool isLoading = true}) {
    _bloc.add(GetPokedexEvent(isLoading: isLoading));
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
          listener: (context, state) {
            if (state is PokedexSuccessState) {
              pokedex = state.pokedex;
            }
          },
          builder: (context, state) => switch (state) {
            PokedexLoadingState() => LoadingPage(),
            PokedexErrorState() => ErrorPage(),
            PokedexState() => _buildSuccessPage(theme),
          },
        ),
      ),
    );
  }

  Widget _buildSuccessPage(ThemeData theme) => pokedex.pokemon.isEmpty
      ? EmptyPage()
      : ScrollUpHeaderListView(
          headerBuilder: (headerKey) =>
              buildPokedexHeader(theme, headerKey, pokedex.name, _scaffoldKey),
          itemCount: pokedex.pokemon.length,
          itemBuilder: (context, index) =>
              buildPokemonEntry(pokedex.pokemon[index], pokedex.id, theme),
          background: theme.colorScheme.surface,
        );

  Drawer buildDrawer(ThemeData theme) => Drawer(
        backgroundColor: theme.colorScheme.primary,
        child: SafeArea(
          child: Container(
            color: theme.colorScheme.surface,
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                buildHeader(
                  child: Text(
                    "Pokedex",
                    style: theme.textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                buildPokedexList(),
              ],
            ),
          ),
        ),
      );

  BlocProvider<PokedexListBloc> buildPokedexList() {
    return BlocProvider(
      create: (context) => PokedexListBloc(getIt(), getIt()),
      child: BlocBuilder<PokedexListBloc, PokedexListState>(
        builder: (context, state) {
          if (state is PokedexListInitialState) {
            return Center(child: Text('Welcome to the Pokedex'));
          } else if (state is PokedexListLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PokedexListErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state is PokedexListSuccessState) {
            return ListView.builder(
              itemCount: state.pokedexList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(state.pokedexList[index].name),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
