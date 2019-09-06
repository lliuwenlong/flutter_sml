class BannerModel {
    int code;
    List<Data> data;

    BannerModel({this.code, this.data});

    BannerModel.fromJson(Map<String, dynamic> json) {
        code = json['code'];
        if (json['data'] != null) {
            data = new List<Data>();
            json['data'].forEach((v) {
                data.add(new Data.fromJson(v));
            });
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Data {
    int bannerId;
    String bannerTitle;
    String imageUrl;
    String bannerStatus;
    String createTime;
    String redirectUrl;
    String bannerType;
    String startDate;
    String endDate;

    Data(
        {this.bannerId,
        this.bannerTitle,
        this.imageUrl,
        this.bannerStatus,
        this.createTime,
        this.redirectUrl,
        this.bannerType,
        this.startDate,
        this.endDate});

    Data.fromJson(Map<String, dynamic> json) {
        bannerId = json['bannerId'];
        bannerTitle = json['bannerTitle'];
        imageUrl = json['imageUrl'];
        bannerStatus = json['bannerStatus'];
        createTime = json['createTime'];
        redirectUrl = json['redirectUrl'];
        bannerType = json['bannerType'];
        startDate = json['startDate'];
        endDate = json['endDate'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['bannerId'] = this.bannerId;
        data['bannerTitle'] = this.bannerTitle;
        data['imageUrl'] = this.imageUrl;
        data['bannerStatus'] = this.bannerStatus;
        data['createTime'] = this.createTime;
        data['redirectUrl'] = this.redirectUrl;
        data['bannerType'] = this.bannerType;
        data['startDate'] = this.startDate;
        data['endDate'] = this.endDate;
        return data;
    }
}