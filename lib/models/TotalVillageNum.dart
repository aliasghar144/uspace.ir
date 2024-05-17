import 'dart:convert';

TotalVillageNum totalVillageNumFromJson(String str) => TotalVillageNum.fromJson(json.decode(str));
String totalVillageNumToJson(TotalVillageNum data) => json.encode(data.toJson());
class TotalVillageNum {
  TotalVillageNum({
      this.title, 
      this.value,});

  TotalVillageNum.fromJson(dynamic json) {
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