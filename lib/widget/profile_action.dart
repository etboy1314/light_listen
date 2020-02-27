import 'package:flutter/material.dart';
import 'package:light_listen/model/action.dart';

class ProfileActionWidget extends StatelessWidget {
  ProfileActionWidget({this.onPressed1, this.onPressed2, this.onPressed3, this.onPressed4});

  final onPressed1;
  final onPressed2;
  final onPressed3;
  final onPressed4;

  @override
  Widget build(BuildContext context) {
    var actions = [
      ActionMenu(title: "本地音乐", icon: 0xe6d4, click: onPressed1),
      ActionMenu(title: "下载管理", icon: 0xe6c6, click: onPressed2),
      ActionMenu(title: "我的电台", icon: 0xe608, click: onPressed3),
      ActionMenu(title: "我的收藏", icon: 0xe610, click: onPressed4),
    ];
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: actions.map((action) {
        return Expanded(
            child: Padding(
          padding: EdgeInsets.only(bottom: 10.0, left: 15.0, right: 15.0),
          child: GestureDetector(
              onTap: () {},
              child: Column(
                children: <Widget>[
                  Icon(IconData(action.icon, fontFamily: "iconfont"), size: 16.0, color: Colors.white),
                  SizedBox(height: 5.0),
                  Text(action.title, style: TextStyle(color: Colors.white, fontSize: 10.0)),
                ],
              )),
        ));
      }).toList(),
    );
  }
}
