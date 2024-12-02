import 'package:flutter/material.dart';

class ScrollUpHeaderListView extends StatefulWidget {
  final Widget Function(GlobalKey headerKey) headerBuilder;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final String backgroundAsset;
  final double? headerHeight;

  const ScrollUpHeaderListView({
    super.key,
    required this.headerBuilder,
    required this.itemCount,
    required this.itemBuilder,
    required this.backgroundAsset,
    this.headerHeight,
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
          Positioned.fill(
              child: Image(
            image: AssetImage(widget.backgroundAsset),
            fit: BoxFit.cover,
          )),
          Scrollbar(
            controller: _scrollController,
            interactive: true,
            thickness: 10,
            radius: Radius.circular(4),
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                _buildHeader(),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    widget.itemBuilder,
                    childCount: widget.itemCount,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

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
