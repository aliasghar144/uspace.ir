// To parse this JSON data, do
//
//     final liveSearchPlacesModel = liveSearchPlacesModelFromJson(jsonString);

import 'dart:convert';

List<SearchPlacesModel> liveSearchPlacesModelFromJson(String str) => List<SearchPlacesModel>.from(json.decode(str).map((x) => SearchPlacesModel.fromJson(x)));

String liveSearchPlacesModelToJson(List<SearchPlacesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SearchPlacesModel {
  String title;
  String? aliasTitle;
  String image;
  int? groupType;
  String? parentUrl;
  String? url;
  int? visitNumber;

  SearchPlacesModel({
    required this.title,
    this.aliasTitle,
    required this.image,
    this.groupType,
    this.parentUrl,
    this.url,
    this.visitNumber,
  });

  factory SearchPlacesModel.fromJson(Map<String, dynamic> json) => SearchPlacesModel(
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
