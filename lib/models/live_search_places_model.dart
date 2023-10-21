// To parse this JSON data, do
//
//     final liveSearchPlacesModel = liveSearchPlacesModelFromJson(jsonString);

import 'dart:convert';

List<LiveSearchPlacesModel> liveSearchPlacesModelFromJson(String str) => List<LiveSearchPlacesModel>.from(json.decode(str).map((x) => LiveSearchPlacesModel.fromJson(x)));

String liveSearchPlacesModelToJson(List<LiveSearchPlacesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveSearchPlacesModel {
  String title;
  String? aliasTitle;
  String image;
  int? groupType;
  String? parentUrl;
  String? url;
  int? visitNumber;

  LiveSearchPlacesModel({
    required this.title,
    this.aliasTitle,
    required this.image,
    this.groupType,
    this.parentUrl,
    this.url,
    this.visitNumber,
  });

  factory LiveSearchPlacesModel.fromJson(Map<String, dynamic> json) => LiveSearchPlacesModel(
    title: json["title"],
    aliasTitle: json["alias_title"],
    image: json["image"],
    groupType: json["group_type"],
    parentUrl: json["parent_url"],
    url: json["url"],
    visitNumber: json["visit_number"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "alias_title": aliasTitle,
    "image": image,
    "group_type": groupType,
    "parent_url": parentUrl,
    "url": url,
    "visit_number": visitNumber,
  };
}
