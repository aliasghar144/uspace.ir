
import 'package:get/get.dart';
import 'package:uspace_ir/constance/constance.dart';

class Comment {
  String name;
  String id;
  DateTime date;
  String? comment;
  String show;
  String type;
  RxInt likes;
  RxInt dislikes;
  // RxBool like;
  // RxBool dislike;
  List<Reply> replies;
  String? durationReserve;
  Option? option1;
  Option? option2;
  Option? option3;
  Option? option4;
  Option? option5;

  Comment({
    required this.name,
    required this.id,
    required this.date,
    required this.comment,
    required this.show,
    required this.type,
    required this.likes,
    // required this.like,
    // required this.dislike,
    required this.dislikes,
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
    id: json["id"],
    date: DateTime.parse(json["date"]),
    comment: json["comment"],
    show: json["show"],
    type: json["type"],
    likes: RxInt(json['likes']),
    dislikes: RxInt(json['dislikes']),
    // like: likedComment.contains(json["id"]) ? RxBool(true) : RxBool(false),
    // dislike: dislikedComment.contains(json["id"]) ? RxBool(true) : RxBool(false),
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
