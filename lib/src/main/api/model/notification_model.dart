import 'dart:convert';

NotificationModel notificationModelFromJson(String str) => NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) => json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<NotificationData> data;

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    status: json["status"],
    message: json["message"],
    data: List<NotificationData>.from(json["data"].map((x) => NotificationData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class NotificationData {
  NotificationData({
    this.notificationId,
    this.uid,
    this.vid,
    this.title,
    this.message,
    this.category,
    this.type,
    this.createAt,
  });

  String notificationId;
  String uid;
  String vid;
  String title;
  String message;
  String category;
  String type;
  DateTime createAt;

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
    notificationId: json["notification_id"],
    uid: json["uid"],
    vid: json["vid"] == null ? null : json["vid"],
    title: json["title"],
    message: json["message"],
    category: json["category"],
    type: json["type"],
    createAt: DateTime.parse(json["create_at"]),
  );

  Map<String, dynamic> toJson() => {
    "notification_id": notificationId,
    "uid": uid,
    "vid": vid == null ? null : vid,
    "title": title,
    "message": message,
    "category": category,
    "type": type,
    "create_at": createAt.toIso8601String(),
  };
}
