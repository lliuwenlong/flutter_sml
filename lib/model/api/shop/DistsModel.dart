class DistsModel {
    int code;
    String msg;
    List<Data> data;

    DistsModel({this.code, this.msg, this.data});

    DistsModel.fromJson(Map<String, dynamic> json) {
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
    int districtId;
    String districtName;
    int baseId;

    Data({this.districtId, this.districtName, this.baseId});

    Data.fromJson(Map<String, dynamic> json) {
        districtId = json['districtId'];
        districtName = json['districtName'];
        baseId = json['baseId'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['districtId'] = this.districtId;
        data['districtName'] = this.districtName;
        data['baseId'] = this.baseId;
        return data;
    }
}