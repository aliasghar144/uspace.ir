// To parse this JSON data, do
//
//     final specialPlacesModel = specialPlacesModelFromJson(jsonString);

import 'dart:convert';

List<SpecialPlacesModel> specialPlacesModelFromJson(String str) => List<SpecialPlacesModel>.from(json.decode(str).map((x) => SpecialPlacesModel.fromJson(x)));

String specialPlacesModelToJson(List<SpecialPlacesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SpecialPlacesModel {
  String title;
  String url;
  String verticalImg;

  SpecialPlacesModel({
    required this.title,
    required this.url,
    required this.verticalImg,
  });

  factory SpecialPlacesModel.fromJson(Map<String, dynamic> json) => SpecialPlacesModel(
    title: json["title"],
    url: json["url"],
    verticalImg: json["vertical_img"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
    "vertical_img": verticalImg,
  };
}
