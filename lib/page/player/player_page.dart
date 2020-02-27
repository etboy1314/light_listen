import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:extended_image/extended_image.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/model/music.dart';
import 'package:light_listen/provider/music_player_manager.dart';
import 'package:light_listen/widget/lyric.dart';
import 'package:light_listen/widget/music_progress.dart';
import 'package:light_listen/widget/player_action.dart';
import 'package:light_listen/widget/player_controller.dart';
import 'package:provider/provider.dart';

@FFRoute(
  name: "lightlisten://player",
  routeName: "player",
  pageRouteType: PageRouteType.material,
)
class PlayerPage extends StatefulWidget {
  @override
  _PlayerPageState createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> with TickerProviderStateMixin {
  AnimationController controller;
  Animation animation;
  int switchIndex = 0;
  final double borderWidth = 4.0;
  final double centerWidth = Screens.width - 40.0 * 2;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(seconds: 20));
    animation = Tween(begin: 0.0, end: 1.0).animate(controller);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reset();
        controller.forward();
      } else if (status == AnimationStatus.dismissed) {
      } else if (status == AnimationStatus.forward) {
      } else if (status == AnimationStatus.reverse) {}
    });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicPlayerManager>(builder: (BuildContext context, MusicPlayerManager player, Widget child) {
      if (player.musics.length == 0) {
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        return Scaffold();
      } else {
        Music music = player.curMusic;
        if (player.curState == AudioPlayerState.PLAYING)
          // 播放状态，一直旋转，
          controller.forward();
        else
          /*否则停止*/
          controller.stop();
        return Stack(
          children: <Widget>[
            ExtendedImage.network(
              '${music.picUrl}?param=200y200',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaY: 100,
                sigmaX: 100,
              ),
              child: Container(
                color: Colors.black45,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent, //把scaffold的背景色改成透明
              appBar: AppBar(
                elevation: 0,
                brightness: Brightness.dark,
                iconTheme: IconThemeData(color: Colors.white),
                titleSpacing: 0.0,
                backgroundColor: Colors.transparent,
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      music.name ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      music.artists ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.white70),
                    ),
                  ],
                ),
                actions: <Widget>[IconButton(icon: Icon(Icons.share), onPressed: () {})],
              ),
              body: Column(
                children: <Widget>[
                  Expanded(
                      child: PageView(
                    children: <Widget>[
                      musicPicWidget(music),
                      LyricPage(player),
                    ],
                  )),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        PlayerActionWidget(player),
                        MusicProgressWidget(player),
                        PlayerControllerWidget(player),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      }
    });
  }

  Widget musicPicWidget(Music music) {
    return Container(
//      color: Colors.yellow,
      margin: EdgeInsets.symmetric(horizontal: 40.0),
      child: RotationTransition(
        turns: animation,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned.fill(
              child: Material(
                color: Colors.transparent,
                elevation: 1.0,
                shape: CircleBorder(
                  side: BorderSide(color: Colors.grey.withAlpha(600), width: borderWidth),
                ),
              ),
            ),
            Positioned(
              child: Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  ExtendedImage.asset('images/player/bet.png'),
                  Positioned(
                    left: (centerWidth / 2.0 - borderWidth) * 0.3412,
                    right: (centerWidth / 2.0 - borderWidth) * 0.3412,
                    child: ExtendedImage.network(
                      '${music.picUrl}',
                      fit: BoxFit.fill,
                      width: Screens.width - ((centerWidth / 2.0 - borderWidth) * 0.3412 + 40.0) * 2,
                      height: Screens.width - ((centerWidth / 2.0 - borderWidth) * 0.3412 + 40.0) * 2,
                      shape: BoxShape.circle,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
