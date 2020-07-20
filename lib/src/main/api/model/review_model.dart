import 'dart:convert';

ReviewModel storeModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String storeModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  ReviewModel({
    this.status,
    this.message,
    this.page,
    this.data,
    this.idata,
  });

  bool status;
  String message;
  dynamic page;
  dynamic data;
  Idata idata;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    status: json["status"],
    message: json["message"],
    page: json["page"],
    data: json["data"],
    idata: Idata.fromJson(json["idata"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "page": page,
    "data": data,
    "idata": idata.toJson(),
  };
}

class Idata {
  Idata({
    this.uid,
    this.username,
    this.email,
    this.mobile,
    this.userimg,
    this.pid,
    this.pname,
    this.pdesc,
    this.pcode,
    this.avatar,
    this.productImgarray,
    this.sid,
    this.sname,
    this.savatar,
    this.cid,
    this.cname,
    this.rid,
    this.rating,
    this.comment,
    this.latitude,
    this.longitude,
    this.clatitude,
    this.clongitude,
    this.caddress,
    this.published,
    this.youtubeurl,
    this.reviewsImgarray,
    this.ncomment,
    this.nrating,
    this.nlike,
    this.atype,
    this.rdate,
    this.createddate,
    this.map,
  });

  String uid;
  String username;
  String email;
  dynamic mobile;
  String userimg;
  String pid;
  String pname;
  String pdesc;
  String pcode;
  String avatar;
  List<String> productImgarray;
  String sid;
  String sname;
  String savatar;
  String cid;
  String cname;
  String rid;
  double rating;
  String comment;
  double latitude;
  double longitude;
  double clatitude;
  double clongitude;
  String caddress;
  int published;
  String youtubeurl;
  List<String> reviewsImgarray;
  int ncomment;
  dynamic nrating;
  int nlike;
  int atype;
  String rdate;
  String createddate;
  bool map;

  factory Idata.fromJson(Map<String, dynamic> json) => Idata(
    uid: json["uid"],
    username: json["username"],
    email: json["email"],
    mobile: json["mobile"],
    userimg: json["userimg"],
    pid: json["pid"],
    pname: json["pname"],
    pdesc: json["pdesc"],
    pcode: json["pcode"],
    avatar: json["avatar"],
    productImgarray: List<String>.from(json["product_imgarray"].map((x) => x)),
    sid: json["sid"],
    sname: json["sname"],
    savatar: json["savatar"],
    cid: json["cid"],
    cname: json["cname"],
    rid: json["rid"],
    rating: json["rating"],
    comment: json["comment"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    clatitude: json["clatitude"].toDouble(),
    clongitude: json["clongitude"].toDouble(),
    caddress: json["caddress"],
    published: json["published"],
    youtubeurl: json["youtubeurl"],
    reviewsImgarray: List<String>.from(json["reviews_imgarray"].map((x) => x)),
    ncomment: json["ncomment"],
    nrating: json["nrating"],
    nlike: json["nlike"],
    atype: json["atype"],
    rdate: json["rdate"],
    createddate: json["createddate"],
    map: json["map"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "username": username,
    "email": email,
    "mobile": mobile,
    "userimg": userimg,
    "pid": pid,
    "pname": pname,
    "pdesc": pdesc,
    "pcode": pcode,
    "avatar": avatar,
    "product_imgarray": List<dynamic>.from(productImgarray.map((x) => x)),
    "sid": sid,
    "sname": sname,
    "savatar": savatar,
    "cid": cid,
    "cname": cname,
    "rid": rid,
    "rating": rating,
    "comment": comment,
    "latitude": latitude,
    "longitude": longitude,
    "clatitude": clatitude,
    "clongitude": clongitude,
    "caddress": caddress,
    "published": published,
    "youtubeurl": youtubeurl,
    "reviews_imgarray": List<dynamic>.from(reviewsImgarray.map((x) => x)),
    "ncomment": ncomment,
    "nrating": nrating,
    "nlike": nlike,
    "atype": atype,
    "rdate": rdate,
    "createddate": createddate,
    "map": map,
  };
}
