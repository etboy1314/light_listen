import 'package:light_listen/model/common/artist.dart';

class Album {
  final String name;
  final int id;
  final String type;
  final int size;
  final int picId;
  final String blurPicUrl;
  final int companyId;
  final int pic;
  final String picUrl;
  final int publishTime;
  final String description;
  final String tags;
  final String company;
  final String briefDesc;

//  final Artist artist;
//  final Object songs;

//  final List<Object> alias;
  final int status;
  final int copyrightId;
  final String commentThreadId;
  final List<Artist> artists;
  final bool paid;
  final bool onSale;
  final String picId_str;

  Album.fromJsonMap(Map<String, dynamic> map)
      : name = map["name"],
        id = map["id"],
        type = map["type"],
        size = map["size"],
        picId = map["picId"],
        blurPicUrl = map["blurPicUrl"],
        companyId = map["companyId"],
        pic = map["pic"],
        picUrl = map["picUrl"],
        publishTime = map["publishTime"],
        description = map["description"],
        tags = map["tags"],
        company = map["company"],
        briefDesc = map["briefDesc"],
//        artist = Artist.fromJsonMap(map["artist"]),
//        songs = map["songs"],
//        alias = map["alias"],
        status = map["status"],
        copyrightId = map["copyrightId"],
        commentThreadId = map["commentThreadId"],
        artists = List<Artist>.from(map["artists"].map((it) => Artist.fromJsonMap(it))),
        paid = map["paid"],
        onSale = map["onSale"],
        picId_str = map["picId_str"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = name;
    data['id'] = id;
    data['type'] = type;
    data['size'] = size;
    data['picId'] = picId;
    data['blurPicUrl'] = blurPicUrl;
    data['companyId'] = companyId;
    data['pic'] = pic;
    data['picUrl'] = picUrl;
    data['publishTime'] = publishTime;
    data['description'] = description;
    data['tags'] = tags;
    data['company'] = company;
    data['briefDesc'] = briefDesc;
//    data['artist'] = artist == null ? null : artist.toJson();
//    data['songs'] = songs;
//    data['alias'] = alias;
    data['status'] = status;
    data['copyrightId'] = copyrightId;
    data['commentThreadId'] = commentThreadId;
    data['artists'] = artists != null ? this.artists.map((v) => v.toJson()).toList() : null;
    data['paid'] = paid;
    data['onSale'] = onSale;
    data['picId_str'] = picId_str;
    return data;
  }
}
