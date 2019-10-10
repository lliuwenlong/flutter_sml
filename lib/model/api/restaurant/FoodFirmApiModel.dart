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
    String logo;
    List<Goods> goods;
    List<String> attachs;
    List<String> goodsAttaches;

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
        this.logo,
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
        logo = json['logo'];
        if (json['goods'] != null) {
            goods = new List<Goods>();
            json['goods'].forEach((v) {
                goods.add(new Goods.fromJson(v));
            });
        }
        attachs = json['attachs'].cast<String>();
        goodsAttaches = json['goodsAttaches'].cast<String>();
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
        data['logo'] = this.logo;
        if (this.goods != null) {
            data['goods'] = this.goods.map((v) => v.toJson()).toList();
        }
        data['attachs'] = this.attachs;
        data['goodsAttaches'] = this.goodsAttaches;
        return data;
    }
}

class Goods {
    int goodsId;
    String name;
    String title;
    String summary;
    String picture;
    String price;
    String content;

    Goods(
        {this.goodsId,
        this.name,
        this.title,
        this.summary,
        this.picture,
        this.price,
        this.content});

    Goods.fromJson(Map<String, dynamic> json) {
        goodsId = json['goodsId'];
        name = json['name'];
        title = json['title'];
        summary = json['summary'];
        picture = json['picture'];
        price = json['price'];
        content = json['content'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['goodsId'] = this.goodsId;
        data['name'] = this.name;
        data['title'] = this.title;
        data['summary'] = this.summary;
        data['picture'] = this.picture;
        data['price'] = this.price;
        data['content'] = this.content;
        return data;
    }
}