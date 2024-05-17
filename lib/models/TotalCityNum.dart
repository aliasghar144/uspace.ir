import 'dart:convert';

TotalCityNum totalCityNumFromJson(String str) => TotalCityNum.fromJson(json.decode(str));
String totalCityNumToJson(TotalCityNum data) => json.encode(data.toJson());
class TotalCityNum {
  TotalCityNum({
      this.title, 
      this.value,});

  TotalCityNum.fromJson(dynamic json) {
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