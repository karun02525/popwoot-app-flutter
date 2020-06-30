import 'dart:convert';

CommentModel commentModelFromJson(String str) => CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    this.status,
    this.message,
    this.data,
    this.idata,
  });

  bool status;
  String message;
  List<CommentList> data;
  dynamic idata;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
    status: json["status"],
    message: json["message"],
    data: List<CommentList>.from(json["data"].map((x) => CommentList.fromJson(x))),
    idata: json["idata"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "idata": idata,
  };
}

class CommentList {
  CommentList({
    this.id,
    this.rid,
    this.comment,
    this.userid,
    this.userimg,
    this.user,
    this.createddate,
    this.rdate,
  });

  String id;
  String rid;
  String comment;
  String userid;
  String userimg;
  String user;
  String createddate;
  String rdate;

  factory CommentList.fromJson(Map<String, dynamic> json) => CommentList(
    id: json["id"],
    rid: json["rid"],
    comment: json["comment"],
    userid: json["userid"],
    userimg: json["userimg"],
    user: json["user"],
    createddate: json["createddate"],
    rdate: json["rdate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rid": rid,
    "comment": comment,
    "userid": userid,
    "userimg": userimg,
    "user": user,
    "createddate": createddate,
    "rdate": rdate,
  };
}
