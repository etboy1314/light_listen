import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/provider/themes_provider.dart';
import 'package:provider/provider.dart';

@FFRoute(
  name: "lightlisten://register",
  routeName: "register",
  pageRouteType: PageRouteType.material,
)
class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with AutomaticKeepAliveClientMixin {
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ThemesProvider>(builder: (_, provider, __) {
      return Scaffold();
    });
  }

  @override
  bool get wantKeepAlive => true;
}
