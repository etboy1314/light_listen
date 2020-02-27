import 'dart:async';
import 'dart:ui';

import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/model/action.dart';
import 'package:light_listen/page/home/find_page.dart';
import 'package:light_listen/page/home/my_page.dart';
import 'package:light_listen/page/home/trend__page.dart';
import 'package:light_listen/provider/data_provider.dart';
import 'package:light_listen/widget/common_player_controller.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

@FFRoute(
  name: "lightlisten://home",
  routeName: "home",
  pageRouteType: PageRouteType.material,
)
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  int curPage = 0;
  StreamController indexController = StreamController<double>.broadcast();
  TabController tabController;
  PageController pageController;

//
//  final _menus1 = [
//    ActionMenu(title: "我的消息", icon: IconData(0xe650, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "我的好友", icon: IconData(0xe742, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "听歌识曲", icon: IconData(0xe600, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "个性装扮", icon: IconData(0xe65d, fontFamily: "iconfont"), click: () {}),
//  ];
//
//  final _menus2 = [
//    ActionMenu(title: "演出", icon: IconData(0xe65a, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "商城", icon: IconData(0xe90b, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "游戏推荐", icon: IconData(0xe648, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "附近的人", icon: IconData(0xe659, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "口袋彩铃", icon: IconData(0xe61d, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "创作者中心", icon: IconData(0xe64e, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "我的订单", icon: IconData(0xe626, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "定时停止播放", icon: IconData(0xe6a5, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "扫一扫", icon: IconData(0xe65b, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "音乐闹钟", icon: IconData(0xe658, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "音乐云盘", icon: IconData(0xe622, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "在线听歌免流量", icon: IconData(0xe657, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "优惠券", icon: IconData(0xe625, fontFamily: "iconfont"), click: () {}),
//    ActionMenu(title: "青少年模式", icon: IconData(0xe641, fontFamily: "iconfont"), click: () {}),
//  ];

  @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).getUserDetail();
    tabController = TabController(initialIndex: 1, length: 3, vsync: this);
    pageController = PageController(initialPage: 1);
    pageController.addListener(() {
      if (pageController.page <= 1.0) indexController.add(pageController.page);
    });
  }

  int lastBack = 0;

  Future<bool> doubleBackExit() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - lastBack > 800) {
      showToast("再按一次退出应用");
      lastBack = DateTime.now().millisecondsSinceEpoch;
    } else {
      SystemNavigator.pop();
    }
    return Future.value(false);
  }

  @override
  void dispose() {
    tabController?.dispose();
    indexController?.close();
    pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('home build');
    return WillPopScope(
      onWillPop: doubleBackExit,
      child: Scaffold(
        drawer: Drawer(),
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              child: PageView(
                controller: pageController,
                onPageChanged: (index) {
                  tabController.animateTo(index);
                },
                children: [MyPage(), FindPage(), TrendPage()],
              ),
            ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: StreamBuilder(
                initialData: 1.0,
                stream: indexController.stream,
                builder: (_, data) {
                  return AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white.withOpacity((data.data as double)),
                    iconTheme: IconThemeData(color: Color.lerp(Colors.white, Colors.black, data.data)),
                    title: TabBar(
                      controller: tabController,
                      onTap: (index) {
                        pageController.animateToPage(
                          index,
                          curve: Curves.linear,
                          duration: Duration(milliseconds: 300),
                        );
                      },
                      tabs: [Tab(text: "我的"), Tab(text: "发现"), Tab(text: "动态")],
                      indicator: const BoxDecoration(),
                      labelColor: Color.lerp(Colors.white, Colors.black, data.data),
                      unselectedLabelColor: Color.lerp(Colors.white, Colors.black, data.data),
                      labelStyle: TextStyle(
                        fontSize: suSetSp(22.0),
                        fontWeight: FontWeight.bold,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                      unselectedLabelStyle: TextStyle(
                        fontSize: suSetSp(22.0),
                        fontWeight: FontWeight.w500,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                    actions: <Widget>[IconButton(icon: Icon(Icons.search), onPressed: () {})],
                  );
                },
              ),
            )
          ],
        ),
        bottomNavigationBar: CommonPlayerControllerWidget(),
      ),
    );
  }

