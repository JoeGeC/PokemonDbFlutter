import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:presentation/src/common/asset_constants.dart';
import 'package:presentation/src/common/utils/extensions.dart';
import 'package:presentation/src/common/utils/is_dark_mode.dart';
import 'package:presentation/src/common/widgets/loading_bar.dart';
import 'package:presentation/src/pokedex/models/pokedex_group_presentation_model.dart';
import 'package:presentation/src/pokedex/models/pokedex_presentation_model.dart';
import 'package:presentation/src/pokedex/pages/position_scroller.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../common/bloc/base_state.dart';
import '../../common/pages/error_page.dart';
import '../../common/pages/loading_page.dart';
import '../../common/widgets/animated_list.dart';
import '../../common/widgets/row_with_start_color.dart';
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
      child: BlocBuilder<PokedexListBloc, BaseState>(
        builder: (context, state) => _buildBackground(state,
            children: _buildStateWithLoadingBar(state)),
      ),
    );
  }

  Expanded _buildBackground(BaseState state, {children = const <Widget>[]}) =>
      Expanded(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AssetConstants.drawerBackground(isDarkMode(context.theme)),
                  fit: BoxFit.cover,
                ),
              ),
              children
            ],
          ),
        ),
      );

  Widget _buildStateWithLoadingBar(BaseState state) {
    if (state is CompletedState) {
      return _buildState(state.lastState);
    } else {
      return LoadingBar(child: _buildState(state));
    }
  }

  Widget _buildState(BaseState state) {
    switch (state) {
      case LoadingState():
        return LoadingPage();
      case PokedexListSuccessState():
        return _buildPokedexList(state);
      default:
        return ErrorPage();
    }
  }

  Widget _buildPokedexList(PokedexListSuccessState state) {
    var pokedexGroups = state.pokedexGroups;
    return ScrollablePositionedList.builder(
      itemScrollController: positionScroller.scrollController,
      itemPositionsListener: positionScroller.positionsListener,
      itemCount: pokedexGroups.length,
      itemBuilder: (context, index) {
        final pokedexGroup = pokedexGroups.elementAt(index);
        if (pokedexGroup.title == "National") {
          return _buildTappableGroupTitle(pokedexGroup.title,
              () => selectPokedex(pokedexGroup.pokedexList.first.id));
        } else {
          return _buildRegionList(pokedexGroup, index);
        }
      },
    );
  }

  selectPokedex(int id) {
    if (widget.onSelected != null) {
      widget.onSelected!(id);
    }
  }

  Column _buildRegionList(PokedexGroupPresentationModel pokedexGroup, int index) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTappableGroupTitle(pokedexGroup.title,
              () => toggleExpanded(pokedexGroup, index)),
          buildAnimatedList(pokedexGroup, children: [
            ...pokedexGroup.pokedexList
                .map((pokedex) => _buildPokedexGroupItem(pokedex))
          ]),
        ],
      );

  Widget _buildTappableGroupTitle(String title, Function() onTap) =>
      Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8),
            child: Material(
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
                        style: context.theme.textTheme.labelMedium,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          _buildDivider(),
        ],
      );

  Widget _buildPokedexGroupItem(PokedexPresentationModel pokedex) =>
      Column(
        children: [
          RowWithStartColor(
            startColor: context.theme.colorScheme.primary,
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
                        _buildPokedexVersionLabel(displayName),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 4),
        ],
      );

  Widget _buildPokedexVersionLabel(String displayName) =>
      Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text(
          displayName,
          style: context.theme.textTheme.labelSmall,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      );

  Widget _buildDivider() => Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 18, top: 2, right: 14, bottom: 4),
            child: Container(
              height: 2,
              color: context.theme.colorScheme.shadow,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 2,
              color: context.theme.colorScheme.onSurface,
            ),
          ),
        ],
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
