// To parse this JSON data, do
//
//     final historyListModel = historyListModelFromJson(jsonString);

import 'dart:convert';

List<HistoryListModel> historyListModelFromJson(String str) => List<HistoryListModel>.from(json.decode(str).map((x) => HistoryListModel.fromJson(x)));


class HistoryListModel {
  String name;
  String mobile;
  String trackCode;
  String checkIn;
  DateTime miladiCheckIn;
  int duration;
  String status;
  Ecolosge ecolosge;

  HistoryListModel({
    required this.name,
    required this.mobile,
    required this.trackCode,
    required this.checkIn,
    required this.miladiCheckIn,
    required this.duration,
    required this.status,
    required this.ecolosge,
  });

  factory HistoryListModel.fromJson(Map<String, dynamic> json) => HistoryListModel(
    name: json["name"],
    mobile: json["mobile"],
    trackCode: json["track_code"],
    checkIn: json["check_in"],
    miladiCheckIn: DateTime.parse(json["miladi_check_in"]),
    duration: json["duration"],
    status: json["status"],
    ecolosge: Ecolosge.fromJson(json["ecolosge"]),
  );

}

class Ecolosge {
  String title;
  String url;
  String image;

  Ecolosge({
    required this.title,
    required this.url,
    required this.image,
  });

  factory Ecolosge.fromJson(Map<String, dynamic> json) => Ecolosge(
    title: json["title"],
    url: json["url"],
    image: json["image"],
  );

}
