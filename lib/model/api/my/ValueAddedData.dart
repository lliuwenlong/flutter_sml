class ValueAddedDataModel {
  int code;
  List<Data> data;
  String msg;

  ValueAddedDataModel({this.code, this.data, this.msg});

  ValueAddedDataModel.fromJson(Map<String, dynamic> json) {
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
  String cover;
  String name;
  int productId;

  Data({this.cover, this.name, this.productId});

  Data.fromJson(Map<String, dynamic> json) {
    cover = json['cover'];
    name = json['name'];
    productId = json['productId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cover'] = this.cover;
    data['name'] = this.name;
    data['productId'] = this.productId;
    return data;
  }
}
