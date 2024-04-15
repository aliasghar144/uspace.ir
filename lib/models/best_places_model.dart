// To parse this JSON data, do
//
//     final bestPlacesModel = bestPlacesModelFromJson(jsonString);

import 'dart:convert';

List<BestPlacesModel> bestPlacesModelFromJson(String str) => List<BestPlacesModel>.from(json.decode(str).map((x) => BestPlacesModel.fromJson(x)));


class BestPlacesModel {
  String title;
  String aliasTitle;
  String image;
  int groupType;
  String parentUrl;
  String url;
  int visitNumber;

  BestPlacesModel({
    required this.title,
    required this.aliasTitle,
    required this.image,
    required this.groupType,
    required this.parentUrl,
    required this.url,
    required this.visitNumber,
  });

  factory BestPlacesModel.fromJson(Map<String, dynamic> json) => BestPlacesModel(
    title: json["title"],
    aliasTitle: json["alias_title"],
    image: json["image"],
    groupType: json["group_type"],
    parentUrl: json["parent_url"],
    url: json["url"],
    visitNumber: json["visit_number"],
  );
}
