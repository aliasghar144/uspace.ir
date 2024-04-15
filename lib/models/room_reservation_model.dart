// To parse this JSON data, do
//
//     final roomReservationModel = roomReservationModelFromJson(jsonString);

import 'dart:convert';

RoomReservationModel roomReservationModelFromJson(String str) => RoomReservationModel.fromJson(json.decode(str));

String roomReservationModelToJson(RoomReservationModel data) => json.encode(data.toJson());

class RoomReservationModel {
  Data data;

  RoomReservationModel({
    required this.data,
  });

  factory RoomReservationModel.fromJson(Map<String, dynamic> json) => RoomReservationModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  String title;
  String mainImage;
  String mainImageThumb;
  String province;
  String city;
  String village;
  String address;
  double mapLat;
  double mapLong;
  int visitNumber;
  String totalRate;
  AvgFbRate avgFbRate;
  AvgFbOpRate avgFbOp2Rate;
  AvgFbOpRate avgFbOp3Rate;
  AvgFbOpRate avgFbOp4Rate;
  int rsvNights;
  String url;
  int minPrice;
  String unitPrice;
  int? maxDiscountPercent;
  int? maxDiscountPrice;
  double dollarEquivalent;
  String currency;
  String capacity;
  int roomsNumber;
  String content;
  String distance;
  List<ImageList> imageList;
  Rules rules;
  List<DataFeature> features;
  List<Comment> comments;
  List<CommentsFile> commentsFiles;
  List<EcolodgeSuggestion> ecolodgeSuggestions;
  List<Room> rooms;

  Data({
    required this.title,
    required this.mainImage,
    required this.mainImageThumb,
    required this.province,
    required this.city,
    required this.village,
    required this.address,
    required this.mapLat,
    required this.mapLong,
    required this.visitNumber,
    required this.totalRate,
    required this.avgFbRate,
    required this.avgFbOp2Rate,
    required this.avgFbOp3Rate,
    required this.avgFbOp4Rate,
    required this.rsvNights,
    required this.url,
    required this.minPrice,
    required this.unitPrice,
    required this.maxDiscountPercent,
    required this.maxDiscountPrice,
    required this.dollarEquivalent,
    required this.currency,
    required this.capacity,
    required this.roomsNumber,
    required this.content,
    required this.distance,
    required this.imageList,
    required this.rules,
    required this.features,
    required this.comments,
    required this.commentsFiles,
    required this.ecolodgeSuggestions,
    required this.rooms,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    title: json["title"],
    mainImage: json["main_image"],
    mainImageThumb: json["main_image_thumb"],
    province: json["province"],
    city: json["city"],
    village: json["village"],
    address: json["address"],
    mapLat: json["map_lat"]?.toDouble(),
    mapLong: json["map_long"]?.toDouble(),
    visitNumber: json["visit_number"],
    totalRate: json["total_rate"],
    avgFbRate: AvgFbRate.fromJson(json["avg_fb_rate"]),
    avgFbOp2Rate: AvgFbOpRate.fromJson(json["avg_fb_op2_rate"]),
    avgFbOp3Rate: AvgFbOpRate.fromJson(json["avg_fb_op3_rate"]),
    avgFbOp4Rate: AvgFbOpRate.fromJson(json["avg_fb_op4_rate"]),
    rsvNights: json["rsv_nights"],
    url: json["url"],
    minPrice: json["min_price"],
    unitPrice: json["unit_price"],
    maxDiscountPercent: json["max_discount_percent"],
    maxDiscountPrice: json["max_discount_price"],
    dollarEquivalent: json["dollar_equivalent"]?.toDouble(),
    currency: json["currency"],
    capacity: json["capacity"],
    roomsNumber: json["rooms_number"],
    content: json["content"],
    distance: json["distance"],
    imageList: List<ImageList>.from(json["image_list"].map((x) => ImageList.fromJson(x))),
    rules: Rules.fromJson(json["rules"]),
    features: List<DataFeature>.from(json["features"].map((x) => DataFeature.fromJson(x))),
    comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
    commentsFiles: List<CommentsFile>.from(json["comments_files"].map((x) => CommentsFile.fromJson(x))),
    ecolodgeSuggestions: List<EcolodgeSuggestion>.from(json["ecolodge_suggestions"].map((x) => EcolodgeSuggestion.fromJson(x))),
    rooms: List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "main_image": mainImage,
    "main_image_thumb": mainImageThumb,
    "province": province,
    "city": city,
    "village": village,
    "address": address,
    "map_lat": mapLat,
    "map_long": mapLong,
    "visit_number": visitNumber,
    "total_rate": totalRate,
    "avg_fb_rate": avgFbRate.toJson(),
    "avg_fb_op2_rate": avgFbOp2Rate.toJson(),
    "avg_fb_op3_rate": avgFbOp3Rate.toJson(),
    "avg_fb_op4_rate": avgFbOp4Rate.toJson(),
    "rsv_nights": rsvNights,
    "url": url,
    "min_price": minPrice,
    "unit_price": unitPrice,
    "max_discount_percent": maxDiscountPercent,
    "max_discount_price": maxDiscountPrice,
    "dollar_equivalent": dollarEquivalent,
    "currency": currency,
    "capacity": capacity,
    "rooms_number": roomsNumber,
    "content": content,
    "distance": distance,
    "image_list": List<dynamic>.from(imageList.map((x) => x.toJson())),
    "rules": rules.toJson(),
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
    "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
    "comments_files": List<dynamic>.from(commentsFiles.map((x) => x.toJson())),
    "ecolodge_suggestions": List<dynamic>.from(ecolodgeSuggestions.map((x) => x.toJson())),
    "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
  };
}

class AvgFbOpRate {
  String title;
  double value;

