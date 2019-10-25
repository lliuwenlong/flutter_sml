class ShopApiModel {
    int code;
    List<Data> data;
    String msg;

    ShopApiModel({this.code, this.data, this.msg});

    ShopApiModel.fromJson(Map<String, dynamic> json) {
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
    String baseName;
    String image;
    String name;
    int woodId;
    int baseId;
    String price;

    Data({this.baseName, this.image, this.name, this.woodId,this.baseId, this.price});

    Data.fromJson(Map<String, dynamic> json) {
        baseName = json['baseName'];
        image = json['image'];
        name = json['name'];
        woodId = json['woodId'];
        baseId = json['baseId'];
        price = json['price'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['baseName'] = this.baseName;
        data['image'] = this.image;
        data['name'] = this.name;
        data['woodId'] = this.woodId;
        data['baseId'] = this.baseId;
        data['price'] = this.price;
        return data;
    }
}
