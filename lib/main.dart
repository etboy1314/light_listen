import 'dart:io';

import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/hive_boxes.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/light_listen_route_helper.dart';
import 'package:light_listen/page/other/splash_page.dart';
import 'package:light_listen/provider/providers.dart';
import 'package:light_listen/provider/settings_provider.dart';
import 'package:light_listen/provider/themes_provider.dart';
import 'package:light_listen/utils/net_util.dart';
import 'package:light_listen/utils/sp_util.dart';
import 'package:light_listen/widget/no_scale_text_widget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }
  await HiveBoxes.init();
  await SpUtil.init();
  await NetUtil.init();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  ));
  runApp(LightListenApp());
}

class LightListenApp extends StatefulWidget {
  @override
  _LightListenAppState createState() => _LightListenAppState();
}

class _LightListenAppState extends State<LightListenApp> {
  Brightness get _platformBrightness => Screens.mediaQuery.platformBrightness ?? Brightness.light;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      position: ToastPosition.bottom,
      backgroundColor: Colors.white,
      textStyle: TextStyle(color: Colors.black, fontSize: 12),
      child: MultiProvider(
        providers: providers,
        child: Consumer2<ThemesProvider, SettingsProvider>(builder: (_, themesProvider, settingsProvider, __) {
          bool isDark =
              themesProvider.platformBrightness ? _platformBrightness == Brightness.dark : themesProvider.dark;
          final theme = isDark ? themesProvider.darkTheme : themesProvider.lightTheme;
          return AnnotatedRegion(
            value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
            child: Theme(
              data: theme,
              child: MaterialApp(
                navigatorKey: navigatorKey,
                builder: (c, w) {
                  ScreenUtil.instance = ScreenUtil.getInstance()
                    ..allowFontScaling = false
                    ..init(c);
                  return w;
                },
                title: 'lightlisten',
                theme: theme,
                navigatorObservers: [
                  FFNavigatorObserver(routeChange: (name) {
                    //you can track page here
                    print(name);
                  }, showStatusBarChange: (bool showStatusBar) {
                    if (showStatusBar) {
                      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
                      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
                    } else {
                      SystemChrome.setEnabledSystemUIOverlays([]);
                    }
                  })
                ],
                initialRoute: "lightlisten://splash",
                onGenerateRoute: (RouteSettings settings) {
                  var routeResult = getRouteResult(name: settings.name, arguments: settings.arguments);

                  if (routeResult.showStatusBar != null || routeResult.routeName != null) {
                    settings = FFRouteSettings(
                        arguments: settings.arguments,
                        name: settings.name,
                        isInitialRoute: settings.isInitialRoute,
                        routeName: routeResult.routeName,
                        showStatusBar: routeResult.showStatusBar);
                  }
                  var page = routeResult.widget ?? SplashPage();

                  switch (routeResult.pageRouteType) {
                    case PageRouteType.material:
                      return MaterialPageRoute(settings: settings, builder: (c) => page);
                    case PageRouteType.cupertino:
                      return CupertinoPageRoute(settings: settings, builder: (c) => page);
                    case PageRouteType.transparent:
                      return FFTransparentPageRoute(
                          settings: settings,
                          pageBuilder: (BuildContext context, Animation<double> animation,
                                  Animation<double> secondaryAnimation) =>
                              page);
                    default:
                      return Platform.isIOS
                          ? CupertinoPageRoute(settings: settings, builder: (c) => page)
                          : MaterialPageRoute(settings: settings, builder: (c) => page);
                  }
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
