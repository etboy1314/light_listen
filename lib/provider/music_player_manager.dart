import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/light_listen_route_helper.dart';
import 'package:light_listen/model/music.dart';
import 'package:light_listen/utils/net_util.dart';

class MusicPlayerManager with ChangeNotifier {
  AudioPlayer _audioPlayer = AudioPlayer();
  StreamController<String> _curPositionController = StreamController<String>.broadcast();

  List<Music> _musics = [];
  int curIndex = 0;
  Duration curMusicDuration;
  String curMusicPlayingPosition = '0-0';
  AudioPlayerState _curState;

  List<Music> get musics => _musics;

  Music get curMusic => _musics[curIndex];

  Stream<String> get curPositionStream => _curPositionController.stream;

  AudioPlayerState get curState => _curState;

  void init() {
    _audioPlayer.setReleaseMode(ReleaseMode.STOP);
    // 播放状态监听
    _audioPlayer.onPlayerStateChanged.listen((state) {
      _curState = state;

      /// 先做顺序播放
      if (state == AudioPlayerState.COMPLETED) {
        print("COMPLETED");
        nextPlay();
      } else if (state == AudioPlayerState.STOPPED) {
        print("STOPPED");
//        nextPlay();
      }
      // 其实也只有在播放状态更新时才需要通知。
      notifyListeners();
    });
    /*音乐长度*/
    _audioPlayer.onDurationChanged.listen((d) {
      curMusicDuration = d;
    });
    // 当前播放进度监听
    _audioPlayer.onAudioPositionChanged.listen((Duration p) {
//      print('p=${p.inMilliseconds}');
//      print('curSongDuration=${curSongDuration.inMilliseconds}');
      sinkProgress(
          p.inMilliseconds < curMusicDuration.inMilliseconds ? p.inMilliseconds : curMusicDuration.inMilliseconds);
    });
  }

  // 歌曲进度
  void sinkProgress(int m) {
    curMusicPlayingPosition = '$m-${curMusicDuration.inMilliseconds}';
    _curPositionController.sink.add('$m-${curMusicDuration.inMilliseconds}');
  }

  // 播放一首歌
  void playMusic(Music music) {
    _musics.insert(curIndex, music);
    play();
    notifyListeners();
  }

  // 播放很多歌
  void playMusics(List<Music> musics, {int index}) {
    this._musics = musics;
    if (index != null) curIndex = index;
    play();
    notifyListeners();
  }

  // 添加歌曲
  void addMusics(List<Music> musics) {
    this._musics.addAll(musics);
    notifyListeners();
  }

  // 移除所有歌曲
  void removeAllMusics() {
    _audioPlayer.stop();
    this._musics.clear();
    notifyListeners();
  }

  // 移除歌曲
  void removeMusicAt(index) {
    print(index.toString());
    print(curIndex);
    this._musics.removeAt(index);
    if (index < curIndex) {
      curIndex = curIndex - 1;
    } else if (index > curIndex) {
      /**/
    } else if (index == curIndex) {
      play();
    }
    notifyListeners();
  }

  /// 播放
  /// 128000 192000 320000 999000
  void play() async {
    try {
//      _audioPlayer.play("https://music.163.com/song/media/outer/url?id=${this._musics[curIndex].id}.mp3");
      String url = await getMusicUrl(this._musics[curIndex].id, 128000);
      print(url);
      if (url == null)
        nextPlay();
      else
        _audioPlayer.play(url);
    } catch (e) {
      print('异常');
//      if (curIndex <= 0) {
//        curIndex = _musics.length - 1;
//      } else {
//        curIndex--;
//      }
    }
  }

  /// 暂停、恢复
  void togglePlay() {
    if (_audioPlayer.state == AudioPlayerState.PAUSED) {
      resumePlay();
    } else {
      pausePlay();
    }
  }

  void pausePlay() {
    _audioPlayer.pause();
  }

  void seekPlay(int milliseconds) {
    _audioPlayer.seek(Duration(milliseconds: milliseconds));
    resumePlay();
  }

  void resumePlay() {
    _audioPlayer.resume();
  }

  void nextPlay() {
    if (curIndex >= _musics.length) {
      curIndex = 0;
    } else {
      curIndex++;
    }
    notifyListeners();
    play();
  }

  void prePlay() {
    if (curIndex <= 0) {
      curIndex = _musics.length - 1;
    } else {
      curIndex--;
    }
    notifyListeners();
    play();
  }

//  // 保存当前歌曲到本地
//  void saveCurSong() {
//    Application.sp.remove('playing_songs');
//    Application.sp.setStringList('playing_songs', _songs.map((s) => FluroConvertUtils.object2string(s)).toList());
//    Application.sp.setInt('playing_index', curIndex);
//  }

  Future<String> getMusicUrl(id, br) async {
    var map = await NetUtil.getMusicUrl(id, br);
    if (map == null || map['data'] == null || map['data'].length == 0) {
      return null;
    } else {
      print(map['data'][0]['url']);
      return map['data'][0]['url'];
    }
  }

  @override
  void dispose() {
    super.dispose();
    _curPositionController.close();
    _audioPlayer.dispose();
  }
}
