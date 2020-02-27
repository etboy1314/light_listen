///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2020-01-13 16:52
///
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/hive_boxes.dart';
import 'package:light_listen/utils/setting_utils.dart';

class SettingsProvider extends ChangeNotifier {
  final List<double> fontScaleRange = [0.6, 1.4];
  double _fontScale = 1.0;

  double get fontScale => _fontScale;

  set fontScale(double value) {
    _fontScale = value;
    notifyListeners();
  }

  void init() {
    final _box = HiveBoxes.settingsBox;
    _fontScale = _box?.get(SettingUtils.spSettingFontScale) ?? _fontScale;
  }

  void reset() {
    _fontScale = 1.0;
  }
}
