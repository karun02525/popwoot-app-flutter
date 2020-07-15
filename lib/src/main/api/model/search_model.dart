import 'dart:convert';

SearchModel searchModelFromJson(String str) => SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.status,
    this.message,
    this.data,
  });

  bool status;
  String message;
  List<SearchList> data;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
    status: json["status"],
    message: json["message"],
    data: List<SearchList>.from(json["data"].map((x) => SearchList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SearchList {
  SearchList({
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
  dynamic youtubeurl;
  int published;
  dynamic imgarray;
  String pid;
  String createddate;
  String pcode;
  String cid;
  String rdate;
  dynamic nreview;
  dynamic nlike;
  dynamic rdname;

  factory SearchList.fromJson(Map<String, dynamic> json) => SearchList(
    id: json["id"],
    pdesc: json["pdesc"],
    comment: json["comment"],
    ipath: json["ipath"],
    user: json["username"],
    userid: json["userid"],
    userimg: json["userimg"],
    astar: json["astar"],
    pname: json["pname"],
    ncomment: json["ncomment"],
    nrating: json["nrating"],
    atype: json["atype"],
    nsearch: json["nsearch"],
    youtubeurl: json["youtubeurl"],
    published: json["published"],
    imgarray: json["imgarray"],
    pid: json["pid"],
    createddate: json["createddate"],
    pcode: json["pcode"],
    cid: json["cid"] == null ? null : json["cid"],
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
    "username": user,
    "userid": userid,
    "userimg": userimg,
    "astar": astar,
    "pname": pname,
    "ncomment": ncomment,
    "nrating": nrating,
    "atype": atype,
    "nsearch": nsearch,
    "youtubeurl": youtubeurl,
    "published": published,
    "imgarray": imgarray,
    "pid": pid,
    "createddate": createddate,
    "pcode": pcode,
    "cid": cid == null ? null : cid,
    "rdate": rdate,
    "nreview": nreview,
    "nlike": nlike,
    "rdname": rdname,
  };
}
