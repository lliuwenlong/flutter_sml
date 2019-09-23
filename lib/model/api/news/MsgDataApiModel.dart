class MsgDataApiModel {
    int code;
    MsgDataApiData data;
    String msg;

    MsgDataApiModel({this.code, this.data, this.msg});

    MsgDataApiModel.fromJson(Map<String, dynamic> json) {
        code = json['code'];
        data = json['data'] != null ? new MsgDataApiData.fromJson(json['data']) : null;
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

class MsgDataApiData {
    int currPage;
    List<MsgDataApiDataList> list;
    int pageSize;
    int totalCount;
    int totalPage;

    MsgDataApiData(
        {this.currPage,
        this.list,
        this.pageSize,
        this.totalCount,
        this.totalPage});

    MsgDataApiData.fromJson(Map<String, dynamic> json) {
        currPage = json['currPage'];
        if (json['list'] != null) {
        list = new List<MsgDataApiDataList>();
        json['list'].forEach((v) {
            list.add(new MsgDataApiDataList.fromJson(v));
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

class MsgDataApiDataList {
    String content;
    String createTime;

    MsgDataApiDataList({this.content, this.createTime});

    MsgDataApiDataList.fromJson(Map<String, dynamic> json) {
        content = json['content'];
        createTime = json['createTime'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['content'] = this.content;
        data['createTime'] = this.createTime;
        return data;
    }
}