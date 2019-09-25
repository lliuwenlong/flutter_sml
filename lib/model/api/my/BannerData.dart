class BannerDataModel {
  int code;
  List<Data> data;
  String msg;

  BannerDataModel({this.code, this.data, this.msg});

  BannerDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
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

class Data {
  int bannerId;
  String bannerStatus;
  String bannerTitle;
  String bannerType;
  String createTime;
  String endDate;
  String imageUrl;
  String redirectUrl;
  String startDate;

  Data(
      {this.bannerId,
      this.bannerStatus,
      this.bannerTitle,
      this.bannerType,
      this.createTime,
      this.endDate,
      this.imageUrl,
      this.redirectUrl,
      this.startDate});

  Data.fromJson(Map<String, dynamic> json) {
    bannerId = json['bannerId'];
    bannerStatus = json['bannerStatus'];
    bannerTitle = json['bannerTitle'];
    bannerType = json['bannerType'];
    createTime = json['createTime'];
    endDate = json['endDate'];
    imageUrl = json['imageUrl'];
    redirectUrl = json['redirectUrl'];
    startDate = json['startDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bannerId'] = this.bannerId;
    data['bannerStatus'] = this.bannerStatus;
    data['bannerTitle'] = this.bannerTitle;
    data['bannerType'] = this.bannerType;
    data['createTime'] = this.createTime;
    data['endDate'] = this.endDate;
    data['imageUrl'] = this.imageUrl;
    data['redirectUrl'] = this.redirectUrl;
    data['startDate'] = this.startDate;
    return data;
  }
}
