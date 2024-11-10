import 'package:flutter/material.dart';

class ScrollUpHeaderListView extends StatefulWidget {
  final Widget Function(GlobalKey headerKey) headerBuilder;
  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final Color background;

  const ScrollUpHeaderListView({
    super.key,
    required this.headerBuilder,
    required this.itemCount,
    required this.itemBuilder,
    required this.background,
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
    WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
  }

  void getSizeAndPosition() {
    RenderBox renderBox =
    headerKey.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      headerHeight = renderBox.size.height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(color: widget.background)),
        CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              stretch: true,
              toolbarHeight: 0.0,
              expandedHeight: headerHeight ?? 100,
              elevation: 4.0,
              backgroundColor: Colors.transparent,
              scrolledUnderElevation: 0,
              flexibleSpace: FutureBuilder<double>(
                future: getHeaderHeight(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    headerHeight = snapshot.data!;
                  }
                  return widget.headerBuilder(headerKey);
                },
              ),
            ),
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
  }

  Future<double> getHeaderHeight() async {
    await Future.delayed(Duration(milliseconds: 50));
    final RenderBox renderBox =
    headerKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }
}
