import 'package:light_listen/model/common/album.dart';
import 'package:light_listen/model/common/artist.dart';

class DailyMusic {
  final String name;
  final num id;
  final String disc;
  final num no;
  final List<Artist> artists;
  final Album album;
  final bool starred;
  final num popularity;
  final num duration;
  final String commentThreadId;
  final num mvid;
  final HMusic hMusic;
  final MMusic mMusic;
  final LMusic lMusic;
  final BMusic bMusic;
  final String reason;
  final Privilege privilege;
  final String alg;

  DailyMusic.fromJsonMap(Map<String, dynamic> map)
      : name = map["name"],
        id = map["id"],
        disc = map["disc"],
        no = map["no"],
        artists = List<Artist>.from(map["artists"].map((it) => Artist.fromJsonMap(it))),
        album = Album.fromJsonMap(map["album"]),
        starred = map["starred"],
        popularity = map["popularity"],
        duration = map["duration"],
        commentThreadId = map["commentThreadId"],
        mvid = map["mvid"],
        hMusic = map["hMusic"] == null ? null : HMusic.fromJsonMap(map["hMusic"]),
        mMusic = map["mMusic"] == null ? null : MMusic.fromJsonMap(map["mMusic"]),
        lMusic = map["lMusic"] == null ? null : LMusic.fromJsonMap(map["lMusic"]),
        bMusic = map["bMusic"] == null ? null : BMusic.fromJsonMap(map["bMusic"]),
        reason = map["reason"],
        privilege = Privilege.fromJsonMap(map["privilege"]),
        alg = map["alg"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['id'] = id;
    data['disc'] = disc;
    data['no'] = no;
    data['artists'] = artists != null ? this.artists.map((v) => v.toJson()).toList() : null;
    data['album'] = album == null ? null : album.toJson();
    data['starred'] = starred;
    data['popularity'] = popularity;
    data['duration'] = duration;
    data['commentThreadId'] = commentThreadId;
    data['mvid'] = mvid;
    data['hMusic'] = hMusic == null ? null : hMusic.toJson();
    data['mMusic'] = mMusic == null ? null : mMusic.toJson();
    data['lMusic'] = lMusic == null ? null : lMusic.toJson();
    data['bMusic'] = bMusic == null ? null : bMusic.toJson();
    data['reason'] = reason;
    data['privilege'] = privilege == null ? null : privilege.toJson();
    data['alg'] = alg;
    return data;
  }
}

class Privilege {
  final int id;
  final int fee;
  final int payed;
  final int st;
  final int pl;
  final int dl;
  final int sp;
  final int cp;
  final int subp;
  final bool cs;
  final int maxbr;
  final int fl;
  final bool toast;
  final int flag;
  final bool preSell;

  Privilege.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        fee = map["fee"],
        payed = map["payed"],
        st = map["st"],
        pl = map["pl"],
        dl = map["dl"],
        sp = map["sp"],
        cp = map["cp"],
        subp = map["subp"],
        cs = map["cs"],
        maxbr = map["maxbr"],
        fl = map["fl"],
        toast = map["toast"],
        flag = map["flag"],
        preSell = map["preSell"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['fee'] = fee;
    data['payed'] = payed;
    data['st'] = st;
    data['pl'] = pl;
    data['dl'] = dl;
    data['sp'] = sp;
    data['cp'] = cp;
    data['subp'] = subp;
    data['cs'] = cs;
    data['maxbr'] = maxbr;
    data['fl'] = fl;
    data['toast'] = toast;
    data['flag'] = flag;
    data['preSell'] = preSell;
    return data;
  }
}

class MMusic {
  final num id;
  final num size;
  final String extension;
  final num sr;
  final num dfsId;
  final num bitrate;
  final num playTime;
  final num volumeDelta;

  MMusic.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        size = map["size"],
        extension = map["extension"],
        sr = map["sr"],
        dfsId = map["dfsId"],
        bitrate = map["bitrate"],
        playTime = map["playTime"],
        volumeDelta = map["volumeDelta"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['size'] = size;
    data['extension'] = extension;
    data['sr'] = sr;
    data['dfsId'] = dfsId;
    data['bitrate'] = bitrate;
    data['playTime'] = playTime;
    data['volumeDelta'] = volumeDelta;
    return data;
  }
}

class LMusic {
  final num id;
  final num size;
  final String extension;
  final num sr;
  final num dfsId;
  final num bitrate;
  final num playTime;
  final num volumeDelta;

  LMusic.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        size = map["size"],
        extension = map["extension"],
        sr = map["sr"],
        dfsId = map["dfsId"],
        bitrate = map["bitrate"],
        playTime = map["playTime"],
        volumeDelta = map["volumeDelta"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['size'] = size;
    data['extension'] = extension;
    data['sr'] = sr;
    data['dfsId'] = dfsId;
    data['bitrate'] = bitrate;
    data['playTime'] = playTime;
    data['volumeDelta'] = volumeDelta;
    return data;
  }
}

class HMusic {
  final num id;
  final num size;
  final String extension;
  final num sr;
  final num dfsId;
  final num bitrate;
  final num playTime;
  final num volumeDelta;

  HMusic.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        size = map["size"],
        extension = map["extension"],
        sr = map["sr"],
        dfsId = map["dfsId"],
        bitrate = map["bitrate"],
        playTime = map["playTime"],
        volumeDelta = map["volumeDelta"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['size'] = size;
    data['extension'] = extension;
    data['sr'] = sr;
    data['dfsId'] = dfsId;
    data['bitrate'] = bitrate;
    data['playTime'] = playTime;
    data['volumeDelta'] = volumeDelta;
    return data;
  }
}

class BMusic {
  final num id;
  final num size;
  final String extension;
  final num sr;
  final num dfsId;
  final num bitrate;
  final num playTime;
  final num volumeDelta;

  BMusic.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        size = map["size"],
        extension = map["extension"],
        sr = map["sr"],
        dfsId = map["dfsId"],
        bitrate = map["bitrate"],
        playTime = map["playTime"],
        volumeDelta = map["volumeDelta"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['size'] = size;
    data['extension'] = extension;
    data['sr'] = sr;
    data['dfsId'] = dfsId;
    data['bitrate'] = bitrate;
    data['playTime'] = playTime;
    data['volumeDelta'] = volumeDelta;
    return data;
  }
}
