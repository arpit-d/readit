// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

String redditPostsModelToJson(RedditPostsModel data) =>
    json.encode(data.toJson());

class RedditPostsModel extends Equatable {
  RedditPostsModel({
    required this.kind,
    required this.data,
  });

  final String kind;
  final RedditPostsModelData data;

  RedditPostsModel copyWith({
    String? kind,
    RedditPostsModelData? data,
  }) =>
      RedditPostsModel(
        kind: kind ?? this.kind,
        data: data ?? this.data,
      );

  factory RedditPostsModel.fromJson(Map<String, dynamic> json) =>
      RedditPostsModel(
        kind: (json["kind"] ?? '') as String,
        data:
            RedditPostsModelData.fromJson(json["data"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "data": data.toJson(),
      };

  @override
  List<Object> get props => [kind, data];
}

class RedditPostsModelData {
  RedditPostsModelData({
    required this.after,
    required this.dist,
    required this.modhash,
    required this.geoFilter,
    required this.children,
    required this.before,
  });

  final String after;
  final int dist;
  final String modhash;
  final String geoFilter;
  final List<Child> children;
  final dynamic before;

  RedditPostsModelData copyWith({
    String? after,
    int? dist,
    String? modhash,
    String? geoFilter,
    List<Child>? children,
    dynamic before,
  }) =>
      RedditPostsModelData(
        after: after ?? this.after,
        dist: dist ?? this.dist,
        modhash: modhash ?? this.modhash,
        geoFilter: geoFilter ?? this.geoFilter,
        children: children ?? this.children,
        before: before ?? this.before,
      );

  factory RedditPostsModelData.fromJson(Map<String, dynamic> json) =>
      RedditPostsModelData(
        after: json["after"] as String,
        dist: json["dist"] as int,
        modhash: (json["modhash"] ?? '') as String,
        geoFilter: (json["geo_filter"] ?? '') as String,
        children: List<Child>.from((json["children"] as Iterable<dynamic>)
            .map((x) => Child.fromJson(x as Map<String, dynamic>))),
        before: json["before"],
      );

  Map<String, dynamic> toJson() => {
        "after": after,
        "dist": dist,
        "modhash": modhash,
        "geo_filter": geoFilter,
        "children": List<dynamic>.from(children.map((x) => x.toJson())),
        "before": before,
      };
}

class Child {
  Child({
    required this.kind,
    required this.data,
  });

  final String kind;
  final ChildData data;

  Child copyWith({
    String? kind,
    ChildData? data,
  }) =>
      Child(
        kind: kind ?? this.kind,
        data: data ?? this.data,
      );

  factory Child.fromJson(Map<String, dynamic> json) => Child(
        kind: json['kind'] as String,
        data: ChildData.fromJson(json["data"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class ChildData {
  ChildData(
      {required this.subredditId,
      required this.approvedAtUtc,
      required this.authorIsBlocked,
      required this.commentType,
      required this.linkTitle,
      required this.modReasonBy,
      required this.bannedBy,
      required this.ups,
      required this.numReports,
      required this.totalAwardsReceived,
      required this.subreddit,
      required this.linkAuthor,
      required this.likes,
      required this.replies,
      required this.saved,
      required this.id,
      required this.bannedAtUtc,
      required this.modReasonTitle,
      required this.gilded,
      required this.archived,
      required this.collapsedReasonCode,
      required this.noFollow,
      required this.author,
      required this.numComments,
      required this.canModPost,
      required this.sendReplies,
      required this.parentId,
      required this.score,
      required this.authorFullname,
      required this.over18,
      required this.reportReasons,
      required this.removalReason,
      required this.approvedBy,
      required this.controversiality,
      required this.body,
      required this.edited,
      required this.topAwardedType,
      required this.downs,
      required this.authorFlairCssClass,
      required this.isSubmitter,
      required this.collapsed,
      required this.authorPatreonFlair,
      required this.bodyHtml,
      required this.collapsedReason,
      required this.distinguished,
      required this.associatedAward,
      required this.stickied,
      required this.authorPremium,
      required this.canGild,
      required this.linkId,
      required this.unrepliableReason,
      required this.authorFlairTextColor,
      required this.scoreHidden,
      required this.permalink,
      required this.linkPermalink,
      required this.name,
      required this.created,
      required this.subredditNamePrefixed,
      required this.authorFlairText,
      required this.createdUtc,
      required this.locked,
      required this.authorFlairBackgroundColor,
      required this.collapsedBecauseCrowdControl,
      required this.quarantine,
      required this.modNote,
      required this.linkUrl,
      required this.authorFlairTemplateId,
      required this.title,
      required this.selftext,
      this.thumbnail,
      this.url_overridden_by_dest});

  final String subredditId;
  final dynamic approvedAtUtc;
  final bool authorIsBlocked;
  final dynamic commentType;
  final String linkTitle;
  final dynamic modReasonBy;
  final dynamic bannedBy;
  final int ups;
  final dynamic numReports;

  final int totalAwardsReceived;
  final String subreddit;
  final String linkAuthor;
  final bool likes;
  final String replies;
  final String title;
  final bool saved;
  final String id;
  final dynamic bannedAtUtc;
  final dynamic modReasonTitle;
  final int gilded;
  final bool archived;
  final dynamic collapsedReasonCode;
  final bool noFollow;
  final String author;
  final int numComments;
  final bool canModPost;
  final bool sendReplies;
  final String parentId;
  final int score;
  final String authorFullname;
  final bool over18;
  final dynamic reportReasons;
  final dynamic removalReason;
  final dynamic approvedBy;
  final int controversiality;
  final String body;
  final dynamic edited;
  final dynamic topAwardedType;
  final int downs;
  final String authorFlairCssClass;
  final bool isSubmitter;
  final bool collapsed;
  final dynamic thumbnail;
  final bool authorPatreonFlair;
  final String bodyHtml;
  final dynamic url_overridden_by_dest;
  final dynamic collapsedReason;
  final dynamic distinguished;
  final dynamic associatedAward;
  final bool stickied;
  final dynamic authorPremium;
  final bool canGild;
  final String linkId;
  final dynamic unrepliableReason;
  final String authorFlairTextColor;
  final bool scoreHidden;
  final String permalink;
  final String linkPermalink;
  final String name;
  final double created;
  final String subredditNamePrefixed;
  final String authorFlairText;
  final String createdUtc;

  final bool locked;
  final String authorFlairBackgroundColor;
  final dynamic collapsedBecauseCrowdControl;
  final String selftext;
  final bool quarantine;
  final dynamic modNote;
  final String linkUrl;
  final String authorFlairTemplateId;

  ChildData copyWith(
          {String? subredditId,
          dynamic url_overridden_by_dest,
          dynamic approvedAtUtc,
          bool? authorIsBlocked,
          dynamic commentType,
          String? linkTitle,
          dynamic modReasonBy,
          dynamic bannedBy,
          int? ups,
          dynamic numReports,
          int? totalAwardsReceived,
          String? subreddit,
          String? linkAuthor,
          bool? likes,
          String? replies,
          bool? saved,
          String? id,
          dynamic? bannedAtUtc,
          dynamic modReasonTitle,
          int? gilded,
          bool? archived,
          dynamic collapsedReasonCode,
          bool? noFollow,
          String? author,
          int? numComments,
          bool? canModPost,
          bool? sendReplies,
          String? parentId,
          int? score,
          String? authorFullname,
          bool? over18,
          dynamic reportReasons,
          dynamic removalReason,
          dynamic approvedBy,
          int? controversiality,
          String? body,
          dynamic edited,
          dynamic? topAwardedType,
          int? downs,
          String? authorFlairCssClass,
          bool? isSubmitter,
          bool? collapsed,
          bool? authorPatreonFlair,
          String? bodyHtml,
          dynamic collapsedReason,
          dynamic distinguished,
          dynamic associatedAward,
          bool? stickied,
          dynamic authorPremium,
          bool? canGild,
          String? linkId,
          dynamic unrepliableReason,
          String? authorFlairTextColor,
          bool? scoreHidden,
          String? permalink,
          String? linkPermalink,
          String? name,
          double? created,
          String? subredditNamePrefixed,
          String? authorFlairText,
          String? createdUtc,
          bool? locked,
          String? selftext,
          String? authorFlairBackgroundColor,
          dynamic collapsedBecauseCrowdControl,
          bool? quarantine,
          dynamic modNote,
          String? linkUrl,
          String? authorFlairTemplateId,
          thumbnail,
          String? title}) =>
      ChildData(
        url_overridden_by_dest:
            url_overridden_by_dest ?? this.url_overridden_by_dest,
        title: title ?? this.title,
        thumbnail: thumbnail ?? this.thumbnail,
        subredditId: subredditId ?? this.subredditId,
        approvedAtUtc: approvedAtUtc ?? this.approvedAtUtc,
        authorIsBlocked: authorIsBlocked ?? this.authorIsBlocked,
        commentType: commentType ?? this.commentType,
        linkTitle: linkTitle ?? this.linkTitle,
        modReasonBy: modReasonBy ?? this.modReasonBy,
        bannedBy: bannedBy ?? this.bannedBy,
        ups: ups ?? this.ups,
        numReports: numReports ?? this.numReports,
        totalAwardsReceived: totalAwardsReceived ?? this.totalAwardsReceived,
        subreddit: subreddit ?? this.subreddit,
        linkAuthor: linkAuthor ?? this.linkAuthor,
        likes: likes ?? this.likes,
        replies: replies ?? this.replies,
        saved: saved ?? this.saved,
        id: id ?? this.id,
        bannedAtUtc: bannedAtUtc ?? this.bannedAtUtc,
        modReasonTitle: modReasonTitle ?? this.modReasonTitle,
        gilded: gilded ?? this.gilded,
        archived: archived ?? this.archived,
        collapsedReasonCode: collapsedReasonCode ?? this.collapsedReasonCode,
        noFollow: noFollow ?? this.noFollow,
        author: author ?? this.author,
        numComments: numComments ?? this.numComments,
        canModPost: canModPost ?? this.canModPost,
        sendReplies: sendReplies ?? this.sendReplies,
        parentId: parentId ?? this.parentId,
        score: score ?? this.score,
        authorFullname: authorFullname ?? this.authorFullname,
        over18: over18 ?? this.over18,
        reportReasons: reportReasons ?? this.reportReasons,
        removalReason: removalReason ?? this.removalReason,
        approvedBy: approvedBy ?? this.approvedBy,
        controversiality: controversiality ?? this.controversiality,
        body: body ?? this.body,
        edited: edited ?? this.edited,
        topAwardedType: topAwardedType ?? this.topAwardedType,
        downs: downs ?? this.downs,
        authorFlairCssClass: authorFlairCssClass ?? this.authorFlairCssClass,
        isSubmitter: isSubmitter ?? this.isSubmitter,
        collapsed: collapsed ?? this.collapsed,
        authorPatreonFlair: authorPatreonFlair ?? this.authorPatreonFlair,
        bodyHtml: bodyHtml ?? this.bodyHtml,
        collapsedReason: collapsedReason ?? this.collapsedReason,
        distinguished: distinguished ?? this.distinguished,
        associatedAward: associatedAward ?? this.associatedAward,
        stickied: stickied ?? this.stickied,
        authorPremium: authorPremium ?? this.authorPremium,
        canGild: canGild ?? this.canGild,
        linkId: linkId ?? this.linkId,
        unrepliableReason: unrepliableReason ?? this.unrepliableReason,
        authorFlairTextColor: authorFlairTextColor ?? this.authorFlairTextColor,
        scoreHidden: scoreHidden ?? this.scoreHidden,
        permalink: permalink ?? this.permalink,
        linkPermalink: linkPermalink ?? this.linkPermalink,
        name: name ?? this.name,
        created: created ?? this.created,
        subredditNamePrefixed:
            subredditNamePrefixed ?? this.subredditNamePrefixed,
        authorFlairText: authorFlairText ?? this.authorFlairText,
        createdUtc: createdUtc ?? this.createdUtc,
        locked: locked ?? this.locked,
        authorFlairBackgroundColor:
            authorFlairBackgroundColor ?? this.authorFlairBackgroundColor,
        collapsedBecauseCrowdControl:
            collapsedBecauseCrowdControl ?? this.collapsedBecauseCrowdControl,
        quarantine: quarantine ?? this.quarantine,
        modNote: modNote ?? this.modNote,
        linkUrl: linkUrl ?? this.linkUrl,
        authorFlairTemplateId:
            authorFlairTemplateId ?? this.authorFlairTemplateId,
        selftext: selftext ?? this.selftext,
      );

  factory ChildData.fromJson(Map<String, dynamic> json) {
    final t = 1668975922;

    final convertedDate = convertDate(t);

    return ChildData(
        url_overridden_by_dest: json['url_overridden_by_dest'],
        thumbnail: json['thumbnail'],
        title: json['title'] as String,
        subredditId: json["subreddit_id"] as String,
        approvedAtUtc: json["approved_at_utc"],
        authorIsBlocked: json["author_is_blocked"] as bool,
        commentType: json["comment_type"],
        selftext: (json["selftext"] ?? 'no text') as String,
        linkTitle: (json["link_title"] ?? '') as String,
        modReasonBy: json["mod_reason_by"],
        bannedBy: (json["banned_by"] ?? ''),
        ups: json["ups"] as int,
        numReports: json["num_reports"],
        totalAwardsReceived: json["total_awards_received"] as int,
        subreddit: json["subreddit"] as String,
        linkAuthor: (json["link_author"] ?? '') as String,
        likes: (json["likes"] ?? false) as bool,
        replies: (json["replies"] ?? '') as String,
        saved: json["saved"] as bool,
        id: json["id"] as String,
        bannedAtUtc: json["banned_at_utc"],
        modReasonTitle: json["mod_reason_title"],
        gilded: json["gilded"] as int,
        archived: json["archived"] as bool,
        collapsedReasonCode: json["collapsed_reason_code"],
        noFollow: json["no_follow"] as bool,
        author: (json["author"] ?? 'No Author') as String,
        numComments: json["num_comments"] as int,
        canModPost: json["can_mod_post"] as bool,
        sendReplies: json["send_replies"] as bool,
        parentId: (json["parent_id"] ?? '') as String,
        score: json["score"] as int,
        authorFullname: (json["author_fullname"] ?? '') as String,
        over18: json["over_18"] as bool,
        reportReasons: json["report_reasons"],
        removalReason: json["removal_reason"],
        approvedBy: json["approved_by"],
        controversiality: (json["controversiality"] ?? 0) as int,
        body: (json["body"] ?? '') as String,
        edited: json["edited"] as dynamic,
        topAwardedType: json["top_awarded_type"],
        downs: json["downs"] as int,
        authorFlairCssClass: (json["author_flair_css_class"] ?? '') as String,
        isSubmitter: (json["is_submitter"] ?? false) as bool,
        collapsed: (json["collapsed"] ?? true) as bool,
        authorPatreonFlair: (json["author_patreon_flair"] ?? true) as bool,
        bodyHtml: (json["body_html"] ?? '') as String,
        collapsedReason: json["collapsed_reason"],
        distinguished: json["distinguished"],
        associatedAward: json["associated_award"],
        stickied: json["stickied"] as bool,
        authorPremium: json["author_premium"] as dynamic,
        canGild: json["can_gild"] as bool,
        linkId: (json["link_id"] ?? '') as String,
        unrepliableReason: json["unrepliable_reason"],
        authorFlairTextColor: (json["author_flair_text_color"] ?? '') as String,
        scoreHidden: (json["score_hidden"] ?? true) as bool,
        permalink: (json["permalink"] ?? '') as String,
        linkPermalink: (json["link_permalink"] ?? '') as String,
        name: (json["name"] ?? '') as String,
        created: json["created"] as double,
        subredditNamePrefixed: json["subreddit_name_prefixed"] as String,
        authorFlairText: (json["author_flair_text"] ?? '') as String,
        createdUtc: convertedDate,
        locked: (json["locked"] ?? false) as bool,
        authorFlairBackgroundColor:
            (json["author_flair_background_color"] ?? '') as String,
        collapsedBecauseCrowdControl: json["collapsed_because_crowd_control"],
        quarantine: json["quarantine"] as bool,
        modNote: json["mod_note"],
        linkUrl: (json["link_url"] ?? '') as String,
        authorFlairTemplateId:
            (json["author_flair_template_id"] ?? '') as String);
  }

  Map<String, dynamic> toJson() => {
        "subreddit_id": subredditId,
        "approved_at_utc": approvedAtUtc,
        "author_is_blocked": authorIsBlocked,
        "comment_type": commentType,
        "link_title": linkTitle,
        "mod_reason_by": modReasonBy,
        "banned_by": bannedBy,
        "ups": ups,
        "num_reports": numReports,
        "total_awards_received": totalAwardsReceived,
        "subreddit": subreddit,
        "link_author": linkAuthor,
        "likes": likes,
        "replies": replies,
        "saved": saved,
        "id": id,
        "banned_at_utc": bannedAtUtc,
        "mod_reason_title": modReasonTitle,
        "gilded": gilded,
        "archived": archived,
        "collapsed_reason_code": collapsedReasonCode,
        "no_follow": noFollow,
        "num_comments": numComments,
        "can_mod_post": canModPost,
        "send_replies": sendReplies,
        "parent_id": parentId,
        "score": score,
        "over_18": over18,
        "report_reasons": reportReasons,
        "removal_reason": removalReason,
        "approved_by": approvedBy,
        "controversiality": controversiality,
        "body": body,
        "edited": edited,
        "top_awarded_type": topAwardedType,
        "downs": downs,
        "author_flair_css_class": authorFlairCssClass,
        "is_submitter": isSubmitter,
        "collapsed": collapsed,
        "author_patreon_flair": authorPatreonFlair,
        "body_html": bodyHtml,
        "collapsed_reason": collapsedReason,
        "distinguished": distinguished,
        "associated_award": associatedAward,
        "stickied": stickied,
        "author_premium": authorPremium,
        "can_gild": canGild,
        "link_id": linkId,
        "unrepliable_reason": unrepliableReason,
        "author_flair_text_color":
            authorFlairTextColor == null ? null : authorFlairTextColor,
        "score_hidden": scoreHidden,
        "permalink": permalink,
        "link_permalink": linkPermalink,
        "name": name,
        "created": created,
        "subreddit_name_prefixed": subredditNamePrefixed,
        "author_flair_text": authorFlairText,
        "created_utc": createdUtc,
        "locked": locked,
        "author_flair_background_color": authorFlairBackgroundColor,
        "collapsed_because_crowd_control": collapsedBecauseCrowdControl,
        "quarantine": quarantine,
        "mod_note": modNote,
        "link_url": linkUrl,
        "author_flair_template_id": authorFlairTemplateId,
      };

  static String convertDate(int dateInEpoch) {
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(
        int.parse(dateInEpoch.toString()),
        isUtc: true);
    final format = new DateFormat("yMd");
    var dateString = format.format(date);
    return dateString;
  }
}

enum E { EMOJI, TEXT }

final eValues = EnumValues({"emoji": E.EMOJI, "text": E.TEXT});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => MapEntry(v, k));
    }
    return reverseMap;
  }
}
