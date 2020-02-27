import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/provider/data_provider.dart';
import 'package:light_listen/widget/banner.dart';
import 'package:light_listen/widget/find_action.dart';
import 'package:light_listen/widget/new_album.dart';
import 'package:light_listen/widget/recommend_music_list.dart';
import 'package:provider/provider.dart';

class FindPage extends StatefulWidget {
  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with AutomaticKeepAliveClientMixin {
//  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    requestData();
  }

  Future requestData() {
    Provider.of<DataProvider>(context, listen: false).getBanner();
    Provider.of<DataProvider>(context, listen: false).getDailyMusicList();
    Provider.of<DataProvider>(context, listen: false).getNewAlbum();
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: Screens.navigationBarHeight),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            BannerWidget(),
            FindActionWidget(),
            Divider(),
            RecommendMusicListWidget(),
            Divider(),
            NewAlbumWidget(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
