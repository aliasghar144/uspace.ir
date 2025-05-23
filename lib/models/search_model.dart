
import 'dart:convert';

List<SearchModel> ecolodgeModelFromJson(String str) => List<SearchModel>.from(json.decode(str).map((x) => SearchModel.fromJson(x)));


class SearchModel {
  String title;
  String image;
  String province;
  String city;
  String village;
  String address;
  String url;
  int? minPrice;
  String? unitPrice;
  int? maxDiscountPercent;
  int? maxDiscountPrice;
  double? dollarEquivalent;
  String? currency;

  SearchModel({
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

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    title: json["title"],
    image: json["image"],
    province: json["province"],
    city: json["city"],
    village: json["village"],
    address: json["address"],
    url: json["url"],
    minPrice: json["min_price"]?.toInt(),
    unitPrice: json["unit_price"],
    maxDiscountPercent: json["max_discount_percent"]?.toInt(),
    maxDiscountPrice: json["max_discount_price"]?.toInt(),
    dollarEquivalent: json["dollar_equivalent"]?.toDouble(),
    currency: json["currency"],
  );

}