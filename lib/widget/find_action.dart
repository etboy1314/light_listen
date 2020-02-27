import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/model/action.dart';

class FindActionWidget extends StatelessWidget {
  final _actions = [
    ActionMenu(
        title: "每日推荐",
        icon: 'images/action/daily.png',
        click: () {
          navigatorState.pushNamed(Routes.LIGHTLISTEN_ACTION_DAILY_MUSIC);
        }),
//    ActionMenu(
//        title: "歌手",
//        icon: Icons.person,
//        click: () {
//          navigatorState.pushNamed(Routes.LIGHTLISTEN_ACTION_ARTIST);
//        }),
    ActionMenu(
      title: "排行榜",
      icon: 'images/action/rank.png',
      click: () {
        navigatorState.pushNamed(Routes.LIGHTLISTEN_ACTION_RANK);
      },
    ),
    ActionMenu(
        title: "歌单",
        icon: 'images/action/playlist.png',
        click: () {
          navigatorState.pushNamed(Routes.LIGHTLISTEN_ACTION_MUSIC_LIST);
        }),
//    ActionMenu(
//        title: "视频",
//        icon: Icons.music_video,
//        click: () {
//          navigatorState.pushNamed(Routes.LIGHTLISTEN_ACTION_VIDEO);
//        }),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 15.0),
      child: Row(
        children: _actions.map((action) {
          return Expanded(
            child: InkWell(
              onTap: action.click,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipOval(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.withOpacity(0.7),
                            Colors.red.withOpacity(0.8),
                            Colors.red.withOpacity(0.9),
                            Colors.red.withOpacity(1.0),
                          ],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          IconButton(
                            padding: EdgeInsets.zero,
                            icon: Image.asset(
                              action.icon,
                              color: Colors.white,
                            ),
                            iconSize: 48.0,
                            onPressed: null,
                          ),
                          if (action.title == '每日推荐')
                            Container(
                              padding: EdgeInsets.only(top: 5),
                              child: Text(
                                '${DateUtil.formatDate(DateTime.now(), format: 'd')}',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4),
                    child: Text(
                      action.title,
                      style: TextStyle(fontSize: 12.0),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
