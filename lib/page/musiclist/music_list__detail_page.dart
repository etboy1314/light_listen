import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/model/find/daily_music_list.dart';
import 'package:light_listen/model/music.dart';
import 'package:light_listen/model/music_data.dart';
import 'package:light_listen/model/musiclist/music_list.dart';
import 'package:light_listen/provider/music_player_manager.dart';
import 'package:light_listen/utils/net_util.dart';
import 'package:light_listen/widget/common_music_item.dart';
import 'package:light_listen/widget/common_player_controller.dart';
import 'package:light_listen/widget/flexible_detail_bar.dart';
import 'package:light_listen/widget/music_list_action.dart';
import 'package:light_listen/widget/music_list_header.dart';
import 'package:provider/provider.dart';

@FFRoute(
  name: "lightlisten://music_list_detail",
  routeName: "music_list_detail",
  pageRouteType: PageRouteType.material,
  argumentNames: ["id", "name", "picUrl", "nikeName", "avatarUrl"],
)
class MusicListDetailPage extends StatefulWidget {
  final id;
  final name;
  final picUrl;
  final nikeName;
  final avatarUrl;

  MusicListDetailPage({this.id, this.name, this.picUrl, this.nikeName, this.avatarUrl});

  @override
  _MusicListDetailPageState createState() => _MusicListDetailPageState();
}

class _MusicListDetailPageState extends State<MusicListDetailPage> {
  MusicList realMusicList;
  final expandedHeight = Screens.width - kToolbarHeight;

  @override
  void initState() {
    super.initState();
    requestData();
  }

  requestData() async {
    var map = await NetUtil.getMusicListDetail(widget.id);
    realMusicList = MusicList.fromJson(map);
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MusicPlayerManager>(builder: (BuildContext context, MusicPlayerManager player, Widget child) {
      return Scaffold(
        bottomNavigationBar: CommonPlayerControllerWidget(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              floating: false,
              expandedHeight: expandedHeight,
              pinned: true,
              elevation: 0,
              brightness: Brightness.dark,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text("歌单"),
              bottom: MusicListHeader(
                musicNum: realMusicList == null ? 0 : realMusicList.playlist.trackIds.length,
                collectNum: realMusicList == null ? 0 : realMusicList.playlist.subscribedCount,
                onPressed1: () {},
                onPressed2: () {},
              ),
              flexibleSpace: FlexibleDetailBar(
                content: Container(
//                  color: Colors.red,
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: Screens.navigationBarHeight),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10.0),
//                            color: Colors.blue,
                            child: ExtendedImage.network(
                              "${widget.picUrl}?param=200y200",
                              fit: BoxFit.fill,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(6.0)),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  widget.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.subtitle.copyWith(color: Colors.white),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: ExtendedImage.network(
                                        "${widget.avatarUrl}?param=50y50",
                                        fit: BoxFit.fill,
                                        height: 25.0,
                                        shape: BoxShape.circle,
                                      ),
                                      margin: EdgeInsets.all(10.0),
                                    ),
                                    Expanded(
                                      child: Text(
                                        widget.nikeName,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
                                      ),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        realMusicList == null ? '' : realMusicList.playlist.description ?? "无",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
                                      ),
                                    ),
                                    Icon(
                                      Icons.navigate_next,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        child: MusicListDetailActionWidget(player),
                      )
                    ],
                  ),
                ),
                background: Stack(
                  children: <Widget>[
                    ExtendedImage.network(
                      "${widget.picUrl}?param=200y200",
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaY: 30,
                        sigmaX: 30,
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
            SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                var d = realMusicList.playlist.tracks[index];
                return CommonMusicListItem(
                  MusicData(
                    mvId: d.mv,
                    index: index + 1,
                    songName: d.name,
                    artists: '${d.ar.map((a) => a.name).toList().join('/')} - ${d.al.name}',
                  ),
                  onTap: () {
                    player.playMusics(
                      realMusicList.playlist.tracks
                          .map((r) => Music(
                                r.id,
                                name: r.name,
                                picUrl: r.al.picUrl,
                                artists: '${r.ar.map((a) => a.name).toList().join('/')}',
                              ))
                          .toList(),
                      index: index,
                    );
                    navigatorState.pushNamed(Routes.LIGHTLISTEN_PLAYER);
                  },
                );
              }, childCount: realMusicList == null ? 0 : realMusicList.playlist.trackIds.length),
            ),
          ],
        ),
      );
    });
  }
}
