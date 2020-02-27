import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/provider/music_player_manager.dart';
import 'package:light_listen/widget/common_playlist_bottom_sheet.dart';

class PlayerControllerWidget extends StatelessWidget {
  final MusicPlayerManager player;

  PlayerControllerWidget(this.player);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Image.asset('images/player/play_type_1.png'),
            onPressed: () {},
          ),
          IconButton(
            icon: Image.asset('images/player/left.png'),
            onPressed: () {
              player.prePlay();
            },
          ),
          IconButton(
            icon: Image.asset(
              player.curState != AudioPlayerState.PAUSED ? 'images/player/pause.png' : 'images/player/play.png',
            ),
            iconSize: 80.0,
            onPressed: () {
              player.togglePlay();
            },
          ),
          IconButton(
            icon: Image.asset('images/player/right.png'),
            onPressed: () {
              player.nextPlay();
            },
          ),
          IconButton(
            icon: Image.asset('images/player/list.png'),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return CommonPlayListBottomSheet();
                  });
            },
          ),
        ],
      ),
    );
  }
}
