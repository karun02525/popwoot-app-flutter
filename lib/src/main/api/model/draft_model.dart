import 'dart:convert';

DraftModel draftModelFromJson(String str) => DraftModel.fromJson(json.decode(str));

String draftModelToJson(DraftModel data) => json.encode(data.toJson());

class DraftModel {
  DraftModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<Datum> data;

  factory DraftModel.fromJson(Map<String, dynamic> json) => DraftModel(
    status: json["status"],
    message: json["message"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
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
  String nrating;
  int atype;
  int nsearch;
  String audio;
  String youtubeurl;
  int published;
  String imgarray;
  String pid;
  String createddate;
  String pcode;
  String cid;
  String rdate;
  String nreview;
  String nlike;
  String rdname;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
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
