class InvoiceHistoryDataModel {
  int code;
  Data data;
  String msg;

  InvoiceHistoryDataModel({this.code, this.data, this.msg});

  InvoiceHistoryDataModel.fromJson(Map<String, dynamic> json) {
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
  String content;
  String createTime;
  String receiptId;
  String status;

  ListItem(
      {this.amount,
      this.content,
      this.createTime,
      this.receiptId,
      this.status});

  ListItem.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    content = json['content'];
    createTime = json['createTime'];
    receiptId = json['receiptId'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['content'] = this.content;
    data['createTime'] = this.createTime;
    data['receiptId'] = this.receiptId;
    data['status'] = this.status;
    return data;
  }
}
