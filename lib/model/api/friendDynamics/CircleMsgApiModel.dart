class CircleMsgApiModel {
    int code;
    List<Data> data;
    String msg;

    CircleMsgApiModel({this.code, this.data, this.msg});

    CircleMsgApiModel.fromJson(Map<String, dynamic> json) {
        code = json['code'];
        if (json['data'] != null) {
        data = new List<Data>();
            json['data'].forEach((v) {
                data.add(new Data.fromJson(v));
            });
        }
        msg = json['msg'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        data['msg'] = this.msg;
        return data;
    }
}

class Data {
    int comment;
    String content;
    String createTime;
    String headerImage;
    String imageUrl;
    List<String> imageUrls;
    int messageId;
    String nickName;
    int share;
    int thumbup;
    int isThumbup;
    int userId;

    Data(
        {this.comment,
        this.content,
        this.createTime,
        this.headerImage,
        this.imageUrl,
        this.imageUrls,
        this.messageId,
        this.nickName,
        this.share,
        this.thumbup,
        this.isThumbup,
        this.userId});

    Data.fromJson(Map<String, dynamic> json) {
        comment = json['comment'];
        content = json['content'];
        createTime = json['createTime'];
        headerImage = json['headerImage'];
        imageUrl = json['imageUrl'];
        if (json['imageUrls'] != null) {
            imageUrls = json['imageUrls'].cast<String>();
        } else {
            imageUrls = [];
        }
        messageId = json['messageId'];
        nickName = json['nickName'];
        share = json['share'];
        thumbup = json['thumbup'];
        isThumbup = json['isThumbup'];
        userId = json['userId'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['comment'] = this.comment;
        data['content'] = this.content;
        data['createTime'] = this.createTime;
        data['headerImage'] = this.headerImage;
        data['imageUrl'] = this.imageUrl;
        data['imageUrls'] = this.imageUrls;
        data['messageId'] = this.messageId;
        data['nickName'] = this.nickName;
        data['share'] = this.share;
        data['thumbup'] = this.thumbup;
        data['isThumbup'] = this.isThumbup;
        data['userId'] = this.userId;
        return data;
    }
}
