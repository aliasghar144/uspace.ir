// To parse this JSON data, do
//
//     final testModel = testModelFromJson(jsonString);

import 'dart:convert';

TestModel testModelFromJson(String str) => TestModel.fromJson(json.decode(str));

String testModelToJson(TestModel data) => json.encode(data.toJson());

class TestModel {
  List<Datum> data;
  Links links;
  Meta meta;

  TestModel({
    required this.data,
    required this.links,
    required this.meta,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    links: Links.fromJson(json["links"]),
    meta: Meta.fromJson(json["meta"]),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "links": links.toJson(),
    "meta": meta.toJson(),
  };
}

class Datum {
  String title;
  String image;
  String province;
  String city;
  String village;
  String address;
  String url;
  int minPrice;
  UnitPrice unitPrice;
  int maxDiscountPercent;
  int maxDiscountPrice;
  double dollarEquivalent;
  Currency currency;

  Datum({
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

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    title: json["title"],
    image: json["image"],
    province: json["province"],
    city: json["city"],
    village: json["village"],
    address: json["address"],
    url: json["url"],
    minPrice: json["min_price"],
    unitPrice: unitPriceValues.map[json["unit_price"]]!,
    maxDiscountPercent: json["max_discount_percent"],
    maxDiscountPrice: json["max_discount_price"],
    dollarEquivalent: json["dollar_equivalent"]?.toDouble(),
    currency: currencyValues.map[json["currency"]]!,
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
    "unit_price": unitPriceValues.reverse[unitPrice],
    "max_discount_percent": maxDiscountPercent,
    "max_discount_price": maxDiscountPrice,
    "dollar_equivalent": dollarEquivalent,
    "currency": currencyValues.reverse[currency],
  };
}

enum Currency {
  EMPTY
}

final currencyValues = EnumValues({
  "ریال": Currency.EMPTY
});

enum UnitPrice {
  EMPTY,
  PURPLE,
  UNIT_PRICE
}

final unitPriceValues = EnumValues({
  "سوئیت": UnitPrice.EMPTY,
  "کلبه": UnitPrice.PURPLE,
  "اتاق": UnitPrice.UNIT_PRICE
});

class Links {
  String first;
  String last;
  dynamic prev;
  String next;

  Links({
    required this.first,
    required this.last,
    required this.prev,
    required this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toJson() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  int currentPage;
  int from;
  int lastPage;
  List<Link> links;
  String path;
  int perPage;
  int to;
  int total;

  Meta({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links.map((x) => x.toJson())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  String? url;
  String label;
  bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
