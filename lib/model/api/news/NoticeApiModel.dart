class NoticeApiModel {
    List<NoticeDataApiModel> data;
    List<NoticeDataApiModel> list;
    NoticeApiModel({this.data});

    NoticeApiModel.fromJson(Map<String, dynamic> json) {
        if (json['data'] != null) {
            data = new List<NoticeDataApiModel>();
            json['data'].forEach((v) {
                data.add(new NoticeDataApiModel.fromJson(v));
            });
        }
        if (json['list'] != null) {
            data = new List<NoticeDataApiModel>();
            json['list'].forEach((v) {
                data.add(new NoticeDataApiModel.fromJson(v));
            });
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class NoticeDataApiModel{
    int noticeId;
    String noticeTitle;
    String coverImage;
    String noticeDesc;
    String createTime;
    String noticeStatus;
    String noticeType;
    String noticeContent;

    NoticeDataApiModel(
        {this.noticeId,
        this.noticeTitle,
        this.coverImage,
        this.noticeDesc,
        this.createTime,
        this.noticeStatus,
        this.noticeType,
        this.noticeContent});

    NoticeDataApiModel.fromJson(Map<String, dynamic> json) {
        noticeId = json['noticeId'];
        noticeTitle = json['noticeTitle'];
        coverImage = json['coverImage'];
        noticeDesc = json['noticeDesc'];
        createTime = json['createTime'];
        noticeStatus = json['noticeStatus'];
        noticeType = json['noticeType'];
        noticeContent = json['noticeContent'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['noticeId'] = this.noticeId;
        data['noticeTitle'] = this.noticeTitle;
        data['coverImage'] = this.coverImage;
        data['noticeDesc'] = this.noticeDesc;
        data['createTime'] = this.createTime;
        data['noticeStatus'] = this.noticeStatus;
        data['noticeType'] = this.noticeType;
        data['noticeContent'] = this.noticeContent;
        return data;
    }
}