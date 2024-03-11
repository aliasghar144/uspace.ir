// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  Data data;

  OrderModel({
    required this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  String name;
  String mobile;
  String trackCode;
  String checkIn;
  int duration;
  String status;
  dynamic cancelInfo;
  String pay;
  String availableOperations;
  List<RsvItem> rsvItems;
  Ecolodge ecolodge;
  Rules rules;
  List<Support> supports;

  Data({
    required this.name,
    required this.mobile,
    required this.trackCode,
    required this.checkIn,
    required this.duration,
    required this.status,
    required this.cancelInfo,
    required this.pay,
    required this.availableOperations,
    required this.rsvItems,
    required this.ecolodge,
    required this.rules,
    required this.supports,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    mobile: json["mobile"],
    trackCode: json["track_code"],
    checkIn: json["check_in"],
    duration: json["duration"],
    status: json["status"],
    cancelInfo: json["cancel_info"],
    pay: json["pay"],
    availableOperations: json["available_operations"],
    rsvItems: List<RsvItem>.from(json["rsv_items"].map((x) => RsvItem.fromJson(x))),
    ecolodge: Ecolodge.fromJson(json["ecolodge"]),
    rules: Rules.fromJson(json["rules"]),
    supports: List<Support>.from(json["supports"].map((x) => Support.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile": mobile,
    "track_code": trackCode,
    "check_in": checkIn,
    "duration": duration,
    "status": status,
    "cancel_info": cancelInfo,
    "pay": pay,
    "available_operations": availableOperations,
    "rsv_items": List<dynamic>.from(rsvItems.map((x) => x.toJson())),
    "ecolodge": ecolodge.toJson(),
    "rules": rules.toJson(),
    "supports": List<dynamic>.from(supports.map((x) => x.toJson())),
  };
}

class Ecolodge {
  String title;
  String url;
  String shortTitle;

  Ecolodge({
    required this.title,
    required this.url,
    required this.shortTitle,
  });

  factory Ecolodge.fromJson(Map<String, dynamic> json) => Ecolodge(
    title: json["title"],
    url: json["url"],
    shortTitle: json["short_title"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "url": url,
    "short_title": shortTitle,
  };
}

class RsvItem {
  String title;
  dynamic details;
  String thumbImage;
  int roomCapacity;
  String unit;
  int beds;
  int singleBeds;
  int doubleBeds;
  int sofaBeds;
  int roomArea;
  String roomType;
  int floor;
  int stair;
  String roomView;
  int bedroomNumber;
  String? additionalGuestService;
  int newBookingRsc;
  String imageList;
  List<FeatureElement> features;
  RoomPackages roomPackages;
  List<DayAndPrice> dayAndPrice;

  RsvItem({
    required this.title,
    required this.details,
    required this.thumbImage,
    required this.roomCapacity,
    required this.unit,
    required this.beds,
    required this.singleBeds,
    required this.doubleBeds,
    required this.sofaBeds,
    required this.roomArea,
    required this.roomType,
    required this.floor,
    required this.stair,
    required this.roomView,
    required this.bedroomNumber,
    required this.additionalGuestService,
    required this.newBookingRsc,
    required this.imageList,
    required this.features,
    required this.roomPackages,
    required this.dayAndPrice,
  });

  factory RsvItem.fromJson(Map<String, dynamic> json) => RsvItem(
    title: json["title"],
    details: json["details"],
    thumbImage: json["thumb_image"],
    roomCapacity: json["room_capacity"],
    unit: json["unit"],
    beds: json["beds"],
    singleBeds: json["single_beds"],
    doubleBeds: json["double_beds"],
    sofaBeds: json["sofa_beds"],
    roomArea: json["room_area"],
    roomType: json["room_type"],
    floor: json["floor"],
    stair: json["stair"],
    roomView: json["room_view"],
    bedroomNumber: json["bedroom_number"],
    additionalGuestService: json["additional_guest_service"],
    newBookingRsc: json["new_booking_rsc"],
    imageList: json["image_list"],
    features: List<FeatureElement>.from(json["features"].map((x) => FeatureElement.fromJson(x))),
    roomPackages: RoomPackages.fromJson(json["room_packages"]),
    dayAndPrice: List<DayAndPrice>.from(json["day_and_price"].map((x) => DayAndPrice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "details": details,
    "thumb_image": thumbImage,
    "room_capacity": roomCapacity,
    "unit": unit,
    "beds": beds,
    "single_beds": singleBeds,
    "double_beds": doubleBeds,
    "sofa_beds": sofaBeds,
    "room_area": roomArea,
    "room_type": roomType,
    "floor": floor,
    "stair": stair,
    "room_view": roomView,
    "bedroom_number": bedroomNumber,
    "additional_guest_service": additionalGuestService,
    "new_booking_rsc": newBookingRsc,
    "image_list": imageList,
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
    "room_packages": roomPackages.toJson(),
    "day_and_price": List<dynamic>.from(dayAndPrice.map((x) => x.toJson())),
  };
}

class DayAndPrice {
  DateTime date;
  String jDate;
  int originalPrice;
  int priceWithDiscount;
  int additionalGustPrice;
  dynamic details;
  String currency;

  DayAndPrice({
    required this.date,
    required this.jDate,
    required this.originalPrice,
    required this.priceWithDiscount,
    required this.additionalGustPrice,
    required this.details,
    required this.currency,
  });

  factory DayAndPrice.fromJson(Map<String, dynamic> json) => DayAndPrice(
    date: DateTime.parse(json["date"]),
    jDate: json["j_date"],
    originalPrice: json["original_price"],
    priceWithDiscount: json["price_with_discount"],
    additionalGustPrice: json["additional_gust_price"],
    details: json["details"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "j_date": jDate,
    "original_price": originalPrice,
    "price_with_discount": priceWithDiscount,
    "additional_gust_price": additionalGustPrice,
    "details": details,
    "currency": currency,
  };
}

class FeatureElement {
  int value;
  FeatureFeature feature;

  FeatureElement({
    required this.value,
    required this.feature,
  });

  factory FeatureElement.fromJson(Map<String, dynamic> json) => FeatureElement(
    value: json["value"],
    feature: FeatureFeature.fromJson(json["feature"]),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "feature": feature.toJson(),
  };
}

class FeatureFeature {
  String title;
  String? image;
  String? unicode;
  int vip;

  FeatureFeature({
    required this.title,
    required this.image,
    required this.unicode,
    required this.vip,
  });

  factory FeatureFeature.fromJson(Map<String, dynamic> json) => FeatureFeature(
    title: json["title"],
    image: json["image"],
    unicode: json["unicode"],
    vip: json["vip"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "image": image,
    "unicode": unicode,
    "vip": vip,
  };
}

class RoomPackages {
  String title;
  dynamic titleAlias;
  int isFloating;
  int isTemporary;
  List<FeatureElement> features;
  dynamic finance;

  RoomPackages({
    required this.title,
    required this.titleAlias,
    required this.isFloating,
    required this.isTemporary,
    required this.features,
    required this.finance,
  });

  factory RoomPackages.fromJson(Map<String, dynamic> json) => RoomPackages(
    title: json["title"],
    titleAlias: json["title_alias"],
    isFloating: json["is_floating"],
    isTemporary: json["is_temporary"],
    features: List<FeatureElement>.from(json["features"].map((x) => FeatureElement.fromJson(x))),
    finance: json["finance"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "title_alias": titleAlias,
    "is_floating": isFloating,
    "is_temporary": isTemporary,
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
    "finance": finance,
  };
}

class Rules {
  String kidsTerms;
  String cancelTerms;
  String entryTime;
  String exitTime;

  Rules({
    required this.kidsTerms,
    required this.cancelTerms,
    required this.entryTime,
    required this.exitTime,
  });

  factory Rules.fromJson(Map<String, dynamic> json) => Rules(
    kidsTerms: json["kids_terms"],
    cancelTerms: json["cancel_terms"],
    entryTime: json["entry_time"],
    exitTime: json["exit_time"],
  );

  Map<String, dynamic> toJson() => {
    "kids_terms": kidsTerms,
    "cancel_terms": cancelTerms,
    "entry_time": entryTime,
    "exit_time": exitTime,
  };
}

class Support {
  String? support1;
  String? support2;

  Support({
    this.support1,
    this.support2,
  });

  factory Support.fromJson(Map<String, dynamic> json) => Support(
    support1: json["support1"],
    support2: json["support2"],
  );

  Map<String, dynamic> toJson() => {
    "support1": support1,
    "support2": support2,
  };
}
