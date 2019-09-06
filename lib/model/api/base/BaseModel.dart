class BaseModel {
    int code;
    String msg;
    List<Data> data;

    BaseModel({this.code, this.msg, this.data});

    BaseModel.fromJson(Map<String, dynamic> json) {
        code = json['code'];
        msg = json['msg'];
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
        data['msg'] = this.msg;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Data {
    int baseId;
    String baseName;
    String baseImage;
    String createTime;
    String baseContent;

    Data(
        {this.baseId,
        this.baseName,
        this.baseImage,
        this.createTime,
        this.baseContent});

    Data.fromJson(Map<String, dynamic> json) {
        baseId = json['baseId'];
        baseName = json['baseName'];
        baseImage = json['baseImage'];
        createTime = json['createTime'];
        baseContent = json['baseContent'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['baseId'] = this.baseId;
        data['baseName'] = this.baseName;
        data['baseImage'] = this.baseImage;
        data['createTime'] = this.createTime;
        data['baseContent'] = this.baseContent;
        return data;
    }
}