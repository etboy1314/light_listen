import 'package:flutter/foundation.dart';
import 'package:light_listen/model/common/album.dart';
import 'package:light_listen/model/dailymusic/daily_music.dart';
import 'package:light_listen/model/find/banner.dart';
import 'package:light_listen/model/find/daily_music_list.dart';
import 'package:light_listen/model/user.dart';
import 'package:light_listen/model/user_music_list.dart';
import 'package:light_listen/utils/net_util.dart';
import 'package:light_listen/utils/sp_util.dart';
import 'package:oktoast/oktoast.dart';

class DataProvider extends ChangeNotifier {
  User _user;
  List<UserMusicList> _userTotalMusicLists = [];
  List<UserMusicList> _userCreateMusicLists = [];
  List<UserMusicList> _userCollectMusicLists = [];
  List<DailyMusic> _dailyMusics = [];
  List<MyBanner> _banners = [];
  List<DailyMusicList> _dailyMusicLists = [];
  List<Album> _albums = [];

  Future<bool> loginWithPhone(number, password) async {
    Map map = await NetUtil.loginWithPhone(number, password);
    print(map.toString());
    if (map == null) {
      showToast("登录失败");
      return false;
    } else {
      var id = map['account']['id'];
      if (id == null) {
        showToast("登录失败");
        return false;
      } else
        return await SpUtil.setUser(id.toString());
    }
  }

  getUserDetail() async {
    String id = SpUtil.userId;
    var map = await NetUtil.getUserDetail(id);
    user = User.fromMap(map);
    return user;
  }

  getUserPlayList() async {
    List<UserMusicList> _totalPlaylist = [];
    List<UserMusicList> _myPlaylist = [];
    List<UserMusicList> _collectPlaylist = [];

    String id = SpUtil.userId;
    if (id.isEmpty) return false;
    var map = await NetUtil.getUserPlaylist(id);
    if (map == null) return false;
    for (int i = 0; i < map['playlist'].length; i++) _totalPlaylist.add(UserMusicList.fromMap(map['playlist'][i]));
    _totalPlaylist.forEach((i) {
      if (i.creator.userId.toString() == id) {
        _myPlaylist.add(i);
      } else
        _collectPlaylist.add(i);
    });
    userTotalMusicLists = _totalPlaylist;
    userCreateMusicLists = _myPlaylist;
    userCollectMusicLists = _collectPlaylist;
    print(userCreateMusicLists.length);
    return true;
  }

  getBanner() async {
    var map = await NetUtil.getBanner(2);
    List<MyBanner> list = [];
    for (int i = 0; i < map['banners'].length; i++) {
      list.add(MyBanner.fromJsonMap(map['banners'][i]));
    }
    banners = list;
    return banners;
  }

  getDailyMusicList() async {
    var map = await NetUtil.getRecommendResource();
    List<DailyMusicList> list = [];
    for (int i = 0; i < map['recommend'].length; i++) {
      list.add(DailyMusicList.fromJsonMap(map['recommend'][i]));
    }
    dailyMusicLists = list;
    return dailyMusicLists;
  }

  getNewAlbum() async {
    var map = await NetUtil.getNewAlbum();
    List<Album> list = [];
    for (int i = 0; i < map['albums'].length; i++) {
      list.add(Album.fromJsonMap(map['albums'][i]));
    }
    albums = list;
    return albums;
  }

  getDailyMusic() async {
    var map = await NetUtil.getDailyMusic();
    List<DailyMusic> list = [];
    for (int i = 0; i < map['recommend'].length; i++) {
      list.add(DailyMusic.fromJsonMap(map['recommend'][i]));
    }
    dailyMusics = list;
    return dailyMusics;
  }

  getLikedMusicData() async {
    var map = await NetUtil.getLikedMusic(SpUtil.userId);
    print(map);
//    List<DailyMusic> list = [];
//    for (int i = 0; i < map['recommend'].length; i++) {
//      list.add(DailyMusic.fromJsonMap(map['recommend'][i]));
//    }
//    dailyMusics = list;
//    return dailyMusics;
  }

  User get user => _user;

  set user(User value) {
    _user = value;
    notifyListeners();
  }

  List<UserMusicList> get userTotalMusicLists => _userTotalMusicLists;

  set userTotalMusicLists(List<UserMusicList> value) {
    _userTotalMusicLists = value;
    notifyListeners();
  }

  List<UserMusicList> get userCreateMusicLists => _userCreateMusicLists;

  set userCreateMusicLists(List<UserMusicList> value) {
    _userCreateMusicLists = value;
    notifyListeners();
  }

  List<UserMusicList> get userCollectMusicLists => _userCollectMusicLists;

  set userCollectMusicLists(List<UserMusicList> value) {
    _userCollectMusicLists = value;
    notifyListeners();
  }

  List<DailyMusic> get dailyMusics => _dailyMusics;

  set dailyMusics(List<DailyMusic> value) {
    _dailyMusics = value;
    notifyListeners();
  }

  List<MyBanner> get banners => _banners;

  set banners(List<MyBanner> value) {
    _banners = value;
    notifyListeners();
  }

  List<DailyMusicList> get dailyMusicLists => _dailyMusicLists;

  set dailyMusicLists(List<DailyMusicList> value) {
    _dailyMusicLists = value;
    notifyListeners();
  }

  List<Album> get albums => _albums;

  set albums(List<Album> value) {
    _albums = value;
    notifyListeners();
  }
}
