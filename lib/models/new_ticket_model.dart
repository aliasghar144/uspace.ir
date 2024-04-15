// To parse this JSON data, do
//
//     final newTicketModel = newTicketModelFromJson(jsonString);

import 'dart:convert';

NewTicketModel newTicketModelFromJson(String str) => NewTicketModel.fromJson(json.decode(str));

String newTicketModelToJson(NewTicketModel data) => json.encode(data.toJson());

class NewTicketModel {
  List<Datum> data;

  NewTicketModel({
    required this.data,
  });

  factory NewTicketModel.fromJson(Map<String, dynamic> json) => NewTicketModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  String type;
  String enSection;
  String faSection;
  String title;
  int priority;
  int ticketCode;
  int state;
  DateTime mStartDate;
  String jStartDate;

  Datum({
    required this.type,
    required this.enSection,
    required this.faSection,
    required this.title,
    required this.priority,
    required this.ticketCode,
    required this.state,
    required this.mStartDate,
    required this.jStartDate,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    type: json["type"],
    enSection: json["en_section"],
    faSection: json["fa_section"],
    title: json["title"],
    priority: json["priority"],
    ticketCode: json["ticket_code"],
    state: json["state"],
    mStartDate: DateTime.parse(json["m_start_date"]),
    jStartDate: json["j_start_date"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "en_section": enSection,
    "fa_section": faSection,
    "title": title,
    "priority": priority,
    "ticket_code": ticketCode,
    "state": state,
    "m_start_date": mStartDate.toIso8601String(),
    "j_start_date": jStartDate,
  };
}
