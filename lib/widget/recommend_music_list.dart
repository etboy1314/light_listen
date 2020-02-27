import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/provider/data_provider.dart';
import 'package:light_listen/widget/find_wrap_item.dart';
import 'package:provider/provider.dart';

class RecommendMusicListWidget extends StatelessWidget {
  final spacing = 10.0;
  final runSpacing = 10.0;
  final horizontalValue = 20.0;
  final verticalValue = 8.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(builder: (BuildContext context, DataProvider provider, Widget child) {
      return provider.dailyMusicLists.length == 0
          ? Container()
          : Container(
              margin: EdgeInsets.symmetric(horizontal: horizontalValue, vertical: verticalValue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: verticalValue),
                    child: Text(
                      "推荐歌单",
                      style: TextStyle(
                        fontSize: suSetSp(20.0),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: spacing, // 主轴(水平)方向间距
                    runSpacing: runSpacing, // 纵轴（垂直）方向间距
                    alignment: WrapAlignment.start, //沿主轴方向居中
                    children: provider.dailyMusicLists.sublist(0, 6).map((musicList) {
                      return FindWrapItemWidget(
                        title: musicList.name,
                        url: musicList.picUrl,
                        onTap: () {
                          navigatorState.pushNamed(
                            Routes.LIGHTLISTEN_MUSIC_LIST_DETAIL,
                            arguments: {
                              'id': musicList.id,
                              'name': musicList.name,
                              'picUrl': musicList.picUrl,
                              'nikeName': musicList.creator.nickname,
                              'avatarUrl': musicList.creator.avatarUrl,
                            },
                          );
                        },
                        width: (Screens.width - 2 * horizontalValue - 2 * spacing) / 3.0,
                      );
                    }).toList(),
                  )
                ],
              ),
            );
    });
  }
}
