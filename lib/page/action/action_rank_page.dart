import 'package:flutter/material.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
  name: "lightlisten://action_rank",
  routeName: "action_rank",
  pageRouteType: PageRouteType.material,
)
class ActionRankPage extends StatefulWidget {
  @override
  _ActionRankPageState createState() => _ActionRankPageState();
}

class _ActionRankPageState extends State<ActionRankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
