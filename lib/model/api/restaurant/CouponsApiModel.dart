class CouponsApiModel {
    int code;
    List<CouponsDataApiModel> data;
    String msg;

    CouponsApiModel({this.code, this.data, this.msg});

    CouponsApiModel.fromJson(Map<String, dynamic> json) {
        code = json['code'];
        if (json['data'] != null) {
        data = new List<CouponsDataApiModel>();
        json['data'].forEach((v) {
            data.add(new CouponsDataApiModel.fromJson(v));
        });
        }
        msg = json['msg'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        data['msg'] = this.msg;
        return data;
    }
}

class CouponsDataApiModel{
    int couponId;
    String coverImage;
    String createTime;
    String endDate;
    int firmId;
    String name;
    String startDate;
    String status;
    String title;
    int total;
    int validityDay;
    String worth;

    CouponsDataApiModel(
        {this.couponId,
        this.coverImage,
        this.createTime,
        this.endDate,
        this.firmId,
        this.name,
        this.startDate,
        this.status,
        this.title,
        this.total,
        this.validityDay,
        this.worth});

    CouponsDataApiModel.fromJson(Map<String, dynamic> json) {
        couponId = json['couponId'];
        coverImage = json['coverImage'];
        createTime = json['createTime'];
        endDate = json['endDate'];
        firmId = json['firmId'];
        name = json['name'];
        startDate = json['startDate'];
        status = json['status'];
        title = json['title'];
        total = json['total'];
        validityDay = json['validityDay'];
        worth = json['worth'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['couponId'] = this.couponId;
        data['coverImage'] = this.coverImage;
        data['createTime'] = this.createTime;
        data['endDate'] = this.endDate;
        data['firmId'] = this.firmId;
        data['name'] = this.name;
        data['startDate'] = this.startDate;
        data['status'] = this.status;
        data['title'] = this.title;
        data['total'] = this.total;
        data['validityDay'] = this.validityDay;
        data['worth'] = this.worth;
        return data;
    }
}