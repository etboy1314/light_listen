import 'package:flutter/foundation.dart';
import 'package:light_listen/provider/data_provider.dart';
import 'package:light_listen/provider/music_player_manager.dart';
import 'package:light_listen/provider/settings_provider.dart';
import 'package:light_listen/provider/themes_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

ChangeNotifierProvider<T> buildProvider<T extends ChangeNotifier>(T value) {
  return ChangeNotifierProvider<T>.value(value: value);
}

List<SingleChildWidget> get providers => _providers;

final _providers = [
  buildProvider<SettingsProvider>(SettingsProvider()..init()),
  buildProvider<ThemesProvider>(ThemesProvider()..init()),
  buildProvider<DataProvider>(DataProvider()),
  buildProvider<MusicPlayerManager>(MusicPlayerManager()..init()),
];
