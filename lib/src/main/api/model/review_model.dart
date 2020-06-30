import 'dart:convert';

ReviewModel reviewModelFromJson(String str) => ReviewModel.fromJson(json.decode(str));

String reviewModelToJson(ReviewModel data) => json.encode(data.toJson());

class ReviewModel {
  ReviewModel({
    this.status,
    this.message,
    this.idata,
  });

  bool status;
  String message;
  Idata idata;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    status: json["status"],
    message: json["message"],
    idata: Idata.fromJson(json["idata"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "idata": idata.toJson(),
  };
}

class Idata {
  Idata({
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
  String comment;
  String ipath;
  String user;
  String userid;
  String userimg;
  String astar;
  String pname;
  int ncomment;
  dynamic nrating;
  int atype;
  int nsearch;
  String audio;
  String youtubeurl;
  int published;
  List<String> imgarray;
  String pid;
  String createddate;
  String pcode;
  String cid;
  String rdate;
  dynamic nreview;
  int nlike;
  String rdname;

  factory Idata.fromJson(Map<String, dynamic> json) => Idata(
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
    imgarray: List<String>.from(json["imgarray"].map((x) => x)),
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
    "imgarray": List<dynamic>.from(imgarray.map((x) => x)),
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
