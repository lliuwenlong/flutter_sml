class ValueDataModel {
  int code;
  List<Data> data;
  String msg;

  ValueDataModel({this.code, this.data, this.msg});

  ValueDataModel.fromJson(Map<String, dynamic> json) {
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
  String buyTime;
  String export;
  String grow;
  String name;

  Data({this.buyTime, this.export, this.grow, this.name});

  Data.fromJson(Map<String, dynamic> json) {
    buyTime = json['buyTime'];
    export = json['export'];
    grow = json['grow'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['buyTime'] = this.buyTime;
    data['export'] = this.export;
    data['grow'] = this.grow;
    data['name'] = this.name;
    return data;
  }
}
