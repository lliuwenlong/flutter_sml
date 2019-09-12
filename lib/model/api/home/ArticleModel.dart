class ArticleModel {
    int code;
    String msg;
    List<Data> data;

    ArticleModel({this.code, this.msg, this.data});

    ArticleModel.fromJson(Map<String, dynamic> json) {
        code = json['code'];
        msg = json['msg'];
        if (json['data'] != null) {
            data = new List<Data>();
            json['data'].forEach((v) {
                data.add(new Data.fromJson(v));
            });
        }
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['code'] = this.code;
        data['msg'] = this.msg;
        if (this.data != null) {
            data['data'] = this.data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class Data {
    int articleId;
    String articleTitle;
    String coverImage;
    String articleSummary;
    String createTime;
    String articleType;
    String articleContent;

    Data(
        {this.articleId,
        this.articleTitle,
        this.coverImage,
        this.articleSummary,
        this.createTime,
        this.articleType,
        this.articleContent});

    Data.fromJson(Map<String, dynamic> json) {
        articleId = json['articleId'];
        articleTitle = json['articleTitle'];
        coverImage = json['coverImage'];
        articleSummary = json['articleSummary'];
        createTime = json['createTime'];
        articleType = json['articleType'];
        articleContent = json['articleContent'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['articleId'] = this.articleId;
        data['articleTitle'] = this.articleTitle;
        data['coverImage'] = this.coverImage;
        data['articleSummary'] = this.articleSummary;
        data['createTime'] = this.createTime;
        data['articleType'] = this.articleType;
        data['articleContent'] = this.articleContent;
        return data;
    }
}