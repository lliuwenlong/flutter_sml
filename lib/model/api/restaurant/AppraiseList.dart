class AppraiseListModel {
    int code;
    Data data;
    String msg;

    AppraiseListModel({this.code, this.data, this.msg});

    AppraiseListModel.fromJson(Map<String, dynamic> json) {
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
    String content;
    String createTime;
    String headerImage;
    String imageUrl;
    String nickName;

    ListItem(
        {this.content,
        this.createTime,
        this.headerImage,
        this.imageUrl,
        this.nickName});

    ListItem.fromJson(Map<String, dynamic> json) {
        content = json['content'];
        createTime = json['createTime'];
        headerImage = json['headerImage'];
        imageUrl = json['imageUrl'];
        nickName = json['nickName'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['content'] = this.content;
        data['createTime'] = this.createTime;
        data['headerImage'] = this.headerImage;
        data['imageUrl'] = this.imageUrl;
        data['nickName'] = this.nickName;
        return data;
    }
}