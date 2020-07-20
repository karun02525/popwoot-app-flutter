import 'dart:convert';

ProductModel storeModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String storeModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  ProductData data;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    status: json["status"],
    message: json["message"],
    data: ProductData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class ProductData {
  ProductData({
    this.pid,
    this.pname,
    this.pdesc,
    this.pcode,
    this.psearch,
    this.avatar,
    this.storeUrl,
    this.cid,
    this.cname,
    this.ncomment,
    this.nrating,
    this.atype,
    this.imgarray,
  });

  String pid;
  String pname;
  String pdesc;
  String pcode;
  String psearch;
  String avatar;
  String storeUrl;
  String cid;
  String cname;
  int ncomment;
  dynamic nrating;
  int atype;
  List<String> imgarray;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    pid: json["pid"],
    pname: json["pname"],
    pdesc: json["pdesc"],
    pcode: json["pcode"],
    psearch: json["psearch"],
    avatar: json["avatar"],
    storeUrl: json["store_url"],
    cid: json["cid"],
    cname: json["cname"],
    ncomment: json["ncomment"],
    nrating: json["nrating"],
    atype: json["atype"],
    imgarray: List<String>.from(json["imgarray"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "pid": pid,
    "pname": pname,
    "pdesc": pdesc,
    "pcode": pcode,
    "psearch": psearch,
    "avatar": avatar,
    "store_url": storeUrl,
    "cid": cid,
    "cname": cname,
    "ncomment": ncomment,
    "nrating": nrating,
    "atype": atype,
    "imgarray": List<dynamic>.from(imgarray.map((x) => x)),
  };
}
