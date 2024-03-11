// To parse this JSON data, do
//
//     final roomReservationModel = roomReservationModelFromJson(jsonString);

import 'dart:convert';

RoomReservationModel roomReservationModelFromJson(String str) => RoomReservationModel.fromJson(json.decode(str));


class RoomReservationModel {
  Data data;

  RoomReservationModel({
    required this.data,
  });

  factory RoomReservationModel.fromJson(Map<String, dynamic> json) => RoomReservationModel(
    data: Data.fromJson(json["data"]),
  );

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

}

class Comment{
  String name;
  String date;
    String? durationReserve;
    dynamic option1;
    dynamic option2;
    dynamic option3;
    dynamic option4;
    dynamic option5;
  String? comment;
  String show;
    String? status;
  String type;
  List<Reply> replies;

  Comment({
    required this.name,
    required this.date,
        this.durationReserve,
        this.option1,
        this.option2,
        this.option3,
        this.option4,
        this.option5,
    required this.comment,
    required this.show,
        this.status,
    required this.type,
    required this.replies,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    name: json["name"],
    date: json["date"],
    durationReserve: json["duration_reserve"],
    option1: json["option1"],
    option2: json["option2"],
    option3: json["option3"],
    option4: json["option4"],
    option5: json["option5"],
    comment: json["comment"],
    show: json["show"],
    status: json["status"],
    type: json["type"],
    replies: List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
  );

}

class Reply {
  String? replier;
  String? replyComment;
  DateTime? replyDate;
  String? replyAvatar;

  Reply({
    required this.replier,
    required this.replyComment,
    required this.replyDate,
    required this.replyAvatar,
  });

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
    replier: json["replier"],
    replyComment: json["reply_comment"],
    replyDate: json["reply_date"] == null ? null : DateTime.parse(json["reply_date"]),
    replyAvatar: json["reply_avatar"],
  );

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
    minPrice: json["min_price"]?.toInt(),
    unitPrice: json["unit_price"],
    maxDiscountPercent: json["max_discount_percent"]?.toInt(),
    maxDiscountPrice: json["max_discount_price"]?.toInt(),
    dollarEquivalent: json["dollar_equivalent"]?.toDouble(),
    currency: json["currency"],
  );

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
}

class FeatureFeature {
  String title;
  String? image;
  int vip;
  String? unicode;

  FeatureFeature({
    required this.title,
    required this.image,
    required this.vip,
    this.unicode,
  });

  factory FeatureFeature.fromJson(Map<String, dynamic> json) => FeatureFeature(
    title: json["title"],
    image: json["image"],
    vip: json["vip"],
    unicode: json["unicode"],
  );

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

}

class Room {
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
  List<RoomPackage> roomPackages;
  int idRoom;

  Room({
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
    required this.idRoom,
  });

  factory Room.fromJson(Map<String, dynamic> json) => Room(
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
    idRoom: json["id_room"],
  );

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

}

class RoomPackage {
  String title;
  dynamic titleAlias;
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
  double totalCustomerDiscount;
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
    totalCustomerDiscount: json["total_customer_discount"]?.toDouble(),
    totalPay: json["total_pay"],
  );

}

class Rules {
  String? kidsTerms;
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

}
