class InvoiceDataModel {
  int code;
  Data data;
  String msg;

  InvoiceDataModel({this.code, this.data, this.msg});

  InvoiceDataModel.fromJson(Map<String, dynamic> json) {
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
  String name;
  int num;
  String orderSn;
  String status;

  ListItem(
      {this.amount,
      this.createTime,
      this.name,
      this.num,
      this.orderSn,
      this.status});

  ListItem.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    createTime = json['createTime'];
    name = json['name'];
    num = json['num'];
    orderSn = json['orderSn'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['createTime'] = this.createTime;
    data['name'] = this.name;
    data['num'] = this.num;
    data['orderSn'] = this.orderSn;
    data['status'] = this.status;
    return data;
  }
}
