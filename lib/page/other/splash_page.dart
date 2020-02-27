import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/utils/sp_util.dart';
import 'package:light_listen/widget/platform_progress_indicator.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
  name: "lightlisten://splash",
  routeName: "splash",
  pageRouteType: PageRouteType.material,
)
class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with AutomaticKeepAliveClientMixin {
  bool isInLoginProcess = false;
  bool isUserLogin = SpUtil.hasUser;
  bool showLoading = false;
  Timer _loginTimer;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _loginTimer = Timer(Duration(seconds: 3), () {
        navigate();
        print("time over");
      });
    });
    super.initState();
  }

  Future navigate() async {
    navigatorState.pushNamedAndRemoveUntil(
      isUserLogin ? Routes.LIGHTLISTEN_HOME : Routes.LIGHTLISTEN_LOGIN,
      (_) => false,
    );
  }

  @override
  void dispose() {
    _loginTimer?.cancel();
    super.dispose();
  }

  Widget get loginWidget => Column(
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                bottom: suSetHeight(10.0),
              ),
              child: Center(
                child: SizedBox.fromSize(
                  size: Size.square(suSetWidth(36.0)),
                  child: PlatformProgressIndicator(
                    radius: suSetWidth(20.0),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            child: Center(
              child: Text(
                "正在登录",
                style: TextStyle(color: Colors.white, fontSize: suSetSp(20.0)),
              ),
            ),
          ),
        ],
      );

//  Widget get warningWidget => Column(
//        children: <Widget>[
//          Expanded(
//            child: Container(
//              margin: EdgeInsets.only(
//                bottom: suSetHeight(10.0),
//              ),
//              child: Center(
//                child: Icon(Icons.warning,
//                    color: Colors.white, size: suSetWidth(36.0)),
//              ),
//            ),
//          ),
//          SizedBox(
//            height: suSetHeight(26.0),
//            child: Center(
//              child: Text(
//                "请检查联网状态",
//                style: TextStyle(color: Colors.white, fontSize: suSetSp(24.0)),
//              ),
//            ),
//          ),
//        ],
//      );

  Widget get logo => Container(
        width: Screens.width,
        margin: EdgeInsets.all(suSetWidth(30.0)),
        child: Hero(
          tag: "Logo",
          child: Image.asset(
            "images/logo_title.png",
            width: suSetWidth(200.0),
            height: suSetHeight(200.0),
//            color: currentIsDark ? currentThemeColor : Colors.white,
          ),
        ),
      );

  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: currentIsDark ? Theme.of(context).scaffoldBackgroundColor : currentThemeColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            logo,
            SizedBox(
              height: suSetHeight(isUserLogin != null ? 80.0 : 0.0),
              child: isUserLogin ? loginWidget : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
