class CategoryModel {
    List<DataModel> data;
    String message;
    bool status;

    CategoryModel({this.data, this.message, this.status});

    factory CategoryModel.fromJson(Map<String, dynamic> json) {
        return CategoryModel(
            data: json['data'] != null ? (json['data'] as List).map((i) => DataModel.fromJson(i)).toList() : null,
            message: json['message'],
            status: json['status'],
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['message'] = this.message;
        data['status'] = this.status;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class DataModel {
    String burl;
    String cdetails;
    String cimage;
    String cname;
    String createddate;
    String dname;
    bool follow;
    String id;
    List<String> imgarray;

    DataModel({this.burl, this.cdetails, this.cimage, this.cname, this.createddate, this.dname, this.follow, this.id, this.imgarray});

    factory DataModel.fromJson(Map<String, dynamic> json) {
        return DataModel(
            burl: json['burl'],
            cdetails: json['cdetails'],
            cimage: json['cimage'],
            cname: json['cname'],
            createddate: json['createddate'],
            dname: json['dname'],
            follow: json['follow'],
            id: json['id'],
            imgarray: json['imgarray'] != null ? new List<String>.from(json['imgarray']) : null,
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['burl'] = this.burl;
        data['cdetails'] = this.cdetails;
        data['cimage'] = this.cimage;
        data['cname'] = this.cname;
        data['createddate'] = this.createddate;
        data['dname'] = this.dname;
        data['follow'] = this.follow;
        data['id'] = this.id;
        if (this.imgarray != null) {
            data['imgarray'] = this.imgarray;
        }
        return data;
    }
}