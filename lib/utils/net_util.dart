import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:light_listen/constans/constant.dart';
import 'package:light_listen/light_listen_route.dart';
import 'package:light_listen/utils/sp_util.dart';
import 'package:path_provider/path_provider.dart';

class NetUtil {
  static Dio dio;
  static PersistCookieJar cookieJar;

  static init() async {
    cookieJar = PersistCookieJar(dir: (await getApplicationDocumentsDirectory()).path + '/.cookies/');
    dio = Dio(BaseOptions(baseUrl: base));
    dio.interceptors..add(MyCookieManager(cookieJar))..add(LogInterceptor(requestHeader: false));
  }

  static Future<Map> doGet(String path, {Map<String, dynamic> params}) async {
    Map<String, dynamic> parameters = {'timestamp': DateTime.now().millisecondsSinceEpoch};
    if (params != null) parameters.addEntries(params.entries);
    Response<Map> response = await dio.get(path, queryParameters: parameters);
    return response.data;
  }

  /*登录*/
  static Future<Map> loginWithPhone(String phone, String password) {
    return doGet(login, params: {'phone': phone, 'password': password});
  }

  /*获取用户详情*/
  static Future<Map> getUserDetail(String uid) {
    return doGet(userDetail, params: {'uid': uid});
  }

  /*用户歌单*/
  static Future<Map> getUserPlaylist(String uid) {
    return doGet(userPlaylist, params: {'uid': uid});
  }

  /*获取banner*/
  static Future<Map> getBanner(num type) {
    return doGet(banner, params: {"type": type});
  }

  /*每日推荐歌单*/
  static Future<Map> getRecommendResource() {
    return doGet(recommendResource);
  }

  /*获取新碟*/
  static Future<Map> getTop12Album() {
    return doGet(topAlbum, params: {"offset": 0, "limit": 12});
  }

  /*获取发现页新碟数据*/
  static Future<Map> getNewAlbum() {
    return doGet(newAlbum);
  }

  /*每日推荐歌曲*/
  static Future<Map> getDailyMusic() {
    return doGet(recommendSongs);
  }

  /*真实播放地址*/
  static Future<Map> getMusicUrl(num id, num br) {
    return doGet(musicUrl, params: {'id': id, 'br': br});
  }

  /*获取云村热评*/
  static Future<Map> getHotComments() async {
    return doGet(hotComment);
  }

  static Future<Map> refresh() async {
    return doGet(loginRefresh);
  }

//  /*退出登录*/
  static exitLogin() async {
    await doGet(logout);
    //删除用户
    await SpUtil.removeUser();
    //删除cookie
    cookieJar?.deleteAll();
    //跳转登录
    navigatorState.pushNamedAndRemoveUntil(Routes.LIGHTLISTEN_LOGIN, (_) => false);
  }

//  /*用户登录状态*/
  static Future<Map> getLoginStatu() async {
    return doGet(loginStatu);
  }

//  /*用户歌单等个数*/
  static Future<Map> getUserSubCount() async {
    doGet(userSubcount);
  }

  /*推荐新歌*/
  static Future<Map> getPersonalizedNewSongs() async {
    return doGet(personalizedNewMusic);
  }

  /*获取歌单详情*/
  static Future<Map> getMusicListDetail(num id) async {
    return doGet(musicListDetail, params: {'id': id});
  }

  /*获取音乐详情*/
  static Future<Map> getMusicDetail(String ids) async {
    return doGet(musicDetail, params: {"ids": ids});
  }

  /*搜索*/
  static Future<Map> searchMusic(String keyword, int type, int limit, int offset) {
    return doGet(search, params: {"keywords": keyword, "type": type, "limit": limit, "offset": offset});
  }

  /*获取mv地址*/
  static Future<Map> getMvUrl(id) {
    return doGet(mvUrl, params: {"id": id});
  }

  /*获取likedMusic*/
  static Future<Map> getLikedMusic(id) {
    return doGet(likedMusic, params: {"id": id});
  }

  /*获取歌词*/
  static Future<Map> getLyric(id) {
    return doGet(lyric, params: {"id": id});
  }
}

//const baseUrl = 'http://143.92.58.146:3000';
const base = 'http://118.24.85.15:3000';

/*登录*/
const login = "/login/cellphone";

/*用户详情*/
const userDetail = "/user/detail";

/*用户歌单*/
const userPlaylist = "/user/playlist";

/*banner*/
const banner = "/banner";

/*新碟*/
const topAlbum = "/top/album";

/*新碟*/
const newAlbum = "/album/newest";

/*每日推荐歌单*/
const recommendResource = "/recommend/resource";

/*每日推荐歌曲*/
const recommendSongs = "/recommend/songs";

/*音乐url*/
const musicUrl = "/song/url";

/*登录刷新*/
const loginRefresh = "/login/refresh";

/*登出*/
const logout = "/logout";

/*登录状态*/
const loginStatu = "/login/statu";

/*用户订阅总数*/
const userSubcount = "/user/subcount";

/*推荐歌单*/
const personalizedPlaylist = "/personalized";

/*推荐的新歌（10首）*/
const personalizedNewMusic = "/personalized/newsong";

/*歌单详情*/
const musicListDetail = "/playlist/detail";

/*音乐详情*/
const musicDetail = "/song/detail";

/*搜索*/
const search = "/search";

/*mv地址*/
const mvUrl = "/mv/url";

/*热评*/
const hotComment = "/comment/hotwall/list";

/*喜欢的音乐*/
const likedMusic = "/likelist";

/*歌词*/
const lyric = "/lyric";

class MyCookieManager extends CookieManager {
  MyCookieManager(CookieJar cookieJar) : super(cookieJar);

  @override
  onRequest(RequestOptions options) {
    var cookies = cookieJar.loadForRequest(Uri.parse(base));
    cookies.removeWhere(
        (cookie) => cookie.value == CookieManager.invalidCookieValue && cookie.expires.isBefore(DateTime.now()));
    cookies.addAll(options.cookies);
    String cookie = CookieManager.getCookies(cookies);
    if (cookie.isNotEmpty) options.headers[HttpHeaders.cookieHeader] = cookie;
  }
}
