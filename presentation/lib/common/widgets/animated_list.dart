import 'package:flutter/cupertino.dart';

import '../../pokedex/models/pokedex_group_presentation_model.dart';

AnimatedSize buildAnimatedList(Expandable expandable,
        {children = const <Widget>[], int milliseconds = 300}) =>
    AnimatedSize(
      duration: Duration(milliseconds: milliseconds),
      curve: Curves.easeInOut,
      child: Container(
        constraints: BoxConstraints(
          maxHeight: expandable.isExpanded ? double.infinity : 0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...children,
            ],
          ),
        ),
      ),
    );
