class OrderDataModel {
  int code;
  Data data;
  String msg;

  OrderDataModel({this.code, this.data, this.msg});

  OrderDataModel.fromJson(Map<String, dynamic> json) {
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
  int currPage;
  List<ListItem> list;
  int pageSize;
  int totalCount;
  int totalPage;

  Data(
      {this.currPage,
      this.list,
      this.pageSize,
      this.totalCount,
      this.totalPage});

  Data.fromJson(Map<String, dynamic> json) {
    currPage = json['currPage'];
    if (json['list'] != null) {
      list = new List<ListItem>();
      json['list'].forEach((v) {
        list.add(new ListItem.fromJson(v));
      });
    }
    pageSize = json['pageSize'];
    totalCount = json['totalCount'];
    totalPage = json['totalPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currPage'] = this.currPage;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['pageSize'] = this.pageSize;
    data['totalCount'] = this.totalCount;
    data['totalPage'] = this.totalPage;
    return data;
  }
}

class ListItem {
  String amount;
  String createTime;
  int firmId;
  String logo;
  String name;
  String orderSn;
  String status;
  String statusName;
  String type;

  ListItem(
      {this.amount,
      this.createTime,
      this.firmId,
      this.logo,
      this.name,
      this.orderSn,
      this.status,
      this.statusName,
      this.type});

  ListItem.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createTime = json['createTime'];
    firmId = json['firmId'];
    logo = json['logo'];
    name = json['name'];
    orderSn = json['orderSn'];
    status = json['status'];
    statusName = json['statusName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['createTime'] = this.createTime;
    data['firmId'] = this.firmId;
    data['logo'] = this.logo;
    data['name'] = this.name;
    data['orderSn'] = this.orderSn;
    data['status'] = this.status;
    data['statusName'] = this.statusName;
    data['type'] = this.type;
    return data;
  }
}
