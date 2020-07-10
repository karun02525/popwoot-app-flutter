import 'dart:convert';

StoreModel storeModelFromJson(String str) => StoreModel.fromJson(json.decode(str));

String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
  StoreModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<StoreData> data;

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    status: json["status"],
    message: json["message"],
    data: List<StoreData>.from(json["data"].map((x) => StoreData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class StoreData {
  StoreData({
    this.id,
    this.sname,
    this.surl,
    this.isMap,
    this.createddate,
  });

  String id;
  String sname;
  String surl;
  bool isMap;
  String createddate;

  factory StoreData.fromJson(Map<String, dynamic> json) => StoreData(
    id: json["id"],
    sname: json["sname"],
    surl: json["surl"],
    isMap: json["isMap"],
    createddate: json["createddate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sname": sname,
    "surl": surl,
    "isMap": isMap,
    "createddate": createddate,
  };
}
