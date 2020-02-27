import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/model/music.dart';
import 'package:light_listen/model/music_data.dart';
import 'package:light_listen/provider/data_provider.dart';
import 'package:light_listen/provider/music_player_manager.dart';
import 'package:light_listen/widget/common_music_item.dart';
import 'package:light_listen/widget/common_player_controller.dart';
import 'package:light_listen/widget/daily_list_header.dart';
import 'package:light_listen/widget/flexible_detail_bar.dart';
import 'package:provider/provider.dart';

@FFRoute(
  name: "lightlisten://action_daily_music",
  routeName: "action_daily_music",
  pageRouteType: PageRouteType.material,
)
class DailyMusicPage extends StatefulWidget {
  @override
  _DailyMusicPageState createState() => _DailyMusicPageState();
}

class _DailyMusicPageState extends State<DailyMusicPage> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).getDailyMusic();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      bottomNavigationBar: CommonPlayerControllerWidget(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            floating: false,
            expandedHeight: 200.0,
            pinned: true,
            elevation: 0,
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("每日推荐"),
            bottom: DailyListHeader(
              onPressed1: () {},
              onPressed2: () {},
            ),
            flexibleSpace: FlexibleDetailBar(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Spacer(),
                  Container(
                    padding: EdgeInsets.only(left: suSetWidth(20.0)),
                    margin: EdgeInsets.only(bottom: suSetWidth(5.0)),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: '${DateUtil.formatDate(DateTime.now(), format: 'dd')} ',
                              style: TextStyle(fontSize: 30)),
                          TextSpan(
                              text: '/ ${DateUtil.formatDate(DateTime.now(), format: 'MM')}',
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: suSetWidth(20.0)),
                    margin: EdgeInsets.only(bottom: suSetHeight(10.0)),
                    child: Text(
                      '根据你的音乐口味，为你推荐好音乐。',
                      style: TextStyle(fontSize: 13, color: Colors.white70),
                    ),
                  ),
                ],
              ),
              background: Stack(
                children: <Widget>[
                  Image.asset(
                    "images/daily/bg_daily.png",
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaY: 5.0,
                      sigmaX: 5.0,
                    ),
                    child: Container(
                      color: Colors.black38,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Consumer2<DataProvider, MusicPlayerManager>(
            builder: (BuildContext context, DataProvider value, MusicPlayerManager value2, Widget child) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var d = value.dailyMusics[index];
                    return CommonMusicListItem(
                      MusicData(
                        mvId: d.mvid,
                        picUrl: d.album.picUrl,
                        songName: d.name,
                        artists: "${d.artists.map((a) => a.name).toList().join('/')} - ${d.album.name}",
                      ),
                      onTap: () {
                        value2.playMusics(
                          value.dailyMusics
                              .map((r) => Music(
                                    r.id,
                                    name: r.name,
                                    picUrl: r.album.picUrl,
                                    artists: '${r.artists.map((a) => a.name).toList().join('/')}',
                                  ))
                              .toList(),
                          index: index,
                        );
                        navigatorState.pushNamed(Routes.LIGHTLISTEN_PLAYER);
                      },
                    );
                  },
                  childCount: value.dailyMusics.length,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

//  void playSongs(PlaySongsModel model, int index) {
//    model.playSongs(
//      data.recommend
//          .map((r) => Song(
//        r.id,
//        name: r.name,
//        picUrl: r.album.picUrl,
//        artists: '${r.artists.map((a) => a.name).toList().join('/')}',
//      ))
//          .toList(),
//      index: index,
//    );
////    NavigatorUtil.goPlaySongsPage(context);
//  }

  @override
  bool get wantKeepAlive => true;
}
