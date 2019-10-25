import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../model/api/restaurant/AppraiseList.dart';

class Evaluate extends StatelessWidget {
    ListItem listItem;
    bool isBorder;
    String content;
    String createTime;
    String nickName;
    String headerImage;
    List<String> imageUrl = [];

    Evaluate(
        String content,
        String createTime,
        String nickName,
        String headerImage,
        String imageUrl,
        {Key key, ListItem val, this.isBorder = true}
    ) {
        this.listItem = val;
        this.content = content;
        this.createTime = createTime;
        this.nickName = nickName;
        this.headerImage = headerImage;
        this.imageUrl = imageUrl != null && (imageUrl is String) ? imageUrl.split(",") : [];
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            padding: EdgeInsets.only(
                left: ScreenAdaper.width(30),
                right: ScreenAdaper.width(30)
            ),
            child: Container(
                padding: EdgeInsets.only(
                    top: ScreenAdaper.width(30),
                    bottom: ScreenAdaper.width(30)
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: isBorder ? BorderSide(
                            color: Color(0XFFd9d9d9),
                            width: 0.5
                        ) : BorderSide.none
                    )
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(85),
                            height: ScreenAdaper.width(85),
                            child: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    this.headerImage != null ? this.headerImage : ""
                                )
                            ),
                        ),
                        SizedBox(width: ScreenAdaper.width(30)),
                        Expanded(
                            flex: 1,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    SizedBox(height: ScreenAdaper.height(10)),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                            Expanded(
                                                child: Text(this.nickName !=null ? this.nickName : "", style: TextStyle(
                                                    color: ColorClass.common,
                                                    fontSize: ScreenAdaper.fontSize(30),
                                                ), overflow: TextOverflow.ellipsis),
                                            ),
                                            SizedBox(width: 20),
                                            Text(this.createTime, style: TextStyle(
                                                color: ColorClass.subTitleColor,
                                                fontSize: ScreenAdaper.fontSize(24)
                                            ))
                                        ]
                                    ),
                                    SizedBox(height: ScreenAdaper.height(10)),
                                    Text(this.content, style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(28)
                                    )),
                                    SizedBox(height: ScreenAdaper.height(20)),
                                    this.imageUrl.length != 0
                                    ? GridView.builder(
                                        shrinkWrap: true, //解决无限高度问题
                                        physics:NeverScrollableScrollPhysics(),//禁用滑动事件
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: 1,
                                            mainAxisSpacing: ScreenAdaper.width(20),
                                            crossAxisSpacing: ScreenAdaper.width(20),
                                        ),
                                        itemBuilder: (BuildContext context, int index) {
                                            return Container(
                                                width: ScreenAdaper.width(165),
                                                height: ScreenAdaper.width(165),
                                                child: ClipRRect(
                                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                                    child: Image.network(
                                                        this.imageUrl[index],
                                                        fit: BoxFit.cover,
                                                    )
                                                ),
                                            );
                                        },
                                        itemCount: this.imageUrl.length,
                                    )
                                    : SizedBox(height: 0)
                                ]
                            ),
                        )
                    ]
                ),
            ),
        );
    }
}