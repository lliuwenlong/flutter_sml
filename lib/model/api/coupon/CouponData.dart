class CouponDataModel {
    int code;
    Data data;
    String msg;

    CouponDataModel({this.code, this.data, this.msg});

    CouponDataModel.fromJson(Map<String, dynamic> json) {
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
    String couponSn;
    String coverImage;
    String endDate;
    int firmId;
    int id;
    String name;
    String title;
    String type;
    String worth;
    int times;
    ListItem(
        {this.couponSn,
        this.coverImage,
        this.endDate,
        this.firmId,
        this.id,
        this.name,
        this.title,
        this.type,
        this.worth,
        this.times});

  ListItem.fromJson(Map<String, dynamic> json) {
        couponSn = json['couponSn'];
        coverImage = json['coverImage'];
        endDate = json['endDate'];
        firmId = json['firmId'];
        id = json['id'];
        name = json['name'];
        title = json['title'];
        type = json['type'];
        worth = json['worth'];
        times = json['times'];
  }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['couponSn'] = this.couponSn;
        data['coverImage'] = this.coverImage;
        data['endDate'] = this.endDate;
        data['firmId'] = this.firmId;
        data['id'] = this.id;
        data['name'] = this.name;
        data['title'] = this.title;
        data['type'] = this.type;
        data['worth'] = this.worth;
        data['times'] = this.times;
        return data;
    }
}
