import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/hive_boxes.dart';
import 'package:light_listen/provider/settings_provider.dart';
import 'package:provider/provider.dart';

class SettingUtils {
  static final String spBrightnessDark = "theme_brightness";
  static final String spAMOLEDDark = "theme_AMOLEDDark";
  static final String spColorThemeIndex = "theme_colorThemeIndex";
  static final String spBrightnessPlatform = "theme_brightness_platform";

  static final String spSettingFontScale = "setting_font_scale";

  /// 获取设置的主题色
  static int getColorThemeIndex() {
    final _box = HiveBoxes.settingsBox;
    return _box.get(spColorThemeIndex) ?? 0;
  }

  /// 获取设置的夜间模式
  static bool getBrightnessDark() {
    final _box = HiveBoxes.settingsBox;
    return _box.get(spBrightnessDark) ?? false;
  }

  /// 获取设置的跟随系统夜间模式
  static bool getBrightnessPlatform() {
    final _box = HiveBoxes.settingsBox;
    return _box?.get(spBrightnessPlatform) ?? true;
  }

  /// 设置选择的主题色
  static Future setColorTheme(int colorThemeIndex) async {
    final _box = HiveBoxes.settingsBox;
    await _box.put(spColorThemeIndex, colorThemeIndex);
  }

  /// 设置选择的夜间模式
  static Future setBrightnessDark(bool isDark) async {
    final _box = HiveBoxes.settingsBox;
    await _box.put(spBrightnessDark, isDark);
  }

  /// 设置跟随系统的夜间模式
  static Future setBrightnessPlatform(bool isFollowPlatform) async {
    final _box = HiveBoxes.settingsBox;
    await _box.put(spBrightnessPlatform, isFollowPlatform);
  }

  /// 获取字体缩放设置
  static double getFontScale() {
    final _box = HiveBoxes.settingsBox;
    final _provider = Provider.of<SettingsProvider>(currentContext, listen: false);
    final scale = _box?.get(spSettingFontScale) ?? _provider.fontScale;
    return scale;
  }

  /// 设置字体缩放
  static Future<Null> setFontScale(double scale) async {
    final _box = HiveBoxes.settingsBox;
    final _provider = Provider.of<SettingsProvider>(currentContext, listen: false);
    _provider.fontScale = scale;
    await _box.put(spSettingFontScale, scale);
  }

  /// 获取设置的AMOLED夜间模式
  static bool getAMOLEDDark() {
    final _box = HiveBoxes.settingsBox;
    return _box.get(spAMOLEDDark) ?? false;
  }

  /// 设置AMOLED夜间模式
  static Future setAMOLEDDark(bool isAMOLEDDark) async {
    final _box = HiveBoxes.settingsBox;
    await _box.put(spAMOLEDDark, isAMOLEDDark);
  }
}
