import 'dart:convert';

import 'package:equatable/equatable.dart';

String subredditListModelToJson(SubredditListModel data) =>
    json.encode(data.toJson());

class SubredditListModel {
  SubredditListModel({
    required this.kind,
    required this.data,
  });

  final String kind;
  final SubredditListModelData data;

  SubredditListModel copyWith({
    String? kind,
    SubredditListModelData? data,
  }) =>
      SubredditListModel(
        kind: kind ?? this.kind,
        data: data ?? this.data,
      );

  factory SubredditListModel.fromJson(Map<String, dynamic> json) =>
      SubredditListModel(
        kind: json["kind"] as String,
        data: SubredditListModelData.fromJson(
            json["data"] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "kind": kind,
        "data": data.toJson(),
      };
}

class SubredditListModelData {
  SubredditListModelData({
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

  SubredditListModelData copyWith({
    String? after,
    int? dist,
    String? modhash,
    String? geoFilter,
    List<Child>? children,
    dynamic before,
  }) =>
      SubredditListModelData(
        after: after ?? this.after,
        dist: dist ?? this.dist,
        modhash: modhash ?? this.modhash,
        geoFilter: geoFilter ?? this.geoFilter,
        children: children ?? this.children,
        before: before ?? this.before,
      );

  factory SubredditListModelData.fromJson(Map<String, dynamic> json) =>
      SubredditListModelData(
        after: (json["after"] ?? '') as String,
        dist: json["dist"] as int,
        modhash: (json["modhash"] ?? '') as String,
        geoFilter: json["geo_filter"] as String,
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
    required this.data,
  });

  final ChildData data;

  Child copyWith({
    ChildData? data,
  }) =>
      Child(
        data: data ?? this.data,
      );

  factory Child.fromJson(Map<String, dynamic> json) =>
      Child(data: ChildData.fromMap(json["data"] as Map<String, dynamic>));

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class ChildData extends Equatable {
  final String displayName;
  final String title;
  final String displayNamePrefixed;
  final String? communityIcon;

  ChildData(this.displayName, this.title, this.displayNamePrefixed,
      this.communityIcon);

  ChildData copyWith({
    String? displayName,
    String? title,
    String? displayNamePrefixed,
    String? communityIcon,
  }) {
    return ChildData(
      displayName ?? this.displayName,
      title ?? this.title,
      displayNamePrefixed ?? this.displayNamePrefixed,
      communityIcon ?? this.communityIcon,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};
    result.addAll({'display_name': displayName});
    result.addAll({'title': title});
    result.addAll({'display_name_prefixed': displayNamePrefixed});
    result.addAll({'community_icon': communityIcon});
    return result;
  }

  factory ChildData.fromMap(Map<String, dynamic> map) {
    return ChildData(
      (map['display_name'] ?? '') as String,
      map['title'] as String,
      (map['display_name_prefixed'] ?? '') as String,
      (map['community_icon'] ?? map['icon_img']) as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChildData.fromJson(String source) =>
      ChildData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChildData(displayName: $displayName, title: $title, displayNamePrefixed: $displayNamePrefixed, communityIcon: $communityIcon)';
  }

  @override
  List<Object> get props => [displayName, title, displayNamePrefixed];
}
