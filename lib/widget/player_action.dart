import 'package:flutter/material.dart';
import 'package:light_listen/model/action.dart';
import 'package:light_listen/provider/music_player_manager.dart';

class PlayerActionWidget extends StatelessWidget {
  final MusicPlayerManager player;

  PlayerActionWidget(this.player);

  final actionMenus = [
    ActionMenu(icon: 'images/player/like.png', click: () {}, title: "喜欢"),
    ActionMenu(icon: 'images/player/download.png', click: () {}, title: "下载"),
    ActionMenu(icon: 'images/player/comment.png', click: () {}, title: "评论"),
    ActionMenu(icon: 'images/player/more.png', click: () {}, title: "更多"),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: actionMenus.map((action) {
        return Expanded(
            child: IconButton(
          icon: Image.asset(action.icon),
          onPressed: action.click,
        ));
      }).toList(),
    );
  }
}
