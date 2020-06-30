import 'dart:convert';

ProductModel productModelFromJson(String str) => ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  ProductModel({
    this.status,
    this.message,
    this.idata,
  });

  bool status;
  String message;
  ProductData idata;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
    status: json["status"],
    message: json["message"],
    idata: ProductData.fromJson(json["idata"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "idata": idata.toJson(),
  };
}

class ProductData {
  ProductData({
    this.id,
    this.pdesc,
    this.comment,
    this.ipath,
    this.user,
    this.userid,
    this.userimg,
    this.astar,
    this.pname,
    this.ncomment,
    this.nrating,
    this.atype,
    this.nsearch,
    this.audio,
    this.youtubeurl,
    this.published,
    this.imgarray,
    this.pid,
    this.createddate,
    this.pcode,
    this.cid,
    this.rdate,
    this.nreview,
    this.nlike,
    this.rdname,
  });

  String id;
  String pdesc;
  dynamic comment;
  String ipath;
  dynamic user;
  dynamic userid;
  dynamic userimg;
  dynamic astar;
  String pname;
  int ncomment;
  dynamic nrating;
  int atype;
  int nsearch;
  dynamic audio;
  dynamic youtubeurl;
  int published;
  dynamic imgarray;
  String pid;
  String createddate;
  String pcode;
  dynamic cid;
  String rdate;
  dynamic nreview;
  dynamic nlike;
  dynamic rdname;

  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
    id: json["id"],
    pdesc: json["pdesc"],
    comment: json["comment"],
    ipath: json["ipath"],
    user: json["user"],
    userid: json["userid"],
    userimg: json["userimg"],
    astar: json["astar"],
    pname: json["pname"],
    ncomment: json["ncomment"],
    nrating: json["nrating"],
    atype: json["atype"],
    nsearch: json["nsearch"],
    audio: json["audio"],
    youtubeurl: json["youtubeurl"],
    published: json["published"],
    imgarray: json["imgarray"],
    pid: json["pid"],
    createddate: json["createddate"],
    pcode: json["pcode"],
    cid: json["cid"],
    rdate: json["rdate"],
    nreview: json["nreview"],
    nlike: json["nlike"],
    rdname: json["rdname"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pdesc": pdesc,
    "comment": comment,
    "ipath": ipath,
    "user": user,
    "userid": userid,
    "userimg": userimg,
    "astar": astar,
    "pname": pname,
    "ncomment": ncomment,
    "nrating": nrating,
    "atype": atype,
    "nsearch": nsearch,
    "audio": audio,
    "youtubeurl": youtubeurl,
    "published": published,
    "imgarray": imgarray,
    "pid": pid,
    "createddate": createddate,
    "pcode": pcode,
    "cid": cid,
    "rdate": rdate,
    "nreview": nreview,
    "nlike": nlike,
    "rdname": rdname,
  };
}
