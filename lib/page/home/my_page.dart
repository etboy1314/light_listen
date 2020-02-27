import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/model/user_music_list.dart';
import 'package:light_listen/provider/data_provider.dart';
import 'package:light_listen/widget/flexible_detail_bar.dart';
import 'package:light_listen/widget/profile_action.dart';
import 'package:light_listen/widget/profile_header.dart';
import 'package:provider/provider.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController tabController;
  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).getUserPlayList();
    tabController = TabController(initialIndex: 0, length: 2, vsync: this);
//    Provider.of<DataProvider>(context, listen: false).getLikedMusicData();
  }

  @override
  Widget build(BuildContext context) {
    final bannerHeight = Screens.width / (1080 / 420);
    var expandedHeight = bannerHeight + Screens.navigationBarHeight;
    super.build(context);
    return Consumer<DataProvider>(
      builder: (BuildContext context, DataProvider provider, Widget child) {
        return CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              floating: false,
              pinned: true,
              expandedHeight: expandedHeight,
              elevation: 0,
              bottom: ProfileHeaderWidget(),
              flexibleSpace: FlexibleDetailBar(
                content: Container(
                  margin: EdgeInsets.only(top: Screens.navigationBarHeight, left: 10.0, right: 10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      profileWidget(provider),
//                      ProfileActionWidget(
//                        onPressed1: () {},
//                        onPressed2: () {},
//                        onPressed3: () {},
//                        onPressed4: () {},
//                      )
                    ],
                  ),
                ),
                background: bgWidget(provider),
              ),
            ),
            myMusicWidget(provider),
            SliverToBoxAdapter(child: Divider()),
            selectMusicListWidget(),
            if (selectIndex == 0) userCreatedMusicListWidget(provider),
            if (selectIndex == 1) userCollectedMusicListWidget(provider)
          ],
        );
      },
    );
  }

  Widget profileWidget(provider) {
    return provider.user == null
        ? Container()
        : Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(width: 20.0),
                ExtendedImage.network(
                  provider.user.profile.avatarUrl ?? "",
                  fit: BoxFit.fill,
                  shape: BoxShape.circle,
                  width: 80.0,
                ),
                SizedBox(width: 10.0),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      provider.user.profile.nickname,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0),
                      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.grey,
                      ),
                      child: Text(
                        "Lv.${provider.user.level}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 10.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
  }

  Widget bgWidget(provider) {
    return provider.user == null
        ? Container()
        : Stack(
            children: <Widget>[
              ExtendedImage.network(
                provider.user.profile.backgroundUrl,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 0.0, sigmaX: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black26.withOpacity(0.3),
                        Colors.black26.withOpacity(0.45),
                        Colors.black26.withOpacity(0.6),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ],
          );
  }

  Widget musicListWidget(UserMusicList musicList) {
    return InkWell(
      onTap: () {
        navigatorState.pushNamed(
          Routes.LIGHTLISTEN_MUSIC_LIST_DETAIL,
          arguments: {
            'id': musicList.id,
            'name': musicList.name,
            'picUrl': musicList.coverImgUrl,
            'nikeName': musicList.creator.nickname,
            'avatarUrl': musicList.creator.avatarUrl,
          },
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 6.0),
        child: Row(
          children: <Widget>[
            ExtendedImage.network(
              "${musicList.coverImgUrl}?param=200y200",
              fit: BoxFit.fill,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(6.0)),
            ),
            SizedBox(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(musicList.name, style: TextStyle(color: Colors.black87)),
                Text("${musicList.trackCount}首", style: TextStyle(color: Colors.black54)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget myMusicWidget(provider) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('我的音乐', style: const TextStyle(color: Colors.black, fontSize: 14.0)),
                  provider.userCreateMusicLists.length != 0
                      ? InkWell(
                          onTap: () {
                            navigatorState.pushNamed(
                              Routes.LIGHTLISTEN_MUSIC_LIST_DETAIL,
                              arguments: {
                                'id': provider.userCreateMusicLists[0].id,
                                'name': provider.userCreateMusicLists[0].name,
                                'picUrl': provider.userCreateMusicLists[0].coverImgUrl,
                                'nikeName': provider.userCreateMusicLists[0].creator.nickname,
                                'avatarUrl': provider.userCreateMusicLists[0].creator.avatarUrl,
                              },
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 15.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                ExtendedImage.network(
                                  "${provider.userCreateMusicLists[0].coverImgUrl}?param=150y150",
                                  fit: BoxFit.fill,
                                  shape: BoxShape.rectangle,
                                  width: 70,
                                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                ),
                                const SizedBox(height: 6.0),
                                Text("我喜欢的音乐", style: Theme.of(context).textTheme.caption)
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget selectMusicListWidget() {
    return SliverToBoxAdapter(
        child: Row(
      children: <Widget>[
        FlatButton(
          splashColor: Colors.white,
          onPressed: () => setState(() {
            selectIndex = 0;
          }),
          child: Text(
            "创建的歌单",
            style: TextStyle(color: selectIndex == 0 ? Colors.black : Colors.black38, fontSize: 14.0),
          ),
        ),
        FlatButton(
          splashColor: Colors.white,
          onPressed: () => setState(() {
            selectIndex = 1;
          }),
          child: Text(
            "收藏的歌单",
            style: TextStyle(color: selectIndex == 1 ? Colors.black : Colors.black38, fontSize: 14.0),
          ),
        ),
        Spacer(),
        IconButton(icon: Icon(Icons.more_vert, color: Colors.black38), onPressed: () {})
      ],
    ));
  }

  Widget userCreatedMusicListWidget(provider) {
    return SliverFixedExtentList(
        itemExtent: 60.0,
        delegate: SliverChildBuilderDelegate(
            (context, index) => musicListWidget(provider.userCreateMusicLists[index + 1]),
            childCount: provider.userCreateMusicLists.length - 1));
  }

  Widget userCollectedMusicListWidget(provider) {
    return SliverFixedExtentList(
      itemExtent: 60.0,
      delegate: SliverChildBuilderDelegate((context, index) => musicListWidget(provider.userCollectMusicLists[index]),
          childCount: provider.userCollectMusicLists.length),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
