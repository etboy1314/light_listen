import 'dart:ui';

/// describe
/// 高斯模糊效果合集
/// created by hujintao
/// created at 2019-09-12
//
import 'package:flutter/material.dart';

/// 矩形高斯模糊效果
class BlurRectWidget extends StatefulWidget {
  final Widget child;

  /// 模糊值
  final double sigmaX;
  final double sigmaY;

  /// 透明度
  final double opacity;

  /// 外边距
  final EdgeInsetsGeometry blurMargin;

  /// 圆角
  final BorderRadius borderRadius;

  const BlurRectWidget({
    Key key,
    this.child,
    this.sigmaX,
    this.sigmaY,
    this.opacity,
    this.blurMargin,
    this.borderRadius,
  }) : super(key: key);

  @override
  _BlurRectWidgetState createState() => _BlurRectWidgetState();
}

class _BlurRectWidgetState extends State<BlurRectWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.blurMargin != null ? widget.blurMargin : EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: widget.borderRadius == null
            ? BorderRadius.all(Radius.circular(0))
            : widget.borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: this.widget.sigmaX != null ? this.widget.sigmaX : 10,
            sigmaY: this.widget.sigmaY != null ? this.widget.sigmaY : 10,
          ),
          child: Container(
            color: Colors.white70,
            child: this.widget.opacity != null
                ? Opacity(
                    opacity: widget.opacity,
                    child: this.widget.child,
                  )
                : this.widget.child,
          ),
        ),
      ),
    );
  }
}
