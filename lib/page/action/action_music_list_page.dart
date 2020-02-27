import 'package:flutter/material.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
  name: "lightlisten://action_music_list",
  routeName: "action_music_list",
  pageRouteType: PageRouteType.material,
)
class ActionSongListPage extends StatefulWidget {
  @override
  _ActionSongListPageState createState() => _ActionSongListPageState();
}

class _ActionSongListPageState extends State<ActionSongListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
