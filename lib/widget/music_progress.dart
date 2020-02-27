import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/provider/music_player_manager.dart';

class MusicProgressWidget extends StatelessWidget {
  final MusicPlayerManager player;

  MusicProgressWidget(this.player);

  @override
  Widget build(BuildContext context) {
    print('SongProgressWidget build');
    return StreamBuilder<String>(
      stream: player.curPositionStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var totalTime = snapshot.data.substring(snapshot.data.indexOf('-') + 1);
          var curTime = double.parse(snapshot.data.substring(0, snapshot.data.indexOf('-')));
          var curTimeStr = DateUtil.formatDateMs(curTime.toInt(), format: "mm:ss");
          return buildProgress(curTime, totalTime, curTimeStr);
        } else {
          var totalTime = player.curMusicPlayingPosition.substring(player.curMusicPlayingPosition.indexOf('-') + 1);
          var curTime =
              double.parse(player.curMusicPlayingPosition.substring(0, player.curMusicPlayingPosition.indexOf('-')));
          var curTimeStr = DateUtil.formatDateMs(curTime.toInt(), format: "mm:ss");
          return buildProgress(curTime, totalTime, curTimeStr);
        }
      },
    );
  }

  Widget buildProgress(double curTime, String totalTime, String curTimeStr) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            curTimeStr,
            style: TextStyle(color: Colors.white38, fontSize: 10.0),
          ),
          Expanded(
            child: SliderTheme(
              data: SliderThemeData(
                  trackHeight: 1.0,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 3.0),
                  showValueIndicator: ShowValueIndicator.always,
                  valueIndicatorTextStyle: TextStyle(color: Colors.black54, fontSize: 12.0)),
              child: Slider(
                label: curTime.toString(),
                value: curTime,
                onChanged: (data) {
                  player.sinkProgress(data.toInt());
                },
                onChangeStart: (data) {
                  player.pausePlay();
                },
                onChangeEnd: (data) {
                  player.seekPlay(data.toInt());
                },
                activeColor: Colors.white,
                inactiveColor: Colors.white38,
                min: 0,
                max: double.parse(totalTime),
              ),
            ),
          ),
          Text(DateUtil.formatDateMs(int.parse(totalTime), format: "mm:ss"),
              style: TextStyle(color: Colors.white38, fontSize: 10.0)),
        ],
      ),
    );
  }
}
