import 'package:flutter/material.dart';

class ScrollUpHeaderListView extends StatefulWidget {
  final Widget Function(GlobalKey headerKey) headerBuilder;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final String backgroundAsset;
  final double? headerHeight;
  final Function(int)? onItemTap;

  const ScrollUpHeaderListView({
    super.key,
    required this.headerBuilder,
    required this.itemCount,
    required this.itemBuilder,
    required this.backgroundAsset,
    this.headerHeight,
    this.onItemTap,
  });

  @override
  ScrollUpHeaderListViewState createState() => ScrollUpHeaderListViewState();
}

class ScrollUpHeaderListViewState extends State<ScrollUpHeaderListView> {
  final GlobalKey headerKey = GlobalKey();
  final _scrollController = ScrollController();
  double? _autoHeaderHeight;

  @override
  void initState() {
    super.initState();
    if (widget.headerHeight == null) {
      WidgetsBinding.instance
          .addPostFrameCallback((_) => _getSizeAndPosition());
    }
  }

  void _getSizeAndPosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (headerKey.currentContext != null) {
        RenderBox renderBox =
            headerKey.currentContext!.findRenderObject() as RenderBox;
        setState(() {
          _autoHeaderHeight = renderBox.size.height;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          buildBackground(),
          buildScrollbar(buildScrollView()),
        ],
      );

  Positioned buildBackground() {
    return Positioned.fill(
            child: Image(
          image: AssetImage(widget.backgroundAsset),
          fit: BoxFit.cover,
        ));
  }

  Scrollbar buildScrollbar(Widget scrollView) => Scrollbar(
          controller: _scrollController,
          interactive: true,
          thickness: 10,
          radius: Radius.circular(4),
          child: scrollView,
        );

  CustomScrollView buildScrollView() => CustomScrollView(
            controller: _scrollController,
            slivers: [
              _buildHeader(),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      buildTappableItem(context, index),
                  childCount: widget.itemCount,
                ),
              ),
            ],
          );

  Widget buildTappableItem(BuildContext context, int index) => InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () => onItemTap(index),
        child: widget.itemBuilder(context, index),
      );

  onItemTap(int index) {
    if(widget.onItemTap == null) return;
    return widget.onItemTap!(index);
  }

  SliverAppBar _buildHeader() => SliverAppBar(
      floating: true,
      pinned: true,
      stretch: true,
      toolbarHeight: 0.0,
      expandedHeight: _autoHeaderHeight ?? widget.headerHeight ?? 100,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      flexibleSpace:
          FlexibleSpaceBar(background: widget.headerBuilder(headerKey)));
}
