// To parse this JSON data, do
//
//     final liveSearchLandingPagesModel = liveSearchLandingPagesModelFromJson(jsonString);

import 'dart:convert';

List<LiveSearchLandingPagesModel> liveSearchLandingPagesModelFromJson(String str) => List<LiveSearchLandingPagesModel>.from(json.decode(str).map((x) => LiveSearchLandingPagesModel.fromJson(x)));

String liveSearchLandingPagesModelToJson(List<LiveSearchLandingPagesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveSearchLandingPagesModel {
  String? title;
  String? url;
  String? verticalImg;

  LiveSearchLandingPagesModel({
    this.title,
    this.url,
    this.verticalImg,
  });

  factory LiveSearchLandingPagesModel.fromJson(Map<String, dynamic> json) => LiveSearchLandingPagesModel(
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
