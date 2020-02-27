class UserMusicList {
  /// subscribers : []
  /// subscribed : false
  /// creator : {"defaultAvatar":false,"province":430000,"authStatus":0,"followed":false,"avatarUrl":"http://p1.music.126.net/yR0NMAKrcqw11Ac9oluIiA==/109951163678920961.jpg","accountStatus":0,"gender":2,"city":430800,"birthday":854812800000,"userId":251269220,"userType":0,"nickname":"Lu_yucheng","signature":"假如有人问我的烦忧，我不敢说出你的名字。","description":"","detailDescription":"","avatarImgId":109951163678920960,"backgroundImgId":109951163382718610,"backgroundUrl":"http://p1.music.126.net/h46JFlUz733-IZOU8yXVEg==/109951163382718611.jpg","authority":0,"mutual":false,"expertTags":null,"experts":null,"djStatus":0,"vipType":11,"remarkName":null,"backgroundImgIdStr":"109951163382718611","avatarImgIdStr":"109951163678920961","avatarImgId_str":"109951163678920961"}
  /// artists : null
  /// tracks : null
  /// updateFrequency : null
  /// backgroundCoverId : 0
  /// backgroundCoverUrl : null
  /// playCount : 155
  /// trackCount : 11
  /// ordered : true
  /// highQuality : false
  /// createTime : 1457451805929
  /// trackNumberUpdateTime : 1559976920341
  /// trackUpdateTime : 1559984727639
  /// cloudTrackCount : 0
  /// tags : []
  /// status : 0
  /// description : null
  /// privacy : 0
  /// newImported : false
  /// adType : 0
  /// updateTime : 1559976920341
  /// coverImgId : 18896206835284908
  /// userId : 251269220
  /// totalDuration : 0
  /// coverImgUrl : "https://p2.music.126.net/Lfb9jZBzQG5mnGtEJyRVpg==/18896206835284907.jpg"
  /// specialType : 5
  /// anonimous : false
  /// commentThreadId : "A_PL_0_314185228"
  /// subscribedCount : 0
  /// name : "Lu_yucheng喜欢的音乐"
  /// id : 314185228
  /// coverImgId_str : "18896206835284907"

  List<dynamic> subscribers;
  bool subscribed;
  CreatorBean creator;
  dynamic artists;
  dynamic tracks;
  dynamic updateFrequency;
  int backgroundCoverId;
  dynamic backgroundCoverUrl;
  int playCount;
  int trackCount;
  bool ordered;
  bool highQuality;
  int createTime;
  int trackNumberUpdateTime;
  int trackUpdateTime;
  int cloudTrackCount;
  List<dynamic> tags;
  int status;
  dynamic description;
  int privacy;
  bool newImported;
  int adType;
  int updateTime;
  int coverImgId;
  int userId;
  int totalDuration;
  String coverImgUrl;
  int specialType;
  bool anonimous;
  String commentThreadId;
  int subscribedCount;
  String name;
  int id;
  String coverImgIdStr;

  static UserMusicList fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserMusicList bean = UserMusicList();
    bean.subscribers = map['subscribers'];
    bean.subscribed = map['subscribed'];
    bean.creator = CreatorBean.fromMap(map['creator']);
    bean.artists = map['artists'];
    bean.tracks = map['tracks'];
    bean.updateFrequency = map['updateFrequency'];
    bean.backgroundCoverId = map['backgroundCoverId'];
    bean.backgroundCoverUrl = map['backgroundCoverUrl'];
    bean.playCount = map['playCount'];
    bean.trackCount = map['trackCount'];
    bean.ordered = map['ordered'];
    bean.highQuality = map['highQuality'];
    bean.createTime = map['createTime'];
    bean.trackNumberUpdateTime = map['trackNumberUpdateTime'];
    bean.trackUpdateTime = map['trackUpdateTime'];
    bean.cloudTrackCount = map['cloudTrackCount'];
    bean.tags = map['tags'];
    bean.status = map['status'];
    bean.description = map['description'];
    bean.privacy = map['privacy'];
    bean.newImported = map['newImported'];
    bean.adType = map['adType'];
    bean.updateTime = map['updateTime'];
    bean.coverImgId = map['coverImgId'];
    bean.userId = map['userId'];
    bean.totalDuration = map['totalDuration'];
    bean.coverImgUrl = map['coverImgUrl'];
    bean.specialType = map['specialType'];
    bean.anonimous = map['anonimous'];
    bean.commentThreadId = map['commentThreadId'];
    bean.subscribedCount = map['subscribedCount'];
    bean.name = map['name'];
    bean.id = map['id'];
    bean.coverImgIdStr = map['coverImgId_str'];
    return bean;
  }
}

