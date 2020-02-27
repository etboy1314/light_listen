import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/screens.dart';

/// Progress Indicator. Used in loading data.
class PlatformProgressIndicator extends StatelessWidget {
  final double strokeWidth;
  final double radius;
  final Color color;
  final double value;

  const PlatformProgressIndicator({
    Key key,
    this.strokeWidth = 4.0,
    this.radius = 10.0,
    this.color,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoActivityIndicator(radius: radius)
        : CircularProgressIndicator(
            strokeWidth: suSetWidth(strokeWidth),
            valueColor: color != null ? AlwaysStoppedAnimation<Color>(color) : null,
            value: value,
          );
  }
}
