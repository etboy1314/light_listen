class User {
  int level;
  int listenSongs;
  UserPointBean userPoint;
  bool mobileSign;
  bool pcSign;
  ProfileBean profile;
  bool peopleCanSeeMyPlayRecord;
  List<BindingsBean> bindings;
  bool adValid;
  int code;
  int createTime;
  int createDays;

  static User fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    User accountBean = User();
    accountBean.level = map['level'];
    accountBean.listenSongs = map['listenSongs'];
    accountBean.userPoint = UserPointBean.fromMap(map['userPoint']);
    accountBean.mobileSign = map['mobileSign'];
    accountBean.pcSign = map['pcSign'];
    accountBean.profile = ProfileBean.fromMap(map['profile']);
    accountBean.peopleCanSeeMyPlayRecord = map['peopleCanSeeMyPlayRecord'];
    accountBean.bindings = List()
      ..addAll(
          (map['bindings'] as List ?? []).map((o) => BindingsBean.fromMap(o)));
    accountBean.adValid = map['adValid'];
    accountBean.code = map['code'];
    accountBean.createTime = map['createTime'];
    accountBean.createDays = map['createDays'];
    return accountBean;
  }
}

/// tokenJsonStr : null
/// userId : 251269220
/// url : ""
/// bindingTime : 1502947053486
/// expiresIn : 2147483647
/// refreshTime : 1502947053
/// expired : false
/// id : 3197636667
/// type : 1

class BindingsBean {
  dynamic tokenJsonStr;
  int userId;
  String url;
  int bindingTime;
  int expiresIn;
  int refreshTime;
  bool expired;
  int id;
  int type;

  static BindingsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    BindingsBean bindingsBean = BindingsBean();
    bindingsBean.tokenJsonStr = map['tokenJsonStr'];
    bindingsBean.userId = map['userId'];
    bindingsBean.url = map['url'];
    bindingsBean.bindingTime = map['bindingTime'];
    bindingsBean.expiresIn = map['expiresIn'];
    bindingsBean.refreshTime = map['refreshTime'];
    bindingsBean.expired = map['expired'];
    bindingsBean.id = map['id'];
    bindingsBean.type = map['type'];
    return bindingsBean;
  }
}

/// description : ""
/// defaultAvatar : false
/// avatarUrl : "https://p2.music.126.net/yR0NMAKrcqw11Ac9oluIiA==/109951163678920961.jpg"
/// birthday : 854812800000
/// city : 430800
/// nickname : "Lu_yucheng"
/// accountStatus : 0
/// userId : 251269220
/// expertTags : null
/// province : 430000
/// gender : 2
/// experts : {}
/// avatarImgId : 109951163678920960
/// backgroundImgId : 109951163382718610
/// userType : 0
/// djStatus : 0
/// mutual : false
/// remarkName : null
/// authStatus : 0
/// vipType : 11
/// backgroundUrl : "http://p1.music.126.net/h46JFlUz733-IZOU8yXVEg==/109951163382718611.jpg"
/// detailDescription : ""
/// followed : false
/// avatarImgIdStr : "109951163678920961"
/// backgroundImgIdStr : "109951163382718611"
/// signature : "?????????????????????????????????"
/// authority : 0
/// avatarImgId_str : "109951163678920961"
/// artistIdentity : []
/// followeds : 11
/// follows : 35
/// cCount : 0
/// blacklist : false
/// eventCount : 1
/// sDJPCount : 0
/// allSubscribedCount : 0
/// playlistCount : 4
/// playlistBeSubscribedCount : 2
/// sCount : 0

class ProfileBean {
  String description;
  bool defaultAvatar;
  String avatarUrl;
  int birthday;
  int city;
  String nickname;
  int accountStatus;
  int userId;
  dynamic expertTags;
  int province;
  int gender;
  ExpertsBean experts;
  int avatarImgId;
  int backgroundImgId;
  int userType;
  int djStatus;
  bool mutual;
  dynamic remarkName;
  int authStatus;
  int vipType;
  String backgroundUrl;
  String detailDescription;
  bool followed;
  String avatarImgIdStr;
  String backgroundImgIdStr;
  String signature;
  int authority;
  String avatarImgId_Str;
  List<dynamic> artistIdentity;
  int followeds;
  int follows;
  int cCount;
  bool blacklist;
  int eventCount;
  int sDJPCount;
  int allSubscribedCount;
  int playlistCount;
  int playlistBeSubscribedCount;
  int sCount;

  static ProfileBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ProfileBean profileBean = ProfileBean();
    profileBean.description = map['description'];
    profileBean.defaultAvatar = map['defaultAvatar'];
    profileBean.avatarUrl = map['avatarUrl'];
    profileBean.birthday = map['birthday'];
    profileBean.city = map['city'];
    profileBean.nickname = map['nickname'];
    profileBean.accountStatus = map['accountStatus'];
    profileBean.userId = map['userId'];
    profileBean.expertTags = map['expertTags'];
    profileBean.province = map['province'];
    profileBean.gender = map['gender'];
    profileBean.experts = ExpertsBean.fromMap(map['experts']);
    profileBean.avatarImgId = map['avatarImgId'];
    profileBean.backgroundImgId = map['backgroundImgId'];
    profileBean.userType = map['userType'];
    profileBean.djStatus = map['djStatus'];
    profileBean.mutual = map['mutual'];
    profileBean.remarkName = map['remarkName'];
    profileBean.authStatus = map['authStatus'];
    profileBean.vipType = map['vipType'];
    profileBean.backgroundUrl = map['backgroundUrl'];
    profileBean.detailDescription = map['detailDescription'];
    profileBean.followed = map['followed'];
    profileBean.avatarImgIdStr = map['avatarImgIdStr'];
    profileBean.backgroundImgIdStr = map['backgroundImgIdStr'];
    profileBean.signature = map['signature'];
    profileBean.authority = map['authority'];
    profileBean.avatarImgId_Str = map['avatarImgId_str'];
    profileBean.artistIdentity = map['artistIdentity'];
    profileBean.followeds = map['followeds'];
    profileBean.follows = map['follows'];
    profileBean.cCount = map['cCount'];
    profileBean.blacklist = map['blacklist'];
    profileBean.eventCount = map['eventCount'];
    profileBean.sDJPCount = map['sDJPCount'];
    profileBean.allSubscribedCount = map['allSubscribedCount'];
    profileBean.playlistCount = map['playlistCount'];
    profileBean.playlistBeSubscribedCount = map['playlistBeSubscribedCount'];
    profileBean.sCount = map['sCount'];
    return profileBean;
  }
}

class ExpertsBean {
  static ExpertsBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    ExpertsBean expertsBean = ExpertsBean();
    return expertsBean;
  }
}

/// userId : 251269220
/// balance : 1121
/// updateTime : 1560334109127
/// version : 10
/// status : 1
/// blockBalance : 0

class UserPointBean {
  int userId;
  int balance;
  int updateTime;
  int version;
  int status;
  int blockBalance;

  static UserPointBean fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    UserPointBean userPointBean = UserPointBean();
    userPointBean.userId = map['userId'];
    userPointBean.balance = map['balance'];
    userPointBean.updateTime = map['updateTime'];
    userPointBean.version = map['version'];
    userPointBean.status = map['status'];
    userPointBean.blockBalance = map['blockBalance'];
    return userPointBean;
  }
}
