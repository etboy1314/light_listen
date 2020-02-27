import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const app_name = "轻听";
const app_agreement = "同意《用户协议》《隐私政策》《儿童隐私政策》";

NavigatorState get navigatorState => navigatorKey.currentState;

BuildContext get currentContext => navigatorState.context;

Brightness get currentBrightness => Theme.of(currentContext).brightness;

Color get currentThemeColor => Theme.of(currentContext).accentColor;

bool get currentIsDark => currentBrightness == Brightness.dark;

final navigatorKey = GlobalKey<NavigatorState>();

const AppLifecycleState appLifeCycleState = AppLifecycleState.resumed;
