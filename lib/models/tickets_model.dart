// To parse this JSON data, do
//
//     final ticketsModel = ticketsModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

TicketsModel ticketsModelFromJson(String str) => TicketsModel.fromJson(json.decode(str));

String ticketsModelToJson(TicketsModel data) => json.encode(data.toJson());

class TicketsModel {
  Data data;

  TicketsModel({
    required this.data,
  });

  factory TicketsModel.fromJson(Map<String, dynamic> json) => TicketsModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  String type;
  String enSection;
  String faSection;
  String title;
  String content;
  String file;
  int priority;
  int ticketCode;
  String state;
  DateTime mStartDate;
  String jStartDate;
  RxList<Conversation> conversation;

  Data({
    required this.type,
    required this.enSection,
    required this.faSection,
    required this.title,
    required this.content,
    required this.file,
    required this.priority,
    required this.ticketCode,
    required this.state,
    required this.mStartDate,
    required this.jStartDate,
    required this.conversation,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    type: json["type"],
    enSection: json["en_section"],
    faSection: json["fa_section"],
    title: json["title"],
    content: json["content"],
    file: json["file"],
    priority: json["priority"],
    ticketCode: json["ticket_code"],
    state: json["state"],
    mStartDate: DateTime.parse(json["m_start_date"]),
    jStartDate: json["j_start_date"],
    conversation: RxList<Conversation>.from(json["conversation"].map((x) => Conversation.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "en_section": enSection,
    "fa_section": faSection,
    "title": title,
    "content": content,
    "file": file,
    "priority": priority,
    "ticket_code": ticketCode,
    "state": state,
    "m_start_date": mStartDate.toIso8601String(),
    "j_start_date": jStartDate,
    "conversation": List<dynamic>.from(conversation.map((x) => x.toJson())),
  };
}

class Conversation {
  Side side;
  String content;
  DateTime mStartDate;
  String jStartDate;

  Conversation({
    required this.side,
    required this.content,
    required this.mStartDate,
    required this.jStartDate,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) => Conversation(
    side: Side.fromJson(json["side"]),
    content: json["content"],
    mStartDate: DateTime.parse(json["m_start_date"]),
    jStartDate: json["j_start_date"],
  );

  Map<String, dynamic> toJson() => {
    "side": side.toJson(),
    "content": content,
    "m_start_date": mStartDate.toIso8601String(),
    "j_start_date": jStartDate,
  };
}

class Side {
  int sideId;
  String sideName;

  Side({
    required this.sideId,
    required this.sideName,
  });

  factory Side.fromJson(Map<String, dynamic> json) => Side(
    sideId: json["side_id"],
    sideName: json["side_name"],
  );

  Map<String, dynamic> toJson() => {
    "side_id": sideId,
    "side_name": sideName,
  };
}
