import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../model/api/news/NoticeApiModel.dart';
class ListItem extends StatelessWidget {
    final String title;
    final String subtitle;
    final String time;
    final routerName;
    final appTabName;
    final NoticeDataApiModel data;
    const ListItem(this.title, this.time, this.routerName, this.appTabName,
        {this.subtitle = '', Key key, this.data})
        : super(key: key);

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
        child: GestureDetector(
        onTap: () {
            if (appTabName != '其他消息') {
                Navigator.pushNamed(context, routerName,
                    arguments: {
                        "appTabName": appTabName,
                        "id": data.noticeId
                    });
            }
        },
        child: Container(
            margin: EdgeInsets.only(bottom: ScreenAdaper.height(20)),
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(ScreenAdaper.width(10)))),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: ScreenAdaper.width(30),
                            right: ScreenAdaper.width(30),
                            top: ScreenAdaper.height(30)),
                        child: Text(
                            title,
                            style: TextStyle(
                                color: Color(0xff333333),
                                fontSize: ScreenAdaper.fontSize(30),
                                fontFamily: 'SourceHanSansCN-Medium',
                                fontWeight: FontWeight.w500),
                        )
                    ),
                    SizedBox(
                        height: subtitle.isEmpty
                            ? ScreenAdaper.height(0)
                            : ScreenAdaper.height(10),
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: ScreenAdaper.width(30),
                            right: ScreenAdaper.width(30)),
                        child: Text(
                            subtitle,
                            style: TextStyle(
                            color: Color(0xff666666),
                            fontSize: ScreenAdaper.fontSize(26),
                            height: 1.2,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                        ),
                    ),
                    SizedBox(
                        height: subtitle.isEmpty
                            ? ScreenAdaper.height(0)
                            : ScreenAdaper.height(25),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            left: ScreenAdaper.width(30),
                            right: ScreenAdaper.width(30),
                            bottom: ScreenAdaper.height(30)),
                        width: double.infinity,
                        child: Text(
                            time,
                            style: TextStyle(
                            color: Color(0xff999999),
                            fontSize: ScreenAdaper.fontSize(24),
                            ),
                        ),
                    ),
                ],
            )),
        ),
        ));
    }
}
