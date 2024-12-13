import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class ExpandedPositionScroller {
  late final BuildContext context;
  final ItemPositionsListener positionsListener =
      ItemPositionsListener.create();
  final ItemScrollController scrollController = ItemScrollController();

  ExpandedPositionScroller(this.context);

  void scrollToExpandedItem(int index, double expandedItemHeight) {
    final visibleItems = positionsListener.itemPositions.value;
    if (visibleItems.isEmpty) return;

    final targetItem = visibleItems.firstWhereOrNull(
      (position) => position.index == index,
    );
    if (targetItem == null) return;

    final viewportHeight = MediaQuery.of(context).size.height;

    final targetPosition =
        targetItem.itemLeadingEdge * MediaQuery.of(context).size.height;
    final expandedBottomPosition = targetPosition + expandedItemHeight;

    var isOffscreen = expandedBottomPosition > viewportHeight;
    if (isOffscreen) {
      final alignment = 1.0 - (expandedItemHeight / viewportHeight).clamp(0.0, 1.0);
      scrollController.scrollTo(
        index: index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        alignment: alignment,
      );
    }
  }
}
