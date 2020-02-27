import 'package:flutter/material.dart';
import 'package:light_listen/provider/music_player_manager.dart';
import 'package:light_listen/utils/common_util.dart';
import 'package:light_listen/utils/net_util.dart';
import 'package:light_listen/widget/widget_lyric.dart';

class LyricPage extends StatefulWidget {
  @override
  _LyricPageState createState() => _LyricPageState();

  final MusicPlayerManager player;

  LyricPage(this.player);
}

class _LyricPageState extends State<LyricPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  var id;
  String lyricStr;
  List<LyricData> lyrics;
  LyricWidget _lyricWidget;
  AnimationController _lyricOffsetYController;

  @override
  void initState() {
    super.initState();
    requestData();
  }

  requestData() async {
    id = widget.player.curMusic.id;
    var map = await NetUtil.getLyric(id);
    lyricStr = map['lrc']['lyric'];
    lyrics = CommonUtils.formatLyric(lyricStr);
    _lyricWidget = LyricWidget(lyrics, 0);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (id != widget.player.curMusic.id) {
      setState(() {
        lyricStr = null;
        requestData();
      });
    }
    return lyricStr == null
        ? Center(child: Text("歌词加载中"))
        : Container(
            margin: EdgeInsets.all(20.0),
            child: StreamBuilder<String>(
              stream: widget.player.curPositionStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var curTime = double.parse(snapshot.data.substring(0, snapshot.data.indexOf('-')));
                  // 获取当前在哪一行
                  int curLine = CommonUtils.findLyricIndex(curTime, lyrics);
                  if (!_lyricWidget.isDragging) {
                    startLineAnim(curLine);
                  }
                  // 给 customPaint 赋值当前行
                  _lyricWidget.curLine = curLine;
                  return CustomPaint(
                    painter: _lyricWidget,
                  );
                } else {
                  return Container();
                }
              },
            ),
          );
  }

  @override
  bool get wantKeepAlive => true;

  /// 开始下一行动画
  void startLineAnim(int curLine) {
    // 判断当前行和 customPaint 里的当前行是否一致，不一致才做动画
    if (_lyricWidget.curLine != curLine) {
      // 如果动画控制器不是空，那么则证明上次的动画未完成，
      // 未完成的情况下直接 stop 当前动画，做下一次的动画
      if (_lyricOffsetYController != null) {
        _lyricOffsetYController.stop();
      }

      // 初始化动画控制器，切换歌词时间为300ms，并且添加状态监听，
      // 如果为 completed，则消除掉当前controller，并且置为空。
      _lyricOffsetYController = AnimationController(vsync: this, duration: Duration(milliseconds: 300))
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _lyricOffsetYController.dispose();
            _lyricOffsetYController = null;
          }
        });
      // 计算出来当前行的偏移量
      var end = _lyricWidget.computeScrollY(curLine) * -1;
      // 起始为当前偏移量，结束点为计算出来的偏移量
      Animation animation = Tween<double>(begin: _lyricWidget.offsetY, end: end).animate(_lyricOffsetYController);
      // 添加监听，在动画做效果的时候给 offsetY 赋值
      _lyricOffsetYController.addListener(() {
        _lyricWidget.offsetY = animation.value;
      });
      // 启动动画
      _lyricOffsetYController.forward();
    }
  }
}
