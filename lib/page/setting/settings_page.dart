import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/provider/themes_provider.dart';
import 'package:provider/provider.dart';

@FFRoute(
  name: "lightlisten://settings",
  routeName: "settings",
  pageRouteType: PageRouteType.material,
)
class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with AutomaticKeepAliveClientMixin {
  final List<Map<String, dynamic>> settingItemInfos = [
    {
      "icon": "follow_system",
      "name": "跟随系统夜间模式",
      "description": "夜间模式将跟随系统主题切换",
    },
    {
      "icon": "night_mode",
      "name": "夜间模式",
      "description": "减轻眩光，提升夜间使用体验",
    },
    {
      "icon": "amoled_black",
      "name": "A屏黑",
      "description": "更深的背景颜色，节省电量",
    },
    {
      "icon": "theme_color",
      "name": "切换主题",
      "description": "多彩颜色，丰富你的界面",
      "route": Routes.LIGHTLISTEN_THEME,
    },
    {
      "icon": "font_size",
      "name": "字体大小调节",
      "description": "调整字体大小以获得最佳阅读体验",
      "route": Routes.LIGHTLISTEN_FONT_SCALE,
    },
  ];

  double get iconSize => 36.0;

  Widget settingItem({context, index}) {
    List<Widget> switchWidgets = [
      Consumer<ThemesProvider>(
        builder: (_, provider, __) {
          return PlatformSwitch(
            activeColor: currentThemeColor,
            value: provider.platformBrightness,
            onChanged: (bool value) {
              provider.platformBrightness = value;
            },
          );
        },
      ),
      Consumer<ThemesProvider>(
        builder: (_, provider, __) {
          return PlatformSwitch(
            activeColor: currentThemeColor,
            value: provider.dark,
            onChanged: !provider.platformBrightness
                ? (bool value) {
                    provider.dark = value;
                  }
                : null,
          );
        },
      ),
      Consumer<ThemesProvider>(
        builder: (_, provider, __) {
          return PlatformSwitch(
            activeColor: currentThemeColor,
            value: provider.AMOLEDDark,
            onChanged: Theme.of(context).brightness == Brightness.dark
                ? (bool value) {
                    provider.AMOLEDDark = value;
                    if (mounted) setState(() {});
                  }
                : null,
          );
        },
      ),
      null,
      null
    ];
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: suSetSp(14.0)),
        child: Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: suSetWidth(iconSize / 2)),
              child: SvgPicture.asset(
                "images/settings/${settingItemInfos[index]['icon']}.svg",
                width: suSetWidth(iconSize),
                height: suSetWidth(iconSize),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${settingItemInfos[index]["name"]}",
                    style: TextStyle(fontSize: suSetSp(20.0)),
                  ),
                  Text(
                    "${settingItemInfos[index]["description"]}",
                    style: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: suSetSp(16.0),
                        ),
                  ),
                ],
              ),
            ),
            if (switchWidgets[index] != null) switchWidgets[index],
          ],
        ),
      ),
      onTap: () {
        if (settingItemInfos[index]['route'] != null) {
          navigatorState.pushNamed(settingItemInfos[index]['route']);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ThemesProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          body: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: suSetWidth(40.0),
                  ),
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "个性化",
                          style: Theme.of(context).textTheme.title.copyWith(
                                fontSize: suSetSp(30.0),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        Text(
                          "管理您的应用偏好设置",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                fontSize: suSetSp(20.0),
                              ),
                        ),
                        SizedBox(height: 10.0),
                      ],
                    ),
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: settingItemInfos.length,
                      itemBuilder: (context, index) => settingItem(
                        context: context,
                        index: index,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
