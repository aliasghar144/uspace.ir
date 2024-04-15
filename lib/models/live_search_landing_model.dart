// To parse this JSON data, do
//
//     final liveSearchLandingPagesModel = liveSearchLandingPagesModelFromJson(jsonString);

import 'dart:convert';

List<SearchLandingPagesModel> liveSearchLandingPagesModelFromJson(String str) => List<SearchLandingPagesModel>.from(json.decode(str).map((x) => SearchLandingPagesModel.fromJson(x)));


class SearchLandingPagesModel {
  String? title;
  String? url;
  String? verticalImg;

  SearchLandingPagesModel({
    this.title,
    this.url,
    this.verticalImg,
  });

  factory SearchLandingPagesModel.fromJson(Map<String, dynamic> json) => SearchLandingPagesModel(
    title: json["title"],
    url: json["url"],
    verticalImg: json["vertical_img"],
  );

}
