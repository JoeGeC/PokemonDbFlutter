import 'package:flutter/material.dart';
import 'package:presentation/common/assetConstants.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _getSizeAndPosition());
  }

  void _getSizeAndPosition() {
    RenderBox renderBox =
        headerKey.currentContext!.findRenderObject() as RenderBox;
    setState(() {
      headerHeight = renderBox.size.height;
    });
  }

  @override
  Widget build(BuildContext context) => Stack(
        children: [
          Positioned.fill(child: Image(
            image: AssetImage(AssetConstants.pokedexBackground),
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
        flexibleSpace: _buildHeaderToCorrectSize(),
      );

  FutureBuilder<double> _buildHeaderToCorrectSize() => FutureBuilder<double>(
        future: _getHeaderHeight(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            headerHeight = snapshot.data!;
          }
          return widget.headerBuilder(headerKey);
        },
      );

  Future<double> _getHeaderHeight() async {
    await Future.delayed(Duration(milliseconds: 50));
    final RenderBox renderBox =
        headerKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size.height;
  }
}
