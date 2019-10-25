class FoodModel {
    int code;
    Data data;
    String msg;

    FoodModel({this.code, this.data, this.msg});

    FoodModel.fromJson(Map<String, dynamic> json) {
        code = json['code'];
        data = json['data'] != null ? new Data.fromJson(json['data']) : null;
        msg = json['msg'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        data['msg'] = this.msg;
        return data;
    }
}

class Data {
  int currPage;
  List<ListModel> list;
  int pageSize;
  int totalCount;
  int totalPage;

    Data(
        {this.currPage,
        this.list,
        this.pageSize,
        this.totalCount,
        this.totalPage});

    Data.fromJson(Map<String, dynamic> json) {
        currPage = json['currPage'];
        if (json['list'] != null) {
        list = new List<ListModel>();
            json['list'].forEach((v) {
                list.add(new ListModel.fromJson(v));
            });
        }
        pageSize = json['pageSize'];
        totalCount = json['totalCount'];
        totalPage = json['totalPage'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['currPage'] = this.currPage;
        if (this.list != null) {
            data['list'] = this.list.map((v) => v.toJson()).toList();
        }
        data['pageSize'] = this.pageSize;
        data['totalCount'] = this.totalCount;
        data['totalPage'] = this.totalPage;
        return data;
    }
}

class ListModel {
    String account;
    String accountBank;
    String accountName;
    String accountPhone;
    String address;
    String applyStatus;
    String cardNo;
    String city;
    String closeTime;
    String county;
    String createTime;
    int firmId;
    String idcardBack;
    String idcardFront;
    String idcardHuman;
    String logo;
    String mainGoods;
    String name;
    String officerName;
    String officerPhone;
    String openTime;
    String perPrice;
    String province;
    String status;
    String telphone;
    String type;
    String longitude;
    String latitude;
    double distance;
    String coupons;
    String tags;
    ListModel(
        {this.account,
        this.accountBank,
        this.accountName,
        this.accountPhone,
        this.address,
        this.applyStatus,
        this.cardNo,
        this.city,
        this.closeTime,
        this.county,
        this.createTime,
        this.firmId,
        this.idcardBack,
        this.idcardFront,
        this.idcardHuman,
        this.logo,
        this.mainGoods,
        this.name,
        this.officerName,
        this.officerPhone,
        this.openTime,
        this.perPrice,
        this.province,
        this.status,
        this.telphone,
        this.type,
        this.longitude,
        this.latitude,
        this.distance,
        this.coupons,
        this.tags});

    ListModel.fromJson(Map<String, dynamic> json) {
        account = json['account'];
        accountBank = json['accountBank'];
        accountName = json['accountName'];
        accountPhone = json['accountPhone'];
        address = json['address'];
        applyStatus = json['applyStatus'];
        cardNo = json['cardNo'];
        city = json['city'];
        closeTime = json['closeTime'];
        county = json['county'];
        createTime = json['createTime'];
        firmId = json['firmId'];
        idcardBack = json['idcardBack'];
        idcardFront = json['idcardFront'];
        idcardHuman = json['idcardHuman'];
        logo = json['logo'];
        mainGoods = json['mainGoods'];
        name = json['name'];
        officerName = json['officerName'];
        officerPhone = json['officerPhone'];
        openTime = json['openTime'];
        perPrice = json['perPrice'];
        province = json['province'];
        status = json['status'];
        telphone = json['telphone'];
        type = json['type'];
        longitude = json['longitude'];
        latitude = json['latitude'];
        distance = json['distance'];
        coupons = json['coupons'];
        tags = json['tags'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['account'] = this.account;
        data['accountBank'] = this.accountBank;
        data['accountName'] = this.accountName;
        data['accountPhone'] = this.accountPhone;
        data['address'] = this.address;
        data['applyStatus'] = this.applyStatus;
        data['cardNo'] = this.cardNo;
        data['city'] = this.city;
        data['closeTime'] = this.closeTime;
        data['county'] = this.county;
        data['createTime'] = this.createTime;
        data['firmId'] = this.firmId;
        data['idcardBack'] = this.idcardBack;
        data['idcardFront'] = this.idcardFront;
        data['idcardHuman'] = this.idcardHuman;
        data['logo'] = this.logo;
        data['mainGoods'] = this.mainGoods;
        data['name'] = this.name;
        data['officerName'] = this.officerName;
        data['officerPhone'] = this.officerPhone;
        data['openTime'] = this.openTime;
        data['perPrice'] = this.perPrice;
        data['province'] = this.province;
        data['status'] = this.status;
        data['telphone'] = this.telphone;
        data['type'] = this.type;
        data['longitude'] = this.longitude;
        data['latitude'] = this.latitude;
        data['distance'] = this.distance;
        data['coupons'] = this.coupons;
        data['tags'] = this.tags;
        return data;
    }
}