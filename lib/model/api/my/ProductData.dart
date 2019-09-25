class ProductDataModel {
  int code;
  Data data;
  String msg;

  ProductDataModel({this.code, this.data, this.msg});

  ProductDataModel.fromJson(Map<String, dynamic> json) {
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
  String baseName;
  String buyTime;
  String districtName;
  String endDate;
  int hasDays;
  String image;
  String name;
  String woodId;
  String woodSn;

  ListItem(
      {this.baseName,
      this.buyTime,
      this.districtName,
      this.endDate,
      this.hasDays,
      this.image,
      this.name,
      this.woodId,
      this.woodSn});

  ListItem.fromJson(Map<String, dynamic> json) {
    baseName = json['baseName'];
    buyTime = json['buyTime'];
    districtName = json['districtName'];
    endDate = json['endDate'];
    hasDays = json['hasDays'];
    image = json['image'];
    name = json['name'];
    woodId = json['woodId'];
    woodSn = json['woodSn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['baseName'] = this.baseName;
    data['buyTime'] = this.buyTime;
    data['districtName'] = this.districtName;
    data['endDate'] = this.endDate;
    data['hasDays'] = this.hasDays;
    data['image'] = this.image;
    data['name'] = this.name;
    data['woodId'] = this.woodId;
    data['woodSn'] = this.woodSn;
    return data;
  }
}
