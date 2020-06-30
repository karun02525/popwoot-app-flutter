import 'dart:convert';

CategoryModel categoryModelFromJson(String str) => CategoryModel.fromJson(json.decode(str));

String categoryModelToJson(CategoryModel data) => json.encode(data.toJson());

class CategoryModel {
  CategoryModel({
    this.status,
    this.message,
    this.data,
    this.idata,
  });

  bool status;
  String message;
  List<DataList> data;
  dynamic idata;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    status: json["status"],
    message: json["message"],
    data: List<DataList>.from(json["data"].map((x) => DataList.fromJson(x))),
    idata: json["idata"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "idata": idata,
  };
}

class DataList {
  DataList({
    this.id,
    this.cname,
    this.cdetails,
    this.cimage,
    this.follow,
    this.burl,
    this.createddate,
    this.imgarray,
    this.dname,
  });

  String id;
  String cname;
  String cdetails;
  String cimage;
  bool follow;
  String burl;
  String createddate;
  List<String> imgarray;
  String dname;

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
    id: json["id"],
    cname: json["cname"],
    cdetails: json["cdetails"],
    cimage: json["cimage"],
    follow: json["follow"],
    burl: json["burl"],
    createddate: json["createddate"],
    imgarray: List<String>.from(json["imgarray"].map((x) => x)),
    dname: json["dname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "cname": cname,
    "cdetails": cdetails,
    "cimage": cimage,
    "follow": follow,
    "burl": burl,
    "createddate": createddate,
    "imgarray": List<dynamic>.from(imgarray.map((x) => x)),
    "dname": dname,
  };
}
