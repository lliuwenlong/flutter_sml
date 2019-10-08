import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../model/api/restaurant/AppraiseList.dart';

class Evaluate extends StatelessWidget {
    ListItem listItem;
    bool isBorder;
    Evaluate({Key key, ListItem val, this.isBorder = true}) {
        this.listItem = val;
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            padding: EdgeInsets.all(ScreenAdaper.width(30)),
            decoration: BoxDecoration(
                border: Border(
                    bottom: isBorder ? BorderSide(
                        color: Color(0XFFd9d9d9),
                        width: 1
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
                                "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws"
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
                                        Text("张丽", style: TextStyle(
                                            color: ColorClass.common,
                                            fontSize: ScreenAdaper.fontSize(30)
                                        )),
                                        Text("7月31日", style: TextStyle(
                                            color: ColorClass.subTitleColor,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        ))
                                    ]
                                ),
                                SizedBox(height: ScreenAdaper.height(10)),
                                Text("今天来吃串串，周边景色特别，锅底味道特别香，串串很好吃下次还会再来的！", style: TextStyle(
                                    color: ColorClass.titleColor,
                                    fontSize: ScreenAdaper.fontSize(28)
                                )),
                                SizedBox(height: ScreenAdaper.height(20)),
                                Wrap(
                                    spacing: ScreenAdaper.width(10),
                                    runSpacing: ScreenAdaper.height(10),
                                    children: <Widget>[
                                        Container(
                                            width: ScreenAdaper.width(165),
                                            height: ScreenAdaper.width(165),
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                                child: Image.network(
                                                    "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                                                    fit: BoxFit.cover,
                                                )
                                            ),
                                        )
                                    ]
                                )
                            ]
                        ),
                    )
                ]
            ),
        );
    }
}