// To parse this JSON data, do
//
//     final userDataModel = userDataModelFromJson(jsonString);

// UserDataModel userDataModelFromJson(String str) =>
//     UserDataModel.fromJson(json.decode(str));

// String userDataModelToJson(UserDataModel data) => json.encode(data.toJson());

class UserDataModel {
  UserDataModel({
    required this.subreddit,
    required this.snoovatarImg,
    required this.snoovatarSize,
    required this.goldExpiration,
    required this.hasGoldSubscription,
    required this.numFriends,
    required this.coins,
    required this.id,
    required this.oauthClientId,
    required this.canCreateSubreddit,
    required this.awarderKarma,
    required this.iconImg,
    required this.awardeeKarma,
    required this.linkKarma,
    required this.totalKarma,
    required this.inboxCount,
    required this.name,
    required this.created,
    required this.goldCreddits,
    required this.createdUtc,
    required this.commentKarma,
  });

  final Subreddit subreddit;
  final String snoovatarImg;
  final dynamic snoovatarSize;
  final dynamic goldExpiration;
  final bool hasGoldSubscription;
  final int numFriends;
  final int coins;
  final String id;
  final String oauthClientId;
  final bool canCreateSubreddit;
  final int awarderKarma;
  final String iconImg;
  final int awardeeKarma;
  final int linkKarma;
  final int totalKarma;
  final int inboxCount;
  final String name;
  final double created;
  final int goldCreddits;
  final double createdUtc;
  final int commentKarma;

  UserDataModel copyWith({
    Subreddit? subreddit,
    String? snoovatarImg,
    dynamic snoovatarSize,
    dynamic goldExpiration,
    bool? hasGoldSubscription,
    int? numFriends,
    int? coins,
    String? id,
    String? oauthClientId,
    bool? canCreateSubreddit,
    int? awarderKarma,
    String? iconImg,
    int? awardeeKarma,
    int? linkKarma,
    int? totalKarma,
    int? inboxCount,
    String? name,
    double? created,
    int? goldCreddits,
    double? createdUtc,
    int? commentKarma,
  }) =>
      UserDataModel(
        subreddit: subreddit ?? this.subreddit,
        snoovatarImg: snoovatarImg ?? this.snoovatarImg,
        snoovatarSize: snoovatarSize ?? this.snoovatarSize,
        goldExpiration: goldExpiration ?? this.goldExpiration,
        hasGoldSubscription: hasGoldSubscription ?? this.hasGoldSubscription,
        numFriends: numFriends ?? this.numFriends,
        coins: coins ?? this.coins,
        id: id ?? this.id,
        oauthClientId: oauthClientId ?? this.oauthClientId,
        canCreateSubreddit: canCreateSubreddit ?? this.canCreateSubreddit,
        awarderKarma: awarderKarma ?? this.awarderKarma,
        iconImg: iconImg ?? this.iconImg,
        awardeeKarma: awardeeKarma ?? this.awardeeKarma,
        linkKarma: linkKarma ?? this.linkKarma,
        totalKarma: totalKarma ?? this.totalKarma,
        inboxCount: inboxCount ?? this.inboxCount,
        name: name ?? this.name,
        created: created ?? this.created,
        goldCreddits: goldCreddits ?? this.goldCreddits,
        createdUtc: createdUtc ?? this.createdUtc,
        commentKarma: commentKarma ?? this.commentKarma,
      );

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        subreddit:
            Subreddit.fromJson(json["subreddit"] as Map<String, dynamic>),
        snoovatarImg: json["snoovatar_img"] as String,
        snoovatarSize: json["snoovatar_size"],
        goldExpiration: json["gold_expiration"],
        hasGoldSubscription: json["has_gold_subscription"] as bool,
        numFriends: json["num_friends"] as int,
        coins: json["coins"] as int,
        id: json["id"] as String,
        oauthClientId: json["oauth_client_id"] as String,
        canCreateSubreddit: json["can_create_subreddit"] as bool,
        awarderKarma: json["awarder_karma"] as int,
        iconImg: json["icon_img"] as String,
        awardeeKarma: json["awardee_karma"] as int,
        linkKarma: json["link_karma"] as int,
        totalKarma: json["total_karma"] as int,
        inboxCount: json["inbox_count"] as int,
        name: json["name"] as String,
        created: json["created"] as double,
        goldCreddits: json["gold_creddits"] as int,
        createdUtc: json["created_utc"] as double,
        commentKarma: json["comment_karma"] as int,
      );

  Map<String, dynamic> toJson() => {
        "subreddit": subreddit.toJson(),
        "snoovatar_img": snoovatarImg,
        "snoovatar_size": snoovatarSize,
        "gold_expiration": goldExpiration,
        "has_gold_subscription": hasGoldSubscription,
        "num_friends": numFriends,
        "coins": coins,
        "id": id,
        "oauth_client_id": oauthClientId,
        "can_create_subreddit": canCreateSubreddit,
        "awarder_karma": awarderKarma,
        "icon_img": iconImg,
        "awardee_karma": awardeeKarma,
        "link_karma": linkKarma,
        "total_karma": totalKarma,
        "inbox_count": inboxCount,
        "name": name,
        "created": created,
        "gold_creddits": goldCreddits,
        "created_utc": createdUtc,
        "comment_karma": commentKarma,
      };
}