  AvgFbOpRate({
    required this.title,
    required this.value,
  });

  factory AvgFbOpRate.fromJson(Map<String, dynamic> json) => AvgFbOpRate(
    title: json["title"],
    value: json["value"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": value,
  };
}

class AvgFbRate {
  String title;
  double value;
  int numberFeedback;

  AvgFbRate({
    required this.title,
    required this.value,
    required this.numberFeedback,
  });

  factory AvgFbRate.fromJson(Map<String, dynamic> json) => AvgFbRate(
    title: json["title"],
    value: json["value"]?.toDouble(),
    numberFeedback: json["number_feedback"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "value": value,
    "number_feedback": numberFeedback,
  };
}

class Comment {
  String name;
  DateTime date;
  String? comment;
  String show;
  String type;
  List<Reply> replies;
  String? durationReserve;
  Option? option1;
  Option? option2;
  Option? option3;
  Option? option4;
  Option? option5;

  Comment({
    required this.name,
    required this.date,
    required this.comment,
    required this.show,
    required this.type,
    required this.replies,
    this.durationReserve,
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.option5,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    name: json["name"],
    date: DateTime.parse(json["date"]),
    comment: json["comment"],
    show: json["show"],
    type: json["type"],
    replies: List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
    durationReserve: json["duration_reserve"],
    option1: json["option1"] == null ? null : Option.fromJson(json["option1"]),
    option2: json["option2"] == null ? null : Option.fromJson(json["option2"]),
    option3: json["option3"] == null ? null : Option.fromJson(json["option3"]),
    option4: json["option4"] == null ? null : Option.fromJson(json["option4"]),
    option5: json["option5"] == null ? null : Option.fromJson(json["option5"]),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "date": date.toIso8601String(),
    "comment": comment,
    "show": show,
    "type": type,
    "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
    "duration_reserve": durationReserve,
    "option1": option1?.toJson(),
    "option2": option2?.toJson(),
    "option3": option3?.toJson(),
    "option4": option4?.toJson(),
    "option5": option5?.toJson(),
  };
}

class Option {
  String title;
  String? point;

