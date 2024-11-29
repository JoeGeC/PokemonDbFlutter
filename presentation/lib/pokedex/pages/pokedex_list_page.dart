import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/common/assetConstants.dart';
import 'package:presentation/pokedex/models/pokedex_group_presentation_model.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';

import '../../common/pages/error_page.dart';
import '../../common/pages/loading_page.dart';
import '../../common/widgets/animated_list.dart';
import '../../common/widgets/animated_row_with_start_color.dart';
import '../../injections.dart';
import '../bloc/pokedex_list/pokedex_list_bloc.dart';

class PokedexListPage extends StatefulWidget {
  final Function(int)? onSelected;
  final Function(bool)? isAnimating;

  const PokedexListPage({super.key, this.onSelected, this.isAnimating});

  @override
  State<StatefulWidget> createState() => _PokedexListExpandState();
}

class _PokedexListExpandState extends State<PokedexListPage> {
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
        builder: (context, state) => _buildBackground(
          state,
          theme,
          children: _buildState(state, theme),
        ),
      ),
    );
  }

  Expanded _buildBackground(PokedexListState state, ThemeData theme,
          {children = const <Widget>[]}) =>
      Expanded(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AssetConstants.pokedexBackground,
                  fit: BoxFit.cover,
                ),
              ),
              children
            ],
          ),
        ),
      );

  Widget _buildState(PokedexListState state, ThemeData theme) {
    switch (state) {
      case PokedexListLoadingState():
        return LoadingPage();
      case PokedexListSuccessState():
        return Expanded(child: _buildPokedexList(state, theme));
      default:
        return ErrorPage();
    }
  }

  Widget _buildPokedexList(PokedexListSuccessState state, ThemeData theme) {
    var pokedexGroups = state.pokedexGroups;
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            AssetConstants.pokedexBackground,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: ListView.builder(
            itemCount: pokedexGroups.length,
            itemBuilder: (context, index) {
              final pokedexGroup = pokedexGroups.elementAt(index);
              if (pokedexGroup.title == "National") {
                return _buildTappableGroupTitle(theme, pokedexGroup);
              } else {
                return _buildRegionList(theme, pokedexGroup);
              }
            },
          ),
        ),
      ],
    );
  }

  Column _buildRegionList(
          ThemeData theme, PokedexGroupPresentationModel pokedexGroup) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTappableGroupTitle(theme, pokedexGroup),
          buildAnimatedList(pokedexGroup, children: [
            ...pokedexGroup.pokedexList
                .map((pokedex) => _buildPokedexGroupItem(theme, pokedex))
          ]),
        ],
      );

  Widget _buildTappableGroupTitle(
          ThemeData theme, PokedexGroupPresentationModel pokedexGroup) =>
      Column(
        children: [
          Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => toggleExpanded(pokedexGroup),
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      pokedexGroup.title,
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ),
              ),
            ),
          ),
          buildDivider(),
        ],
      );

  Widget _buildPokedexGroupItem(
          ThemeData theme, PokedexPresentationModel pokedex) =>
      Column(
        children: [
          AnimatedRowWithStartColor(
            startColor: theme.colorScheme.primary,
            initialWidth: 10,
            expandedWidth: MediaQuery.of(context).size.width,
            onTapped: widget.onSelected,
            isAnimating: widget.isAnimating,
            id: pokedex.id,
            children: [
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...pokedex.displayNames.map((displayName) =>
                      Text(displayName, style: theme.textTheme.labelSmall)),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
        ],
      );

  Divider buildDivider() => Divider(
        color: Colors.black,
        thickness: 2,
        indent: 16,
        endIndent: 16,
      );

  void toggleExpanded(PokedexGroupPresentationModel pokedexGroup) {
    setState(() {
      pokedexGroup.isExpanded = !pokedexGroup.isExpanded;
    });
  }
}
