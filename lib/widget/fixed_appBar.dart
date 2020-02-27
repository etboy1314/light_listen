import 'package:flutter/material.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/screens.dart';

class FixedAppBar extends StatelessWidget {
  final Widget title;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final Color backgroundColor;
  final double elevation;

  const FixedAppBar({
    Key key,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.title,
    this.centerTitle = true,
    this.backgroundColor,
    this.elevation = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _title = title;
    if (centerTitle) {
      _title = Center(child: _title);
    }
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
      ),
      height: suSetHeight(75.0) + MediaQuery.of(context).padding.top,
      decoration: BoxDecoration(
        boxShadow: elevation > 0
            ? <BoxShadow>[
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: suSetHeight(elevation * 2.0),
                ),
              ]
            : null,
        color: backgroundColor ?? Theme.of(context).primaryColor,
      ),
      child: Row(
        children: <Widget>[
          if (automaticallyImplyLeading && Navigator.of(context).canPop()) BackButton(),
          Expanded(child: _title),
          if (automaticallyImplyLeading && Navigator.of(context).canPop() && actions == null)
            SizedBox.fromSize(size: Size.square(56.0)),
          if (actions != null) ...actions,
        ],
      ),
    );
  }
}
