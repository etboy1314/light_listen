import 'package:flutter/material.dart';
import 'package:light_listen/model/common/album.dart';
import 'package:light_listen/widget/common_player_controller.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
  name: "lightlisten://album_detail_page",
  routeName: "album_detail_page",
  pageRouteType: PageRouteType.material,
  argumentNames: ["album"],
)
class AlbumDetailPage extends StatefulWidget {
  final Album album;

  AlbumDetailPage({this.album});

  @override
  _AlbumDetailPageState createState() => _AlbumDetailPageState();
}

class _AlbumDetailPageState extends State<AlbumDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CommonPlayerControllerWidget(),
    );
  }
}
