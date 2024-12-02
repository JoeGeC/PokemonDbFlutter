import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/common/asset_constants.dart';
import 'package:presentation/common/utils/is_dark_mode.dart';
import 'package:presentation/pokedex/models/pokedex_group_presentation_model.dart';
import 'package:presentation/pokedex/models/pokedex_presentation_model.dart';
import 'package:presentation/pokedex/pages/position_scroller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../common/pages/error_page.dart';
import '../../common/pages/loading_page.dart';
import '../../common/widgets/animated_list.dart';
import '../../common/widgets/animated_row_with_start_color.dart';
import '../../injections.dart';
import '../bloc/pokedex_list/pokedex_list_bloc.dart';

class PokedexListDrawerPage extends StatefulWidget {
  final Function(int)? onSelected;
  final Function(bool)? isAnimating;

  const PokedexListDrawerPage({super.key, this.onSelected, this.isAnimating});

  @override
  State<StatefulWidget> createState() => _PokedexListExpandState();
}

class _PokedexListExpandState extends State<PokedexListDrawerPage> {
  late final ExpandedPositionScroller positionScroller;

  @override
  void initState() {
    super.initState();
    positionScroller = ExpandedPositionScroller(context);
  }

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
        builder: (context, state) =>
            _buildBackground(state, theme, children: _buildState(state, theme)),
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
                  AssetConstants.drawerBackground(isDarkMode(theme)),
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
    return ScrollablePositionedList.builder(
      itemScrollController: positionScroller.scrollController,
      itemPositionsListener: positionScroller.positionsListener,
      itemCount: pokedexGroups.length,
      itemBuilder: (context, index) {
        final pokedexGroup = pokedexGroups.elementAt(index);
        if (pokedexGroup.title == "National") {
          return _buildTappableGroupTitle(theme, pokedexGroup.title,
              () => selectPokedex(pokedexGroup.pokedexList.first.id));
        } else {
          return _buildRegionList(theme, pokedexGroup, index);
        }
      },
    );
  }

  selectPokedex(int id) {
    if (widget.onSelected != null) {
      widget.onSelected!(id);
    }
  }

  Column _buildRegionList(ThemeData theme,
          PokedexGroupPresentationModel pokedexGroup, int index) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTappableGroupTitle(theme, pokedexGroup.title,
              () => toggleExpanded(pokedexGroup, index)),
          buildAnimatedList(pokedexGroup, children: [
            ...pokedexGroup.pokedexList
                .map((pokedex) => _buildPokedexGroupItem(theme, pokedex))
          ]),
        ],
      );

  Widget _buildTappableGroupTitle(
          ThemeData theme, String title, Function() onTap) =>
      Column(
        children: [
          Material(
            color: Colors.transparent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: onTap,
                child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Text(
                      title,
                      style: theme.textTheme.labelMedium,
                    ),
                  ),
                ),
              ),
            ),
          ),
          buildDivider(theme),
        ],
      );

  Widget _buildPokedexGroupItem(
          ThemeData theme, PokedexPresentationModel pokedex) =>
      Column(
        children: [
          RowWithStartColor(
            startColor: theme.colorScheme.primary,
            startColorWidth: 10,
            onTapped: widget.onSelected,
            id: pokedex.id,
            children: [
              SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...pokedex.displayNames.map(
                    (displayName) =>
                        _buildPokedexVersionLabel(displayName, theme),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
        ],
      );

  Text _buildPokedexVersionLabel(String displayName, ThemeData theme) => Text(
        displayName,
        style: theme.textTheme.labelSmall,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      );

  Divider buildDivider(ThemeData theme) => Divider(
        color: theme.colorScheme.onSurface,
        thickness: 2,
        indent: 16,
        endIndent: 16,
      );

  Future<void> toggleExpanded(
      PokedexGroupPresentationModel pokedexGroup, int index) async {
    setState(() {
      pokedexGroup.isExpanded = !pokedexGroup.isExpanded;
    });
    await Future.delayed(const Duration(milliseconds: 50));
    positionScroller.scrollToExpandedItem(
        index, pokedexGroup.pokedexList.length * 60.0);
  }
}
