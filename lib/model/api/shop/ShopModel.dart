class ShopModel {
    int code;
    List<Data> data;
    String msg;

    ShopModel({this.code, this.data, this.msg});

    ShopModel.fromJson(Map<String, dynamic> json) {
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
    String price;

    Data({this.baseName, this.image, this.name, this.woodId, this.price});

    Data.fromJson(Map<String, dynamic> json) {
        baseName = json['baseName'];
        image = json['image'];
        name = json['name'];
        woodId = json['woodId'];
        price = json['price'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['baseName'] = this.baseName;
        data['image'] = this.image;
        data['name'] = this.name;
        data['woodId'] = this.woodId;
        data['price'] = this.price;
        return data;
    }
}
