import 'dart:convert';

ActiveEcolodges activeEcolodgesFromJson(String str) => ActiveEcolodges.fromJson(json.decode(str));
String activeEcolodgesToJson(ActiveEcolodges data) => json.encode(data.toJson());

class ActiveEcolodges {
  ActiveEcolodges({
      this.title, 
      this.value,});

  ActiveEcolodges.fromJson(dynamic json) {
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