class AppraiseDataModelApi {
    int code;
    AppraiseDataModelData data;
    String msg;

    AppraiseDataModelApi({this.code, this.data, this.msg});

    AppraiseDataModelApi.fromJson(Map<String, dynamic> json) {
        code = json['code'];
        data = json['data'] != null ? new AppraiseDataModelData.fromJson(json['data']) : null;
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

class AppraiseDataModelData {
    int currPage;
    List<AppraiseDataModelList> list;
    int pageSize;
    int totalCount;
    int totalPage;

    AppraiseDataModelData(
        {this.currPage,
        this.list,
        this.pageSize,
        this.totalCount,
        this.totalPage});

    AppraiseDataModelData.fromJson(Map<String, dynamic> json) {
        currPage = json['currPage'];
        if (json['list'] != null) {
            list = new List<AppraiseDataModelList>();
            json['list'].forEach((v) {
                list.add(new AppraiseDataModelList.fromJson(v));
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

class AppraiseDataModelList {
    String content;
    String createTime;
    String headerImage;
    String imageUrl;
    String nickName;

    AppraiseDataModelList(
        {this.content,
        this.createTime,
        this.headerImage,
        this.imageUrl,
        this.nickName});

    AppraiseDataModelList.fromJson(Map<String, dynamic> json) {
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