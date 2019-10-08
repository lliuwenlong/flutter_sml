class FoodFirmApiModel {
    int firmId;
    String name;
    String province;
    String city;
    String county;
    String address;
    String telphone;
    String typeName;
    String openTime;
    String closeTime;
    List goods;
    List attachs;
    List goodsAttaches;

    FoodFirmApiModel(
        {this.firmId,
        this.name,
        this.province,
        this.city,
        this.county,
        this.address,
        this.telphone,
        this.typeName,
        this.openTime,
        this.closeTime,
        this.goods,
        this.attachs,
        this.goodsAttaches});

    FoodFirmApiModel.fromJson(Map<String, dynamic> json) {
        firmId = json['firmId'];
        name = json['name'];
        province = json['province'];
        city = json['city'];
        county = json['county'];
        address = json['address'];
        telphone = json['telphone'];
        typeName = json['typeName'];
        openTime = json['openTime'];
        closeTime = json['closeTime'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['firmId'] = this.firmId;
        data['name'] = this.name;
        data['province'] = this.province;
        data['city'] = this.city;
        data['county'] = this.county;
        data['address'] = this.address;
        data['telphone'] = this.telphone;
        data['typeName'] = this.typeName;
        data['openTime'] = this.openTime;
        data['closeTime'] = this.closeTime;
        return data;
    }
}