import 'TotalRsv.dart';
import 'ActiveEcolodges.dart';
import 'TotalCityNum.dart';
import 'TotalVillageNum.dart';
import 'dart:convert';

GeneralInfoModel generalInfoModelFromJson(String str) => GeneralInfoModel.fromJson(json.decode(str));
String generalInfoModelToJson(GeneralInfoModel data) => json.encode(data.toJson());

class GeneralInfoModel {
  GeneralInfoModel({
      this.totalRsv, 
      this.activeEcolodges, 
      this.totalCityNum, 
      this.totalVillageNum,});

  GeneralInfoModel.fromJson(dynamic json) {
    totalRsv = json['total_rsv'] != null ? TotalRsv.fromJson(json['total_rsv']) : null;
    activeEcolodges = json['active_ecolodges'] != null ? ActiveEcolodges.fromJson(json['active_ecolodges']) : null;
    totalCityNum = json['total_city_num'] != null ? TotalCityNum.fromJson(json['total_city_num']) : null;
    totalVillageNum = json['total_village_num'] != null ? TotalVillageNum.fromJson(json['total_village_num']) : null;
  }
  TotalRsv? totalRsv;
  ActiveEcolodges? activeEcolodges;
  TotalCityNum? totalCityNum;
  TotalVillageNum? totalVillageNum;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (totalRsv != null) {
      map['total_rsv'] = totalRsv?.toJson();
    }
    if (activeEcolodges != null) {
      map['active_ecolodges'] = activeEcolodges?.toJson();
    }
    if (totalCityNum != null) {
      map['total_city_num'] = totalCityNum?.toJson();
    }
    if (totalVillageNum != null) {
      map['total_village_num'] = totalVillageNum?.toJson();
    }
    return map;
  }

}