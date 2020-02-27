import 'package:ff_annotation_route/ff_annotation_route.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/provider/settings_provider.dart';
import 'package:light_listen/provider/themes_provider.dart';
import 'package:light_listen/utils/setting_utils.dart';
import 'package:light_listen/widget/fixed_appBar.dart';
import 'package:provider/provider.dart';

@FFRoute(
  name: "lightlisten://font-scale",
  routeName: "font-scale",
  pageRouteType: PageRouteType.material,
)
class FontScalePage extends StatefulWidget {
  @override
  _FontScalePageState createState() => _FontScalePageState();
}

class _FontScalePageState extends State<FontScalePage> with AutomaticKeepAliveClientMixin {
  final baseFontSize = 24.0;
  SettingsProvider settingsProvider;

  List<double> scaleRange;
  double scale;

  @override
  void initState() {
    settingsProvider = Provider.of<SettingsProvider>(currentContext, listen: false);
    scaleRange = settingsProvider.fontScaleRange;
    scale = settingsProvider.fontScale;

    super.initState();
  }

  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ThemesProvider>(
      builder: (_, provider, __) {
        return WillPopScope(
          onWillPop: () async {
            await SettingUtils.setFontScale(scale);
            return true;
          },
          child: Scaffold(
            body: Column(
              children: <Widget>[
                FixedAppBar(
                  title: Text(
                    "调节字体大小",
                    style: Theme.of(context).textTheme.title.copyWith(fontSize: suSetSp(23.0)),
                  ),
                  elevation: 0.0,
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      "这是一行示例文字\nThis is a sample sentence",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: suSetSp(baseFontSize, scale: scale)),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: Screens.bottomSafeHeight),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "小",
                                  style: TextStyle(
                                    fontSize: suSetSp(baseFontSize, scale: scaleRange[0]),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  "标准",
                                  style: TextStyle(
                                    fontSize: suSetSp(
                                      baseFontSize,
                                      scale: (scaleRange[0] + scaleRange[1]) / 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "大",
                                  style: TextStyle(
                                    fontSize: suSetSp(baseFontSize, scale: scaleRange[1]),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Slider(
                        min: scaleRange[0],
                        max: scaleRange[1],
                        divisions: 8,
                        activeColor: currentThemeColor,
                        inactiveColor: currentThemeColor.withAlpha(50),
                        value: scale,
                        onChanged: (double value) {
                          setState(() {
                            scale = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
