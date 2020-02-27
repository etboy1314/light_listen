import 'package:audioplayers/audioplayers.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/provider/music_player_manager.dart';
import 'package:light_listen/widget/common_playlist_bottom_sheet.dart';
import 'package:provider/provider.dart';

class CommonPlayerControllerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MusicPlayerManager>(builder: (
      BuildContext context,
      MusicPlayerManager player,
      Widget child,
    ) {
      return player.musics.length == 0
          ? SizedBox()
          : Material(
              elevation: 6.0,
              child: InkWell(
                onTap: () {
                  navigatorState.pushNamed(Routes.LIGHTLISTEN_PLAYER);
                },
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                  height: 60.0,
                  child: Row(
                    children: <Widget>[
                      ExtendedImage.network(
                        '${player.curMusic.picUrl}?param=200y200',
                        shape: BoxShape.circle,
                        height: 40.0,
                        width: 40.0,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 10.0),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              player.curMusic.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.subtitle,
                            ),
//                  VEmptyView(10),
                            Text(
                              player.curMusic.artists,
                              style: Theme.of(context).textTheme.caption,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                          icon: Image.asset(
                            player.curState == AudioPlayerState.PLAYING
                                ? 'images/controller/pause.png'
                                : 'images/controller/play.png',
                          ),
                          onPressed: () {
                            if (player.curState == null) {
                              player.play();
                            } else {
                              player.togglePlay();
                            }
                          }),
                      IconButton(
                          icon: Image.asset('images/controller/list.png'),
                          onPressed: () {
                            showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                builder: (BuildContext context) {
                                  return CommonPlayListBottomSheet();
                                });
                          }),
                    ],
                  ),
                ),
              ),
            );
    });
  }
}
