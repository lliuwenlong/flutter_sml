class ContactCustomerServiceDataModel {
  int code;
  Data data;
  String msg;

  ContactCustomerServiceDataModel({this.code, this.data, this.msg});

  ContactCustomerServiceDataModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['msg'] = this.msg;
    return data;
  }
}

class Data {
  String address;
  String hotline;
  String website;

  Data({this.address, this.hotline, this.website});

  Data.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    hotline = json['hotline'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['hotline'] = this.hotline;
    data['website'] = this.website;
    return data;
  }
}
