// To parse this JSON data, do
//
//     final orderDetailsModel = orderDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';
import 'package:uspace_ir/models/room_reservation_model.dart';

OrderDetailsModel orderDetailsModelFromJson(String str) => OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel data) => json.encode(data.toJson());

class OrderDetailsModel {
  Data data;

  OrderDetailsModel({
    required this.data,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) => OrderDetailsModel(
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
  DateTime miladiCheckIn;
  int duration;
  String status;
    CancelInfo? cancelInfo;
    List<Pay> pay;
    List<AvailableOperation> availableOperations;
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
        checkIn: json["check_in"],
    miladiCheckIn: DateTime.parse(json["miladi_check_in"]),
    duration: json["duration"],
    status: json["status"],
        cancelInfo: json["cancel_info"] == null ? null : CancelInfo.fromJson(json["cancel_info"]),
        pay: List<Pay>.from(json["pay"].map((x) => Pay.fromJson(x))),
        availableOperations: List<AvailableOperation>.from(json["available_operations"].map((x) => AvailableOperation.fromJson(x))),
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
        "miladi_check_in": "${miladiCheckIn.year.toString().padLeft(4, '0')}-${miladiCheckIn.month.toString().padLeft(2, '0')}-${miladiCheckIn.day.toString().padLeft(2, '0')}",
        "duration": duration,
        "status": status,
        "cancel_info": cancelInfo?.toJson(),
        "pay": List<dynamic>.from(pay.map((x) => x.toJson())),
        "available_operations": List<dynamic>.from(availableOperations.map((x) => x.toJson())),
        "rsv_items": List<dynamic>.from(rsvItems.map((x) => x.toJson())),
        "ecolodge": ecolodge.toJson(),
        "rules": rules.toJson(),
        "supports": List<dynamic>.from(supports.map((x) => x.toJson())),
    };
}

class AvailableOperation {
    String name;
    String operation;
    String type;
    String? btnType;
    String? btnColor;

    AvailableOperation({
        required this.name,
        required this.operation,
        required this.type,
        this.btnType,
        this.btnColor,
    });

    factory AvailableOperation.fromJson(Map<String, dynamic> json) => AvailableOperation(
        name: json["name"],
        operation: json["operation"],
        type: json["type"],
        btnType: json["btn_type"],
        btnColor: json["btn_color"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "operation": operation,
        "type": type,
        "btn_type": btnType,
        "btn_color": btnColor,
    };
}

class CancelInfo {
    int cancelId;
    int rid;
    dynamic hesab;
    dynamic sheba;
    String bank;
    dynamic amountCheckout;
    dynamic returnMoney;
    dynamic description;
    dynamic settleDescription;
    dynamic cancelReason;
    int cancelCode;
    dynamic rejectComment;
    dynamic idOperator;
    dynamic manualCanceling;
    int silentSettle;
    dynamic settled;
    int state;
    int isArchive;
    DateTime createdAt;
    DateTime updatedAt;

    CancelInfo({
        required this.cancelId,
        required this.rid,
        required this.hesab,
        required this.sheba,
        required this.bank,
        required this.amountCheckout,
        required this.returnMoney,
        required this.description,
        required this.settleDescription,
        required this.cancelReason,
        required this.cancelCode,
        required this.rejectComment,
        required this.idOperator,
        required this.manualCanceling,
        required this.silentSettle,
        required this.settled,
        required this.state,
        required this.isArchive,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CancelInfo.fromJson(Map<String, dynamic> json) => CancelInfo(
        cancelId: json["cancel_id"],
        rid: json["rid"],
        hesab: json["hesab"],
        sheba: json["sheba"],
        bank: json["bank"],
        amountCheckout: json["amount_checkout"],
        returnMoney: json["return_money"],
        description: json["description"],
        settleDescription: json["settle_description"],
        cancelReason: json["cancel_reason"],
        cancelCode: json["cancel_code"],
        rejectComment: json["reject_comment"],
        idOperator: json["id_operator"],
        manualCanceling: json["manual_canceling"],
        silentSettle: json["silent_settle"],
        settled: json["settled"],
        state: json["state"],
        isArchive: json["is_archive"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "cancel_id": cancelId,
        "rid": rid,
        "hesab": hesab,
        "sheba": sheba,
        "bank": bank,
        "amount_checkout": amountCheckout,
        "return_money": returnMoney,
        "description": description,
        "settle_description": settleDescription,
        "cancel_reason": cancelReason,
        "cancel_code": cancelCode,
        "reject_comment": rejectComment,
        "id_operator": idOperator,
        "manual_canceling": manualCanceling,
        "silent_settle": silentSettle,
        "settled": settled,
        "state": state,
        "is_archive": isArchive,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
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

class Pay {
    String name;
    String logo;
    String payLink;

    Pay({
        required this.name,
        required this.logo,
        required this.payLink,
    });

    factory Pay.fromJson(Map<String, dynamic> json) => Pay(
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
    String? details;
  String thumbImage;
  int roomCapacity;
  String unit;
  int? beds;
  int? singleBeds;
  int? doubleBeds;
  int? sofaBeds;
  int? roomArea;
  String? roomType;
  int? floor;
  int? stair;
  String? roomView;
  int? bedroomNumber;
  String? additionalGuestService;
  int? newBookingRsc;
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
  String unicode;
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
  String? entryTime;
  String? exitTime;

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
