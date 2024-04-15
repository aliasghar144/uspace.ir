// To parse this JSON data, do
//
//     final allPlacesModel = allPlacesModelFromJson(jsonString);

import 'dart:convert';

AllPlacesModel allPlacesModelFromJson(String str) => AllPlacesModel.fromJson(json.decode(str));


class AllPlacesModel {
  List<Datum> data;

  AllPlacesModel({
    required this.data,
  });

  factory AllPlacesModel.fromJson(Map<String, dynamic> json) => AllPlacesModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

}

class Datum {
  String title;
  String aliasTitle;
  String image;
  int groupType;
  String parentUrl;
  String url;
  int visitNumber;

  Datum({
    required this.title,
    required this.aliasTitle,
    required this.image,
    required this.groupType,
    required this.parentUrl,
    required this.url,
    required this.visitNumber,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    aliasTitle: json["alias_title"],
    image: json["image"],
    groupType: json["group_type"],
    parentUrl: json["parent_url"],
    url: json["url"],
    visitNumber: json["visit_number"],
  );

}
