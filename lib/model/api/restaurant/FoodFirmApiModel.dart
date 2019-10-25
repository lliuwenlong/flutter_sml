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
    String tags;
    List<Goods> goods;
    List<String> attachs;
    List<String> goodsAttaches;
    String longitude;
    String latitude;
    String distance;
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
        this.tags,
        this.goods,
        this.attachs,
        this.goodsAttaches,
        this.longitude,
        this.latitude,
        this.distance});

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
        tags = json['tags'];
        longitude = json['longitude'];
        latitude = json['latitude'];
        distance = json['distance'];
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
        data['tags'] = this.tags;
        data['longitude'] = this.longitude;
        data['latitude'] = this.latitude;
        data['distance'] = this.distance;
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
    String area;
    String room;
    String window;
    String bed;
    String intnet;
    String bathroom;
    String summary;
    String picture;
    String price;
    String content;

    Goods(
        {this.goodsId,
        this.name,
        this.title,
        this.area,
        this.room,
        this.window,
        this.bed,
        this.intnet,
        this.bathroom,
        this.summary,
        this.picture,
        this.price,
        this.content});

    Goods.fromJson(Map<String, dynamic> json) {
        goodsId = json['goodsId'];
        name = json['name'];
        title = json['title'];
        area = json['area'];
        room = json['room'];
        window = json['window'];
        bed = json['bed'];
        intnet = json['intnet'];
        bathroom = json['bathroom'];
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
        data['area'] = this.area;
        data['room'] = this.room;
        data['window'] = this.window;
        data['bed'] = this.bed;
        data['intnet'] = this.intnet;
        data['bathroom'] = this.bathroom;
        data['summary'] = this.summary;
        data['picture'] = this.picture;
        data['price'] = this.price;
        data['content'] = this.content;
        return data;
    }
}