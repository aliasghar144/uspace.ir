// To parse this JSON data, do
//
//     final mainGalleryModel = mainGalleryModelFromJson(jsonString);

import 'dart:convert';

MainGalleryModel mainGalleryModelFromJson(String str) => MainGalleryModel.fromJson(json.decode(str));

String mainGalleryModelToJson(MainGalleryModel data) => json.encode(data.toJson());

class MainGalleryModel {
  List<Datum> data;

  MainGalleryModel({
    required this.data,
  });

  factory MainGalleryModel.fromJson(Map<String, dynamic> json) => MainGalleryModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String caption;
  String description;
  String image;
  String destination;
  String type;

  Datum({
    required this.caption,
    required this.description,
    required this.image,
    required this.destination,
    required this.type,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    caption: json["caption"],
    description: json["description"],
    image: json["image"],
    destination: json["destination"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "caption": caption,
    "description": description,
    "image": image,
    "destination": destination,
    "type": type,
  };
}
