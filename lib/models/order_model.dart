// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));


class OrderModel {
  Data data;

  OrderModel({
    required this.data,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    data: Data.fromJson(json["data"]),
  );

}

class Data {
  String name;
  String mobile;
  String trackCode;
  DateTime checkIn;
  DateTime miladiCheckIn;
  int duration;
  String status;
  dynamic cancelInfo;
    dynamic pay;
    dynamic availableOperations;
  List<RsvItem> rsvItems;
    Ecolodge ecolodge;
    Rules rules;
    List<Support> supports;

  Data({
    required this.name,
    required this.mobile,
    required this.trackCode,
    required this.checkIn,
    required this.miladiCheckIn,
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
    checkIn: DateTime.parse(json["check_in"]),
    miladiCheckIn: DateTime.parse(json["miladi_check_in"]),
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
}

class AvailableOperation {
    String name;
    String operation;
    String type;

    AvailableOperation({
        required this.name,
        required this.operation,
        required this.type,
    });

    factory AvailableOperation.fromJson(Map<String, dynamic> json) => AvailableOperation(
        name: json["name"],
        operation: json["operation"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "operation": operation,
        "type": type,
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

class PayElement {
    String name;
    String logo;
    String payLink;

    PayElement({
        required this.name,
        required this.logo,
        required this.payLink,
    });

    factory PayElement.fromJson(Map<String, dynamic> json) => PayElement(
        name: json["name"],
        logo: json["logo"],
        payLink: json["pay_link"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "logo": logo,
        "pay_link": payLink,
    };
}

class RsvItem {
  RxBool isExpanded = false.obs;
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
    int? floor;
  int stair;
  String roomView;
  int bedroomNumber;
  String? additionalGuestService;
  int newBookingRsc;
  String imageList;
  List<RoomFeature> features;
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
    features: List<RoomFeature>.from(json["features"].map((x) => RoomFeature.fromJson(x))),
    roomPackages: RoomPackages.fromJson(json["room_packages"]),
    dayAndPrice: List<DayAndPrice>.from(json["day_and_price"].map((x) => DayAndPrice.fromJson(x))),
  );

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
  List<RoomFeature> features;
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
    features: List<RoomFeature>.from(json["features"].map((x) => RoomFeature.fromJson(x))),
    finance: json["finance"],
  );

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
