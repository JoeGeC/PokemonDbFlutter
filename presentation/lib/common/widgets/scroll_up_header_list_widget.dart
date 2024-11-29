import 'package:flutter/material.dart';

class ScrollUpHeaderListView extends StatefulWidget {
  final Widget Function(GlobalKey headerKey) headerBuilder;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final String backgroundAsset;

  const ScrollUpHeaderListView({
    super.key,
    required this.headerBuilder,
    required this.itemCount,
    required this.itemBuilder,
    required this.backgroundAsset,
  });

  @override
  ScrollUpHeaderListViewState createState() => ScrollUpHeaderListViewState();
}

class ScrollUpHeaderListViewState extends State<ScrollUpHeaderListView> {
  final GlobalKey headerKey = GlobalKey();
  double? headerHeight;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _getSizeAndPosition());
  }

  void _getSizeAndPosition() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (headerKey.currentContext != null) {
        RenderBox renderBox =
            headerKey.currentContext!.findRenderObject() as RenderBox;
        setState(() {
          headerHeight = renderBox.size.height;
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
          CustomScrollView(
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
        ],
      );

  SliverAppBar _buildHeader() => SliverAppBar(
      floating: true,
      pinned: true,
      stretch: true,
      toolbarHeight: 0.0,
      expandedHeight: headerHeight ?? 100,
      elevation: 4.0,
      backgroundColor: Colors.transparent,
      scrolledUnderElevation: 0,
      flexibleSpace:
          FlexibleSpaceBar(background: widget.headerBuilder(headerKey)));
}