//  get myAppBar =>

//  get myDrawer =>

//  get header => Consumer<UserProvider>(builder: (BuildContext context, UserProvider provider, Widget child) {
//        return Container(
//          height: 220,
//          child: provider.user == null
//              ? Container()
//              : Stack(
//                  children: <Widget>[
//                    ExtendedImage.network(
//                      provider.user.profile.avatarUrl,
//                      width: double.infinity,
//                      fit: BoxFit.cover,
//                    ),
//                    BlurRectWidget(
//                      sigmaX: 20,
//                      sigmaY: 20,
//                    ),
//                    Container(
//                      padding: EdgeInsets.only(left: 20),
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          ClipOval(
//                            child: ExtendedImage.network(provider.user.profile.avatarUrl, width: 70),
//                          ),
//                          Container(
//                            margin: EdgeInsets.only(top: 15),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              crossAxisAlignment: CrossAxisAlignment.end,
//                              children: <Widget>[
//                                Row(
//                                  mainAxisAlignment: MainAxisAlignment.start,
//                                  crossAxisAlignment: CrossAxisAlignment.end,
//                                  children: <Widget>[
//                                    Text(
//                                      provider.user.profile.nickname,
//                                      style: TextStyle(fontSize: 20),
//                                    ),
//                                    SizedBox(width: 5),
//                                    Container(
//                                      padding: EdgeInsets.symmetric(
//                                        vertical: 2,
//                                        horizontal: 6,
//                                      ),
//                                      decoration: BoxDecoration(
//                                        color: Colors.black12,
//                                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
//                                      ),
//                                      child: Text(
//                                        "Lv.${provider.user.level}",
//                                        style: TextStyle(
//                                          fontSize: 10,
//                                          fontWeight: FontWeight.w600,
//                                          color: Colors.black38,
//                                        ),
//                                      ),
//                                    )
//                                  ],
//                                ),
//                                Container(
//                                  width: 60,
//                                  height: 25,
//                                  margin: EdgeInsets.only(right: 20),
//                                  child: RaisedButton(
//                                    padding: EdgeInsets.all(0),
//                                    shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.all(Radius.circular(14)),
//                                    ),
//                                    elevation: 0,
//                                    color: Colors.red,
//                                    textColor: Colors.white,
//                                    onPressed: () {},
//                                    child: Row(
//                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                      crossAxisAlignment: CrossAxisAlignment.end,
//                                      children: <Widget>[
//                                        Icon(Icons.check_circle_outline, size: 18),
//                                        Text("签到", style: TextStyle(fontSize: 13))
//                                      ],
//                                    ),
//                                  ),
//                                )
//                              ],
//                            ),
//                          )
//                        ],
//                      ),
//                    )
//                  ],
//                ),
//        );
//      });

//  get actionMenu1 => Container(
//        color: Colors.white,
//        padding: EdgeInsets.all(10),
//        child: Row(
//          children: _menus1
//              .map(
//                (menu) => Expanded(
//                  child: InkWell(
//                    onTap: menu.click,
//                    child: Container(
//                      padding: EdgeInsets.all(10),
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          Icon(menu.icon, color: Colors.red, size: 25),
//                          SizedBox(height: 6),
//                          Text(menu.title, style: TextStyle(fontSize: 12)),
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
//              )
//              .toList(),
//        ),
//      );
//
//  get actionMenu2 => Container(
//        color: Colors.white,
//        child: Column(
//          children: _menus2
//              .map(
//                (menu) => InkWell(
//                  onTap: menu.click,
//                  child: Container(
//                    padding: EdgeInsets.only(left: 30),
//                    height: 50,
//                    child: Row(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.center,
//                      children: <Widget>[Icon(menu.icon, size: 20), SizedBox(width: 30), Text(menu.title)],
//                    ),
//                  ),
//                ),
//              )
//              .toList(),
//        ),
//      );

  @override
  bool get wantKeepAlive => true;
}
