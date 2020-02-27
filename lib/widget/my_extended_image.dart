import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class MyExtendedImage extends StatefulWidget {
  final String url;
  final BoxFit fit;
  final BoxShape shape;
  final BorderRadius borderRadius;
  final double loadingWidth;
  final double loadingHeight;

  MyExtendedImage({this.url, this.fit, this.shape, this.borderRadius, this.loadingWidth, this.loadingHeight});

  @override
  _MyExtendedImageState createState() => _MyExtendedImageState();
}

class _MyExtendedImageState extends State<MyExtendedImage> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ExtendedImage.network(
      widget.url,
      fit: widget.fit ?? null,
      shape: widget.shape ?? null,
      borderRadius: widget.borderRadius ?? null,
      cache: true,
      loadStateChanged: (ExtendedImageState state) {
        switch (state.extendedImageLoadState) {
          case LoadState.loading:
            _controller.reset();
            return Container(
              height: widget.loadingHeight,
              width: widget.loadingWidth,
            );
            break;
          case LoadState.completed:
            _controller.forward();
            return FadeTransition(
              opacity: _controller,
              child: ExtendedRawImage(image: state.extendedImageInfo?.image),
            );
            break;
          case LoadState.failed:
            _controller.reset();
            return Container();
            break;
          default:
            return null;
        }
      },
    );
  }
}
