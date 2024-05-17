import 'dart:convert';

TotalRsv totalRsvFromJson(String str) => TotalRsv.fromJson(json.decode(str));
String totalRsvToJson(TotalRsv data) => json.encode(data.toJson());
class TotalRsv {
  TotalRsv({
      this.title, 
      this.value,});

  TotalRsv.fromJson(dynamic json) {
    title = json['title'];
    value = json['value'];
  }
  String? title;
  int? value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = title;
    map['value'] = value;
    return map;
  }

}