class FriendListApiModel {
    int code;
    FriendDataModel data;
    String msg;

    FriendListApiModel({this.code, this.data, this.msg});

    FriendListApiModel.fromJson(Map<String, dynamic> json) {
        code = json['code'];
        data = json['data'] != null ? new FriendDataModel.fromJson(json['data']) : null;
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

class FriendDataModel {
    int currPage;
    List<FriendDataListModel> list;
    int pageSize;
    int totalCount;
    int totalPage;

    FriendDataModel(
        {this.currPage,
        this.list,
        this.pageSize,
        this.totalCount,
        this.totalPage});

    FriendDataModel.fromJson(Map<String, dynamic> json) {
        currPage = json['currPage'];
        if (json['list'] != null) {
        list = new List<FriendDataListModel>();
        json['list'].forEach((v) {
            list.add(new FriendDataListModel.fromJson(v));
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

class FriendDataListModel {
    String nickName;
    int subId;
    String headerImage;
    String focus;
    FriendDataListModel({this.nickName, this.subId, this.headerImage});

    FriendDataListModel.fromJson(Map<String, dynamic> json) {
        nickName = json['nickName'];
        subId = json['subId'];
        headerImage = json['headerImage'];
        focus = json['focus'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['nickName'] = this.nickName;
        data['subId'] = this.subId;
        data['headerImage'] = this.headerImage;
        data['focus'] = this.focus;
        return data;
    }
}