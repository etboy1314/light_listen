import 'package:flutter/material.dart';
import 'package:light_listen/model/action.dart';
import 'package:light_listen/provider/music_player_manager.dart';

class MusicListDetailActionWidget extends StatelessWidget {
  final MusicPlayerManager player;

  MusicListDetailActionWidget(this.player);

  final actionMenus = [
    ActionMenu(icon: 'images/playlist/comment.png', click: () {}, title: "评论"),
    ActionMenu(icon: 'images/playlist/share.png', click: () {}, title: "分享"),
    ActionMenu(icon: 'images/playlist/download.png', click: () {}, title: "下载"),
    ActionMenu(icon: 'images/playlist/multi_select.png', click: () {}, title: "多选"),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: actionMenus.map((action) {
        return Expanded(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              action.icon,
              width: 24.0,
            ),
            Text(
              action.title,
              style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
            )
          ],
        ));
      }).toList(),
    );
  }
}
