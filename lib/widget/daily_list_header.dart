import 'package:flutter/material.dart';
import 'package:light_listen/constans/screens.dart';

class DailyListHeader extends StatelessWidget implements PreferredSizeWidget {
  DailyListHeader({this.onPressed1, this.onPressed2});

  final onPressed1;
  final onPressed2;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(suSetWidth(30.0))),
      child: Container(
        color: Colors.white,
        child: InkWell(
//          onTap: onTap,
          child: SizedBox.fromSize(
              size: preferredSize,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ActionChip(
                      avatar: Icon(Icons.play_circle_outline),
                      label: Text("播放全部"),
                      backgroundColor: Colors.white,
                      pressElevation: 0.0,
                      onPressed: onPressed1,
                    ),
                    Spacer(),
                    ActionChip(
                      avatar: Icon(Icons.list),
                      label: Text("多选"),
                      backgroundColor: Colors.white,
                      pressElevation: 0.0,
                      onPressed: onPressed2,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50.0);
}
