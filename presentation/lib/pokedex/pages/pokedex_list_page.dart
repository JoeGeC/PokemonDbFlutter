import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../injections.dart';
import '../bloc/pokedex_list/pokedex_list_bloc.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';

class PokedexListPage extends StatelessWidget {
  const PokedexListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) {
        final bloc = PokedexListBloc(getIt(), getIt());
        bloc.add(GetPokedexListEvent());
        return bloc;
      },
      child: BlocBuilder<PokedexListBloc, PokedexListState>(
        builder: (context, state) {
          //TODO change states
          if (state is PokedexListInitialState) {
            return Center(child: Text('Welcome to the Pokedex'));
          } else if (state is PokedexListLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is PokedexListErrorState) {
            return Center(child: Text('Error: ${state.errorMessage}'));
          } else if (state is PokedexListSuccessState) {
            return Expanded(
              child: buildPokedexList(state, theme),
            );
          }
          return Container();
        },
      ),
    );
  }

  ListView buildPokedexList(PokedexListSuccessState state, ThemeData theme) {
    var pokedexMap = state.pokedexMap;
    return ListView.builder(
      itemCount: pokedexMap.length,
      itemBuilder: (context, index) {
        final regionName = pokedexMap.keys.elementAt(index);
        final pokedexList = pokedexMap.values.elementAt(index);
        if (pokedexList.length > 1) {
          return _buildRegionList(theme, regionName, pokedexList);
        } else {
          return _buildSingleItem(theme, pokedexList.first);
        }
      },
    );
  }

  Column _buildRegionList(ThemeData theme, String regionName,
      List<PokedexPresentationModel> pokedexList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            regionName,
            style: theme.textTheme.labelMedium,
          ),
        ),
        ...pokedexList.map((pokedex) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ListTile(
              subtitle: Column(
                  children: [
                ...pokedex.displayNames.map((displayName) {
                  return Text(displayName, style: theme.textTheme.labelSmall);
                }),
              ]),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildSingleItem(ThemeData theme, PokedexPresentationModel pokedex) =>
      ListTile(
        title: Text(pokedex.regionName, style: theme.textTheme.labelMedium),
        onTap: () {},
      );
}
