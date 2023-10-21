// To parse this JSON data, do
//
//     final liveSearchEcolodgesModel = liveSearchEcolodgesModelFromJson(jsonString);

import 'dart:convert';

List<LiveSearchEcolodgesModel> liveSearchEcolodgesModelFromJson(String str) => List<LiveSearchEcolodgesModel>.from(json.decode(str).map((x) => LiveSearchEcolodgesModel.fromJson(x)));

String liveSearchEcolodgesModelToJson(List<LiveSearchEcolodgesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LiveSearchEcolodgesModel {
  String title;
  String image;
  String province;
  String? city;
  String? village;
  String address;
  String? url;
  int? minPrice;
  String? unitPrice;
  int? maxDiscountPercent;
  int? maxDiscountPrice;
  double? dollarEquivalent;
  String? currency;

  LiveSearchEcolodgesModel({
    required this.title,
    required this.image,
    required this.province,
    this.city,
    this.village,
    required this.address,
    this.url,
    this.minPrice,
    this.unitPrice,
    this.maxDiscountPercent,
    this.maxDiscountPrice,
    this.dollarEquivalent,
    this.currency,
  });

  factory LiveSearchEcolodgesModel.fromJson(Map<String, dynamic> json) => LiveSearchEcolodgesModel(
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
