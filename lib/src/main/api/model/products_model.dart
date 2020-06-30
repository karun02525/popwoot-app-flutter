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
    this.id,
    this.pname,
    this.pdescription,
    this.pcode,
    this.psearch,
    this.imgpath,
    this.burl,
    this.category,
    this.createddate,
    this.imgarray,
    this.dname,
  });

  String id;
  String pname;
  String pdescription;
  String pcode;
  String psearch;
  String imgpath;
  String burl;
  String category;
  String createddate;
  List<String> imgarray;
  String dname;

  factory ProductListData.fromJson(Map<String, dynamic> json) => ProductListData(
    id: json["id"],
    pname: json["pname"],
    pdescription: json["pdescription"],
    pcode: json["pcode"],
    psearch: json["psearch"],
    imgpath: json["imgpath"],
    burl: json["burl"],
    category: json["category"],
    createddate: json["createddate"],
    imgarray: List<String>.from(json["imgarray"].map((x) => x)),
    dname: json["dname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pname": pname,
    "pdescription": pdescription,
    "pcode": pcode,
    "psearch": psearch,
    "imgpath": imgpath,
    "burl": burl,
    "category": category,
    "createddate": createddate,
    "imgarray": List<dynamic>.from(imgarray.map((x) => x)),
    "dname": dname,
  };
}
