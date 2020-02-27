import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/constans/screens.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/provider/data_provider.dart';
import 'package:light_listen/provider/themes_provider.dart';
import 'package:light_listen/widget/platform_progress_indicator.dart';
import 'package:light_listen/widget/rounded_check_box.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:ff_annotation_route/ff_annotation_route.dart';

@FFRoute(
  name: "lightlisten://login",
  routeName: "login",
  pageRouteType: PageRouteType.material,
)
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AutomaticKeepAliveClientMixin {
  final _formKey = GlobalKey<FormState>();
  final _formScrollController = ScrollController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final colorGradient = const <Color>[Color(0xffff8976), Color(0xffff3c33)];

  String _username = "", _password = "";

  bool _agreement = false;
  bool _login = false;
  bool _loginDisabled = true;
  bool _isObscure = true;
  bool _usernameCanClear = false;
  bool _keyboardAppeared = false;

  bool get loginButtonEnable => !(_login || _loginDisabled);

  Color _defaultIconColor = Colors.grey;

  @override
  void initState() {
    _usernameController
      ..addListener(() {
        _username = _usernameController.text;
        if (this.mounted) {
          if (_usernameController.text.length > 0 && !_usernameCanClear) {
            setState(() {
              _usernameCanClear = true;
            });
          } else if (_usernameController.text.length == 0 && _usernameCanClear) {
            setState(() {
              _usernameCanClear = false;
            });
          }
        }
      });
    _passwordController
      ..addListener(() {
        _password = _passwordController.text;
      });
    super.initState();
  }

  @override
  void dispose() {
    _usernameController?.dispose();
    _passwordController?.dispose();
    super.dispose();
  }

  int last = 0;

  Future<bool> doubleBackExit() {
    int now = DateTime.now().millisecondsSinceEpoch;
    if (now - last > 800) {
      showToast("再按一次退出应用");
      last = DateTime.now().millisecondsSinceEpoch;
      return Future.value(false);
    } else {
      dismissAllToast();
      return Future.value(true);
    }
  }

  Widget get bottomBackground => Positioned(
        left: 0.0,
        right: 0.0,
        bottom: 0.0,
        child: Center(
          child: Image.asset(
            "images/logo.png",
            color: Colors.grey.withAlpha(50),
            width: Screens.width - suSetWidth(150.0),
            fit: BoxFit.fitWidth,
          ),
        ),
      );

  Widget get logo => Positioned(
        right: suSetWidth(40.0),
        top: suSetHeight(50.0),
        child: Hero(
          tag: "Logo",
          child: Image.asset(
            "images/logo.png",
            color: Theme.of(context).primaryColor,
            width: suSetWidth(120.0),
            height: suSetHeight(120.0),
          ),
        ),
      );

  Widget get logoTitle => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        textBaseline: TextBaseline.ideographic,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                  top: suSetHeight(10.0),
                  left: suSetWidth(6.0),
                  right: suSetWidth(6.0),
                ),
                child: Text(
                  "light listen",
                  style: TextStyle(
                    color: Theme.of(context).iconTheme.color,
                    fontSize: suSetSp(50.0),
                    fontFamily: "chocolate",
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Widget get usernameTextField => TextFormField(
        controller: _usernameController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: Theme.of(context).iconTheme.color,
            size: suSetWidth(24.0),
          ),
          suffixIcon: _usernameCanClear
              ? IconButton(
                  icon: Icon(
                    Icons.clear,
                    color: Theme.of(context).iconTheme.color,
                    size: suSetWidth(28.0),
                  ),
                  onPressed: _usernameController.clear,
                )
              : null,
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: defaultColor),
          ),
          contentPadding: EdgeInsets.all(suSetWidth(12.0)),
          labelText: '手机号',
          labelStyle: TextStyle(
            color: Theme.of(context).textTheme.title.color,
          ),
        ),
        style: TextStyle(
          color: Theme.of(context).textTheme.title.color,
          fontSize: suSetSp(22.0),
        ),
        strutStyle: StrutStyle(
          fontSize: suSetSp(22.0),
          height: 1.7,
          forceStrutHeight: true,
        ),
        cursorColor: defaultColor,
        onSaved: (String value) => _username = value,
        validator: (String value) {
          if (value.isEmpty) return '请输入手机号';
          return null;
        },
        keyboardType: TextInputType.number,
        enabled: !_login,
      );

  Widget get passwordTextField => TextFormField(
        controller: _passwordController,
        onSaved: (String value) => _password = value,
        obscureText: _isObscure,
        validator: (String value) {
          if (value.isEmpty) return '请输入密码';
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: defaultColor,
            ),
          ),
          contentPadding: EdgeInsets.all(suSetWidth(12.0)),
          prefixIcon: Icon(
            Icons.lock,
            color: Theme.of(context).iconTheme.color,
            size: suSetWidth(24.0),
          ),
          labelText: '密码',
          labelStyle: TextStyle(
            color: Theme.of(context).textTheme.title.color,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility_off : Icons.visibility,
              color: _defaultIconColor,
              size: suSetWidth(28.0),
            ),
            onPressed: () {
              setState(() {
                _isObscure = !_isObscure;
                _defaultIconColor = _isObscure ? Colors.grey : defaultColor;
              });
            },
          ),
        ),
        style: TextStyle(
          color: Theme.of(context).textTheme.title.color,
          fontSize: suSetSp(22.0),
        ),
        strutStyle: StrutStyle(
          fontSize: suSetSp(18.0),
          height: 1.7,
          forceStrutHeight: true,
        ),
        cursorColor: defaultColor,
        enabled: !_login,
      );

  Widget get registerButton => Padding(
        padding: EdgeInsets.zero,
        child: Align(
          alignment: Alignment.center,
          child: FlatButton(
            padding: EdgeInsets.zero,
            child: Text(
              '立即注册',
              style: TextStyle(
                color: Colors.grey,
                fontSize: suSetSp(18.0),
              ),
            ),
            onPressed: () {
              navigatorState.pushNamed(Routes.LIGHTLISTEN_SETTINGS);
            },
          ),
        ),
      );

  Widget get forgetPasswordButton => Padding(
        padding: EdgeInsets.zero,
        child: Align(
          alignment: Alignment.center,
          child: FlatButton(
            padding: EdgeInsets.zero,
            child: Text(
              '忘记密码',
              style: TextStyle(
                color: Colors.grey,
                fontSize: suSetSp(18.0),
              ),
            ),
            onPressed: () {
              navigatorState.pushNamed(Routes.LIGHTLISTEN_SETTINGS);
            },
          ),
        ),
      );

  Widget get userAgreementCheckbox => Expanded(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox.fromSize(
              size: Size.square(suSetWidth(42.0)),
              child: RoundedCheckbox(
                value: _agreement,
                activeColor: defaultColor,
                inactiveColor: Theme.of(context).iconTheme.color,
                onChanged: !_login
                    ? (value) {
                        setState(() {
                          _agreement = value;
                        });
                        validateForm();
                      }
                    : null,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: "登录即代表您同意",
                        style: TextStyle(
                          color: Theme.of(context).textTheme.title.color,
                        )),
                    TextSpan(
                      text: "《用户协议》",
                      style: TextStyle(
                        color: defaultColor,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          navigatorState.pushNamed(Routes.LIGHTLISTEN_SETTINGS);
                        },
                    ),
                  ],
                  style: TextStyle(color: Colors.black, fontSize: suSetSp(18.0)),
                ),
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      );

  Widget get loginButton => GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: loginButtonEnable ? loginButtonPressed : null,
        child: Container(
          margin: EdgeInsets.only(left: suSetWidth(4.0)),
          width: suSetWidth(100.0),
          height: suSetHeight(50.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(suSetWidth(6.0)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  blurRadius: suSetWidth(10.0),
                  color: !_loginDisabled ? colorGradient[1].withAlpha(100) : Colors.grey[400],
                  offset: Offset(0.0, suSetHeight(10.0)),
                ),
              ],
              gradient: LinearGradient(
                colors: !_loginDisabled ? colorGradient : [Colors.grey, Colors.grey],
              )),
          child: Center(
            child: !_login
                ? Icon(Icons.arrow_forward, size: suSetWidth(36.0), color: Colors.white)
                : SizedBox.fromSize(
                    size: Size.square(suSetWidth(32.0)),
                    child: PlatformProgressIndicator(strokeWidth: 3.0, color: Colors.white),
                  ),
          ),
        ),
      );

  Widget get loginForm => SafeArea(
        child: Form(
          key: _formKey,
          child: Align(
            alignment: _keyboardAppeared ? Alignment.bottomCenter : Alignment.center,
            child: ListView(
              shrinkWrap: true,
              controller: _formScrollController,
              padding: EdgeInsets.symmetric(horizontal: suSetWidth(50.0)),
              physics: NeverScrollableScrollPhysics(parent: ClampingScrollPhysics()),
              children: <Widget>[
                logoTitle,
                SizedBox(height: suSetHeight(40.0)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: suSetWidth(10.0),
                    vertical: suSetHeight(10.0),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(suSetWidth(6.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        blurRadius: suSetWidth(20.0),
                        color: Theme.of(context).dividerColor,
                      ),
                    ],
                    color: Theme.of(context).cardColor,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      usernameTextField,
                      SizedBox(height: suSetHeight(10.0)),
                      passwordTextField,
                      SizedBox(height: suSetHeight(10.0)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[registerButton, forgetPasswordButton],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: suSetHeight(20.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[userAgreementCheckbox, loginButton],
                  ),
                ),
                SizedBox(height: suSetHeight(30.0)),
              ],
            ),
          ),
          onChanged: validateForm,
        ),
      );

  void loginButtonPressed() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      setState(() {
        _login = true;
      });
      Provider.of<DataProvider>(context, listen: false).loginWithPhone(_username, _password).then((result) {
        print(result);
        if (result) {
          navigatorState.pushNamedAndRemoveUntil(Routes.LIGHTLISTEN_HOME, (_) => false);
        } else {
          _login = false;
          if (mounted) setState(() {});
        }
      }).catchError((e) {
        _login = false;
        if (mounted) setState(() {});
      });
    }
  }

  void validateForm() {
    if (_username != "" && _password != "" && _agreement && _loginDisabled) {
      setState(() {
        _loginDisabled = false;
      });
    } else if (_username == "" || _password == "" || !_agreement) {
      setState(() {
        _loginDisabled = true;
      });
    }
  }

  void setAlignment(context) {
    final double inputMethodHeight = MediaQuery.of(context).viewInsets.bottom;
    if (inputMethodHeight > 1.0 && !_keyboardAppeared) {
      setState(() {
        _keyboardAppeared = true;
      });
    } else if (inputMethodHeight <= 1.0 && _keyboardAppeared) {
      setState(() {
        _keyboardAppeared = false;
      });
    }
  }

  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    setAlignment(context);
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark,
      child: WillPopScope(
        onWillPop: doubleBackExit,
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          body: Stack(
            children: <Widget>[
              bottomBackground,
              loginForm,
            ],
          ),
          resizeToAvoidBottomInset: true,
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