/// defaultAvatar : false
/// province : 430000
/// authStatus : 0
/// followed : false
/// avatarUrl : "http://p1.music.126.net/yR0NMAKrcqw11Ac9oluIiA==/109951163678920961.jpg"
/// accountStatus : 0
/// gender : 2
/// city : 430800
/// birthday : 854812800000
/// userId : 251269220
/// userType : 0
/// nickname : "Lu_yucheng"
/// signature : "假如有人问我的烦忧，我不敢说出你的名字。"
/// description : ""
/// detailDescription : ""
/// avatarImgId : 109951163678920960
/// backgroundImgId : 109951163382718610
/// backgroundUrl : "http://p1.music.126.net/h46JFlUz733-IZOU8yXVEg==/109951163382718611.jpg"
/// authority : 0
/// mutual : false
/// expertTags : null
/// experts : null
/// djStatus : 0
/// vipType : 11
/// remarkName : null
/// backgroundImgIdStr : "109951163382718611"
/// avatarImgIdStr : "109951163678920961"
/// avatarImgId_str : "109951163678920961"

class CreatorBean {
  bool defaultAvatar;
  int province;
  int authStatus;
  bool followed;
  String avatarUrl;
  int accountStatus;
  int gender;
  int city;
  int birthday;
  int userId;
  int userType;
  String nickname;
  String signature;
  String description;
  String detailDescription;
  int avatarImgId;
  int backgroundImgId;
  String backgroundUrl;
  int authority;
  bool mutual;
  dynamic expertTags;
  dynamic experts;
  int djStatus;
  int vipType;
  dynamic remarkName;
  String backgroundImgIdStr;
  String avatarImgIdStr;
  String avatarImgId_Str;

  static CreatorBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    CreatorBean creatorBean = CreatorBean();
    creatorBean.defaultAvatar = map['defaultAvatar'];
    creatorBean.province = map['province'];
    creatorBean.authStatus = map['authStatus'];
    creatorBean.followed = map['followed'];
    creatorBean.avatarUrl = map['avatarUrl'];
    creatorBean.accountStatus = map['accountStatus'];
    creatorBean.gender = map['gender'];
    creatorBean.city = map['city'];
    creatorBean.birthday = map['birthday'];
    creatorBean.userId = map['userId'];
    creatorBean.userType = map['userType'];
    creatorBean.nickname = map['nickname'];
    creatorBean.signature = map['signature'];
    creatorBean.description = map['description'];
    creatorBean.detailDescription = map['detailDescription'];
    creatorBean.avatarImgId = map['avatarImgId'];
    creatorBean.backgroundImgId = map['backgroundImgId'];
    creatorBean.backgroundUrl = map['backgroundUrl'];
    creatorBean.authority = map['authority'];
    creatorBean.mutual = map['mutual'];
    creatorBean.expertTags = map['expertTags'];
    creatorBean.experts = map['experts'];
    creatorBean.djStatus = map['djStatus'];
    creatorBean.vipType = map['vipType'];
    creatorBean.remarkName = map['remarkName'];
    creatorBean.backgroundImgIdStr = map['backgroundImgIdStr'];
    creatorBean.avatarImgIdStr = map['avatarImgIdStr'];
    creatorBean.avatarImgId_Str = map['avatarImgId_str'];
    return creatorBean;
  }

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
