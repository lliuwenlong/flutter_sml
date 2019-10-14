import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
class NewsPage extends StatefulWidget {
    NewsPage({Key key}) : super(key: key);
    _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
    Widget _listItem (String url, String name, String routerName, {isBorder = true}) {
        return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, routerName,arguments: {
              "appTabName":name
            });
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: ScreenAdaper.height(30),bottom: ScreenAdaper.height(30)),
            decoration: BoxDecoration(
                border: isBorder ? Border(bottom: BorderSide(
                    color: Color(0XFFd9d9d9),
                    width: ScreenAdaper.height(1)
                )) : null
            ),
           
            child: Row(
                children: <Widget>[
                    Container(
                        width: ScreenAdaper.width(60),
                        height: ScreenAdaper.width(60),
                        child: Image.asset(
                            url,
                            fit: BoxFit.cover,
                        )
                    ),
                    SizedBox(width: ScreenAdaper.width(40)),
                    Text(name, style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: ScreenAdaper.fontSize(28)
                    )),
                    Expanded(
                        child: Stack(
                            children: <Widget>[
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                        IconData(0xe61e, fontFamily: 'iconfont'),
                                        color: Color.fromRGBO(170,170,170, 1),
                                        size: ScreenAdaper.fontSize(24),
                                    )
                                )
                            ],
                        ),
                    )
                ],
            )
        ),
        );
    }

    @override
    Widget build(BuildContext context) {
      ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar('消息'),
            body: Container(
              color: Colors.white,
                child: Container(
                    padding: EdgeInsets.fromLTRB(
                        ScreenAdaper.width(30), 0, ScreenAdaper.width(30),0
                    ),
                    child: Column(
                        children: <Widget>[
                            this._listItem(
                                "images/tongzhi.png", "系统通知",'/systemMessage'
                            ),
                            this._listItem(
                                "images/gonggao.png", "活动公告",'/activityMessage'
                            ),
                            this._listItem(
                                "images/xiaoxi.png", "其他消息", '/otherMessage',isBorder: false
                            )
                        ]
                    ),
                ),
            )
        );
    }
}