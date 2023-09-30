// To parse this JSON data, do
//
//     final ecolodgeModel = ecolodgeModelFromJson(jsonString);

import 'dart:convert';

List<EcolodgeModel> ecolodgeModelFromJson(String str) => List<EcolodgeModel>.from(json.decode(str).map((x) => EcolodgeModel.fromJson(x)));

String ecolodgeModelToJson(List<EcolodgeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EcolodgeModel {
  String title;
  String image;
  String province;
  String city;
  String village;
  String address;
  String url;
  int minPrice;
  String unitPrice;
  int maxDiscountPercent;
  int maxDiscountPrice;
  double dollarEquivalent;
  String currency;

  EcolodgeModel({
    required this.title,
    required this.image,
    required this.province,
    required this.city,
    required this.village,
    required this.address,
    required this.url,
    required this.minPrice,
    required this.unitPrice,
    required this.maxDiscountPercent,
    required this.maxDiscountPrice,
    required this.dollarEquivalent,
    required this.currency,
  });

  factory EcolodgeModel.fromJson(Map<String, dynamic> json) => EcolodgeModel(
    title: json["title"],
    image: json["image"],
    province: json["province"],
    city: json["city"],
    village: json["village"],
    address: json["address"],
    url: json["url"],
    minPrice: json["min_price"],
    unitPrice: json["unit_price"],
    maxDiscountPercent: json["max_discount_percent"],
    maxDiscountPrice: json["max_discount_price"],
    dollarEquivalent: json["dollar_equivalent"]?.toDouble(),
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "province": province,
    "city": city,
    "village": village,
    "address": address,
    "url": url,
    "min_price": minPrice,
    "unit_price": unitPrice,
    "max_discount_percent": maxDiscountPercent,
    "max_discount_price": maxDiscountPrice,
    "dollar_equivalent": dollarEquivalent,
    "currency": currency,
  };
}
