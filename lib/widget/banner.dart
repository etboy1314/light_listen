import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/provider/data_provider.dart';
import 'package:provider/provider.dart';

class BannerWidget extends StatelessWidget {
  final bannerHeight = Screens.width / (1080 / 420);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (BuildContext context, DataProvider provider, Widget child) {
      return provider.banners.length == 0
          ? Container(height: bannerHeight)
          : Container(
//              color: Colors.blue,
              height: Screens.width / (1080 / 420),
              child: CarouselSlider(
                viewportFraction: 1.0,
                aspectRatio: 1080 / 420,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 10),
                items: provider.banners.map((banner) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0 * 420 / 1080),
                    child: ExtendedImage.network(
                      banner.pic,
                      fit: BoxFit.fill,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      //cancelToken: cancellationToken,
                    ),
                  );
                }).toList(),
              ),
            );
    });
  }
}
