/*推荐歌单*/
class DailyMusicList {
  int id;
  int type;
  String name;
  String copywriter;
  String picUrl;
  int playcount;
  int createTime;
  Creator creator;
  int trackCount;
  int userId;
  String alg;

  DailyMusicList({this.id, this.name, this.picUrl, this.creator});

  DailyMusicList.fromJsonMap(Map<String, dynamic> map)
      : id = map["id"],
        type = map["type"],
        name = map["name"],
        copywriter = map["copywriter"],
        picUrl = map["picUrl"],
        playcount = map["playcount"],
        createTime = map["createTime"],
        creator = Creator.fromJsonMap(map["creator"]),
        trackCount = map["trackCount"],
        userId = map["userId"],
        alg = map["alg"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    data['copywriter'] = copywriter;
    data['picUrl'] = picUrl;
    data['playcount'] = playcount;
    data['createTime'] = createTime;
    data['creator'] = creator == null ? null : creator.toJson();
    data['trackCount'] = trackCount;
    data['userId'] = userId;
    data['alg'] = alg;
    return data;
  }
}

class Creator {
  final int avatarImgId;
  final String backgroundUrl;
  final int backgroundImgId;
  final String detailDescription;
  final bool defaultAvatar;
  final Object expertTags;
  final int djStatus;
  final bool followed;
  final String avatarImgIdStr;
  final String backgroundImgIdStr;
  final int accountStatus;
  final int userId;
  final int vipType;
  final int province;
  final int gender;
  final String avatarUrl;
  final int authStatus;
  final int userType;
  final String nickname;
  final int birthday;
  final int city;
  final bool mutual;
  final Object remarkName;
  final String description;
  final String signature;
  final int authority;

  Creator.fromJsonMap(Map<String, dynamic> map)
      : avatarImgId = map["avatarImgId"],
        backgroundUrl = map["backgroundUrl"],
        backgroundImgId = map["backgroundImgId"],
        detailDescription = map["detailDescription"],
        defaultAvatar = map["defaultAvatar"],
        expertTags = map["expertTags"],
        djStatus = map["djStatus"],
        followed = map["followed"],
        avatarImgIdStr = map["avatarImgIdStr"],
        backgroundImgIdStr = map["backgroundImgIdStr"],
        accountStatus = map["accountStatus"],
        userId = map["userId"],
        vipType = map["vipType"],
        province = map["province"],
        gender = map["gender"],
        avatarUrl = map["avatarUrl"],
        authStatus = map["authStatus"],
        userType = map["userType"],
        nickname = map["nickname"],
        birthday = map["birthday"],
        city = map["city"],
        mutual = map["mutual"],
        remarkName = map["remarkName"],
        description = map["description"],
        signature = map["signature"],
        authority = map["authority"];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatarImgId'] = avatarImgId;
    data['backgroundUrl'] = backgroundUrl;
    data['backgroundImgId'] = backgroundImgId;
    data['detailDescription'] = detailDescription;
    data['defaultAvatar'] = defaultAvatar;
    data['expertTags'] = expertTags;
    data['djStatus'] = djStatus;
    data['followed'] = followed;
    data['avatarImgIdStr'] = avatarImgIdStr;
    data['backgroundImgIdStr'] = backgroundImgIdStr;
    data['accountStatus'] = accountStatus;
    data['userId'] = userId;
    data['vipType'] = vipType;
    data['province'] = province;
    data['gender'] = gender;
    data['avatarUrl'] = avatarUrl;
    data['authStatus'] = authStatus;
    data['userType'] = userType;
    data['nickname'] = nickname;
    data['birthday'] = birthday;
    data['city'] = city;
    data['mutual'] = mutual;
    data['remarkName'] = remarkName;
    data['description'] = description;
    data['signature'] = signature;
    data['authority'] = authority;
    return data;
  }
}
