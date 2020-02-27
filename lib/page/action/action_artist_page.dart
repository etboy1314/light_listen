import 'package:flutter/material.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
  name: "lightlisten://action_artist",
  routeName: "action_artist",
  pageRouteType: PageRouteType.material,
)
class ActionArtistPage extends StatefulWidget {
  @override
  _ActionArtistPageState createState() => _ActionArtistPageState();
}

class _ActionArtistPageState extends State<ActionArtistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
