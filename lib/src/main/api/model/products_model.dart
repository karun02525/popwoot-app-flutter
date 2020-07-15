import 'dart:convert';

ProductsModel productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel data) => json.encode(data.toJson());

class ProductsModel {
  ProductsModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<ProductListData> data;

  factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
    status: json["status"],
    message: json["message"],
    data: List<ProductListData>.from(json["data"].map((x) => ProductListData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class ProductListData {
  ProductListData({
    this.pid,
    this.pname,
    this.pdesc,
    this.pcode,
    this.avatar,
    this.imgarray,
  });

  String pid;
  String pname;
  String pdesc;
  String pcode;
  String avatar;
  List<String> imgarray;

  factory ProductListData.fromJson(Map<String, dynamic> json) => ProductListData(
    pid: json["pid"],
    pname: json["pname"],
    pdesc: json["pdesc"],
    pcode: json["pcode"],
    avatar: json["avatar"],
    imgarray: List<String>.from(json["imgarray"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "pid": pid,
    "pname": pname,
    "pdesc": pdesc,
    "pcode": pcode,
    "avatar": avatar,
    "imgarray": List<dynamic>.from(imgarray.map((x) => x)),
  };
}
