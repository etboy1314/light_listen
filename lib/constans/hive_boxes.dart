///
/// [Author] Alex (https://github.com/AlexVincent525)
/// [Date] 2019-12-01 19:34
///
import
'package:hive/hive.dart';
import 'package:oktoast/oktoast.dart';

class HiveBoxes {
  static Box<dynamic> settingsBox;

  static init() async {
    settingsBox = await Hive.openBox<dynamic>('light_listen_app_settings');
  }

  static clearBoxes() async {
    await settingsBox?.clear();
    showToast("Boxes all cleared.");
  }
}
