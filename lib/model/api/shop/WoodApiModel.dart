class WoodApiModel {
    int code;
    String msg;
    Data data;

    WoodApiModel({this.code, this.msg, this.data});

    WoodApiModel.fromJson(Map<String, dynamic> json) {
        code = json['code'];
        msg = json['msg'];
        data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['msg'] = this.msg;
        if (this.data != null) {
            data['data'] = this.data.toJson();
        }
        return data;
    }
}

class Data {
    int woodId;
    int baseId;
    int districtId;
    String name;
    String image;
    String price;
    String treeLife;
    String cricle;
    String height;
    int branch;
    String description;
    String content;

    Data(
        {this.woodId,
        this.baseId,
        this.districtId,
        this.name,
        this.image,
        this.price,
        this.treeLife,
        this.cricle,
        this.height,
        this.branch,
        this.description,
        this.content});

    Data.fromJson(Map<String, dynamic> json) {
        woodId = json['woodId'];
        baseId = json['baseId'];
        districtId = json['districtId'];
        name = json['name'];
        image = json['image'];
        price = json['price'];
        treeLife = json['treeLife'];
        cricle = json['cricle'];
        height = json['height'];
        branch = json['branch'];
        description = json['description'];
        content = json['content'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['woodId'] = this.woodId;
        data['baseId'] = this.baseId;
        data['districtId'] = this.districtId;
        data['name'] = this.name;
        data['image'] = this.image;
        data['price'] = this.price;
        data['treeLife'] = this.treeLife;
        data['cricle'] = this.cricle;
        data['height'] = this.height;
        data['branch'] = this.branch;
        data['description'] = this.description;
        data['content'] = this.content;
        return data;
    }
}
