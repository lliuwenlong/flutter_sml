class InformationApiModel {
    int userId;
    String nickName;
    String headerImage;
    int focus;
    int fans;
    int messages;

    InformationApiModel(
        {this.userId,
        this.nickName,
        this.headerImage,
        this.focus,
        this.fans,
        this.messages});

    InformationApiModel.fromJson(Map<String, dynamic> json) {
        userId = json['userId'];
        nickName = json['nickName'];
        headerImage = json['headerImage'];
        focus = json['focus'];
        fans = json['fans'];
        messages = json['messages'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['userId'] = this.userId;
        data['nickName'] = this.nickName;
        data['headerImage'] = this.headerImage;
        data['focus'] = this.focus;
        data['fans'] = this.fans;
        data['messages'] = this.messages;
        return data;
    }
}