  Option({
    required this.title,
    required this.point,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
    title: json["title"],
    point: json["point"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "point": point,
  };
}

class Reply {
  String? replier;
  String? replyComment;
  String? replyDate;
  String? replyAvatar;

  Reply({
     this.replier,
     this.replyComment,
     this.replyDate,
     this.replyAvatar,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    replier: json["replier"],
    replyComment: json["reply_comment"],
    replyDate: json["reply_date"],
    replyAvatar: json["reply_avatar"],
  );

  Map<String, dynamic> toJson() => {
    "replier": replier,
    "reply_comment": replyComment,
        "reply_date": replyDate,
    "reply_avatar": replyAvatar,
  };
}

class CommentsFile {
  int feedbackId;
  String type;
  String fileName;
  int fileSize;

  CommentsFile({
    required this.feedbackId,
    required this.type,
    required this.fileName,
    required this.fileSize,
  });

  factory CommentsFile.fromJson(Map<String, dynamic> json) => CommentsFile(
    feedbackId: json["feedback_id"],
    type: json["type"],
    fileName: json["file_name"],
    fileSize: json["file_size"],
  );

  Map<String, dynamic> toJson() => {
    "feedback_id": feedbackId,
    "type": type,
    "file_name": fileName,
    "file_size": fileSize,
  };
}

class EcolodgeSuggestion {
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

  EcolodgeSuggestion({
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

  factory EcolodgeSuggestion.fromJson(Map<String, dynamic> json) => EcolodgeSuggestion(
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

class DataFeature {
  int value;
  FeatureFeature feature;

  DataFeature({
    required this.value,
    required this.feature,
  });

  factory DataFeature.fromJson(Map<String, dynamic> json) => DataFeature(
    value: json["Value"],
    feature: FeatureFeature.fromJson(json["feature"]),
  );

  Map<String, dynamic> toJson() => {
    "Value": value,
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

class ImageList {
  String thumbImage;
  String fullImage;
  String? caption;

  ImageList({
    required this.thumbImage,
    required this.fullImage,
    required this.caption,
  });

  factory ImageList.fromJson(Map<String, dynamic> json) => ImageList(
    thumbImage: json["thumb_image"],
    fullImage: json["full_image"],
    caption: json["caption"],
  );

  Map<String, dynamic> toJson() => {
    "thumb_image": thumbImage,
    "full_image": fullImage,
    "caption": caption,
  };
}

class Room {
  int idRoom;
  String title;
  String? details;
  String thumbImage;
  dynamic capacity;
  int roomCapacity;
  int availableNumber;
  String unit;
  int beds;
  int singleBeds;
  int doubleBeds;
  int sofaBeds;
    int? roomArea;
    String? roomType;
  int? floor;
    int? stair;
    String? roomView;
    int? bedroomNumber;
  String? additionalGuestService;
  int newBookingRsc;
  String imageList;
  List<RoomFeature> features;
  List<RoomPackage> roomPackages;

  Room({
    required this.idRoom,
    required this.title,
    required this.details,
    required this.thumbImage,
    required this.capacity,
    required this.roomCapacity,
    required this.availableNumber,
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
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
    idRoom: json["id_room"],
    title: json["title"],
    details: json["details"],
    thumbImage: json["thumb_image"],
    capacity: json["capacity"],
    roomCapacity: json["room_capacity"],
    availableNumber: json["available_number"],
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
    roomPackages: List<RoomPackage>.from(json["room_packages"].map((x) => RoomPackage.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id_room": idRoom,
    "title": title,
    "details": details,
    "thumb_image": thumbImage,
    "capacity": capacity,
    "room_capacity": roomCapacity,
    "available_number": availableNumber,
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
    "room_packages": List<dynamic>.from(roomPackages.map((x) => x.toJson())),
  };
}

class RoomFeature {
  int value;
  FeatureFeature feature;

  RoomFeature({
    required this.value,
    required this.feature,
  });

  factory RoomFeature.fromJson(Map<String, dynamic> json) => RoomFeature(
    value: json["value"],
    feature: FeatureFeature.fromJson(json["feature"]),
  );

  Map<String, dynamic> toJson() => {
    "value": value,
    "feature": feature.toJson(),
  };
}

class RoomPackage {
  String title;
  String? titleAlias;
  int isFloating;
  int isTemporary;
  List<RoomFeature> features;
  Finance finance;

  RoomPackage({
    required this.title,
    required this.titleAlias,
    required this.isFloating,
    required this.isTemporary,
    required this.features,
    required this.finance,
  });

  factory RoomPackage.fromJson(Map<String, dynamic> json) => RoomPackage(
    title: json["title"],
    titleAlias: json["title_alias"],
    isFloating: json["is_floating"],
    isTemporary: json["is_temporary"],
    features: List<RoomFeature>.from(json["features"].map((x) => RoomFeature.fromJson(x))),
    finance: Finance.fromJson(json["finance"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "title_alias": titleAlias,
    "is_floating": isFloating,
    "is_temporary": isTemporary,
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
    "finance": finance.toJson(),
  };
}

class Finance {
  List<Day> days;
  PriceInfo priceInfo;
  String message;
  String details;
  bool reservePermission;

  Finance({
    required this.days,
    required this.priceInfo,
    required this.message,
    required this.details,
    required this.reservePermission,
  });

  factory Finance.fromJson(Map<String, dynamic> json) => Finance(
    days: List<Day>.from(json["days"].map((x) => Day.fromJson(x))),
    priceInfo: PriceInfo.fromJson(json["price_info"]),
    message: json["message"],
    details: json["details"],
    reservePermission: json["reserve_permission"],
  );

  Map<String, dynamic> toJson() => {
    "days": List<dynamic>.from(days.map((x) => x.toJson())),
    "price_info": priceInfo.toJson(),
    "message": message,
    "details": details,
    "reserve_permission": reservePermission,
  };
}

class Day {
  DateTime date;
  String jDate;
  int originalPrice;
  int priceWithDiscount;
  int additionalGustPrice;
  String availability;
  String details;
  String currency;

  Day({
    required this.date,
    required this.jDate,
    required this.originalPrice,
    required this.priceWithDiscount,
    required this.additionalGustPrice,
    required this.availability,
    required this.details,
    required this.currency,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
    date: DateTime.parse(json["date"]),
    jDate: json["j_date"],
    originalPrice: json["original_price"],
    priceWithDiscount: json["price_with_discount"],
    additionalGustPrice: json["additional_gust_price"],
    availability: json["availability"],
    details: json["details"],
    currency: json["currency"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "j_date": jDate,
    "original_price": originalPrice,
    "price_with_discount": priceWithDiscount,
    "additional_gust_price": additionalGustPrice,
    "availability": availability,
    "details": details,
    "currency": currency,
  };
}

class PriceInfo {
  int paidNumber;
  int additionalNumber;
    dynamic durationDay;
  String unit;
  int totalAvailable;
  int idSalesPackage;
  String status;
  int needPickDate;
  int bookType;
  int totalOriginalPrice;
  int totalCustomerPrice;
  String currency;
  int totalCustomerDiscount;
  int totalPay;

  PriceInfo({
    required this.paidNumber,
    required this.additionalNumber,
    required this.durationDay,
    required this.unit,
    required this.totalAvailable,
    required this.idSalesPackage,
    required this.status,
    required this.needPickDate,
    required this.bookType,
    required this.totalOriginalPrice,
    required this.totalCustomerPrice,
    required this.currency,
    required this.totalCustomerDiscount,
    required this.totalPay,
  });

  factory PriceInfo.fromJson(Map<String, dynamic> json) => PriceInfo(
    paidNumber: json["paid_number"],
    additionalNumber: json["additional_number"],
    durationDay: json["duration_day"],
    unit: json["unit"],
    totalAvailable: json["total_available"],
    idSalesPackage: json["id_sales_package"],
    status: json["status"],
    needPickDate: json["need_pick_date"],
    bookType: json["book_type"],
    totalOriginalPrice: json["total_original_price"],
    totalCustomerPrice: json["total_customer_price"],
    currency: json["currency"],
    totalCustomerDiscount: json["total_customer_discount"],
    totalPay: json["total_pay"],
  );

  Map<String, dynamic> toJson() => {
    "paid_number": paidNumber,
    "additional_number": additionalNumber,
    "duration_day": durationDay,
    "unit": unit,
    "total_available": totalAvailable,
    "id_sales_package": idSalesPackage,
    "status": status,
    "need_pick_date": needPickDate,
    "book_type": bookType,
    "total_original_price": totalOriginalPrice,
    "total_customer_price": totalCustomerPrice,
    "currency": currency,
    "total_customer_discount": totalCustomerDiscount,
    "total_pay": totalPay,
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
    kidsTerms: json["kids_terms"] ?? '',
    cancelTerms: json["cancel_terms"]?? '',
    entryTime: json["entry_time"]?? '',
    exitTime: json["exit_time"]?? '',
  );

  Map<String, dynamic> toJson() => {
    "kids_terms": kidsTerms,
    "cancel_terms": cancelTerms,
    "entry_time": entryTime,
    "exit_time": exitTime,
  };
}
