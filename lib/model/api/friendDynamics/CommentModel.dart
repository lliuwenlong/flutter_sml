class CommentModel {
    int total;
    int pageNO;
    List<CommentData> data;
    int pageSize;
    CommentModel({this.total, this.pageNO, this.data, this.pageSize});

    CommentModel.fromJson(Map<String, dynamic> json) {
        total = json['total'];
        pageNO = json['pageNO'];
        if (json['data'] != null) {
            data = new List<CommentData>();
            json['data'].forEach((v) {
                data.add(new CommentData.fromJson(v));
            });
        }
        pageSize = json['pageSize'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['total'] = this.total;
        data['pageNO'] = this.pageNO;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        data['pageSize'] = this.pageSize;
        return data;
    }
}

class CommentData {
    String nickName;
    String content;
    String createTime;

    CommentData({this.nickName, this.content, this.createTime});

    CommentData.fromJson(Map<String, dynamic> json) {
        nickName = json['nickName'];
        content = json['content'];
        createTime = json['createTime'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['nickName'] = this.nickName;
        data['content'] = this.content;
        data['createTime'] = this.createTime;
        return data;
    }
}
