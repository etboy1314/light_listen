import 'dart:ui';

import 'package:flutter/material.dart';

class MyTabBarView extends StatelessWidget {
  final Widget child;
  final Widget bgChild;

  MyTabBarView({this.child, this.bgChild});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
//        ExtendedImage.network(
//          provider.user.profile.backgroundUrl,
//          height: _height,
//          width: Screens.width,
//          fit: BoxFit.cover,
//        ),
//        BackdropFilter(
//          filter: ImageFilter.blur(
//            sigmaY: 0.0,
//            sigmaX: 0.0,
//          ),
//          child: Container(
//            color: Colors.black38.withAlpha(80),
//            height: _height,
//            width: Screens.width,
//          ),
//        ),
        if (bgChild != null)
          bgChild,
        child
      ],
    );
  }
}
