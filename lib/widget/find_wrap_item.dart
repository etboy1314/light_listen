import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/screens.dart';

class FindWrapItemWidget extends StatelessWidget {
  final String title;
  final String url;
  final Function onTap;
  final double width;

  FindWrapItemWidget({this.title, this.url, this.onTap, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ExtendedImage.network(
              "$url?param=200y200",
              fit: BoxFit.fill,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              height: width,
              width: width,
            ),
            Container(
              margin: EdgeInsets.only(top: 5.0),
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: suSetSp(16.0)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
