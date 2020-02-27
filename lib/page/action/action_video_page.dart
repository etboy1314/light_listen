import 'package:flutter/material.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
  name: "lightlisten://action_video",
  routeName: "action_video",
  pageRouteType: PageRouteType.material,
)
class ActionVideoPage extends StatefulWidget {
  @override
  _ActionVideoPageState createState() => _ActionVideoPageState();
}

class _ActionVideoPageState extends State<ActionVideoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
