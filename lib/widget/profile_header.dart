import 'package:flutter/material.dart';
import 'package:light_listen/constans/screens.dart';

class ProfileHeaderWidget extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(suSetWidth(7.5))),
      child: Container(
        color: Colors.white,
        child: SizedBox.fromSize(size: preferredSize),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(15.0);
}