class Subreddit {
  Subreddit({
    required this.bannerImg,
    required this.communityIcon,
    required this.showMedia,
    required this.iconColor,
    required this.displayName,
    required this.headerImg,
    required this.title,
    required this.coins,
    required this.primaryColor,
    required this.iconImg,
    required this.subscribers,
    required this.displayNamePrefixed,
    required this.keyColor,
    required this.name,
    required this.isDefaultBanner,
    required this.url,
  });

  final String bannerImg;
  final dynamic communityIcon;
  final bool showMedia;
  final String iconColor;
  final String displayName;
  final dynamic headerImg;
  final String title;
  final int coins;
  final String primaryColor;
  final String iconImg;
  final int subscribers;
  final String displayNamePrefixed;
  final String keyColor;
  final String name;
  final bool isDefaultBanner;
  final String url;

  Subreddit copyWith({
    String? bannerImg,
    dynamic communityIcon,
    bool? showMedia,
    String? iconColor,
    String? displayName,
    dynamic headerImg,
    String? title,
    int? coins,
    String? primaryColor,
    String? iconImg,
    int? subscribers,
    String? displayNamePrefixed,
    String? keyColor,
    String? name,
    bool? isDefaultBanner,
    String? url,
  }) =>
      Subreddit(
        bannerImg: bannerImg ?? this.bannerImg,
        communityIcon: communityIcon ?? this.communityIcon,
        showMedia: showMedia ?? this.showMedia,
        iconColor: iconColor ?? this.iconColor,
        displayName: displayName ?? this.displayName,
        headerImg: headerImg ?? this.headerImg,
        title: title ?? this.title,
        coins: coins ?? this.coins,
        primaryColor: primaryColor ?? this.primaryColor,
        iconImg: iconImg ?? this.iconImg,
        subscribers: subscribers ?? this.subscribers,
        displayNamePrefixed: displayNamePrefixed ?? this.displayNamePrefixed,
        keyColor: keyColor ?? this.keyColor,
        name: name ?? this.name,
        isDefaultBanner: isDefaultBanner ?? this.isDefaultBanner,
        url: url ?? this.url,
      );

  factory Subreddit.fromJson(Map<String, dynamic> json) => Subreddit(
        bannerImg: json["banner_img"] as String,
        communityIcon: json["community_icon"],
        showMedia: json["show_media"] as bool,
        iconColor: json["icon_color"] as String,
        displayName: json["display_name"] as String,
        headerImg: json["header_img"],
        title: json["title"] as String,
        coins: json["coins"] as int,
        primaryColor: json["primary_color"] as String,
        iconImg: json["icon_img"] as String,
        subscribers: json["subscribers"] as int,
        displayNamePrefixed: json["display_name_prefixed"] as String,
        keyColor: json["key_color"] as String,
        name: json["name"] as String,
        isDefaultBanner: json["is_default_banner"] as bool,
        url: json["url"] as String,
      );

  Map<String, dynamic> toJson() => {
        "banner_img": bannerImg,
        "community_icon": communityIcon,
        "show_media": showMedia,
        "icon_color": iconColor,
        "display_name": displayName,
        "header_img": headerImg,
        "title": title,
        "coins": coins,
        "primary_color": primaryColor,
        "icon_img": iconImg,
        "subscribers": subscribers,
        "display_name_prefixed": displayNamePrefixed,
        "key_color": keyColor,
        "name": name,
        "is_default_banner": isDefaultBanner,
        "url": url,
      };
}
