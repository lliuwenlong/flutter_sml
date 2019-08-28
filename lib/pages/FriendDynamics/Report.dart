import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import 'dart:ui';
class FriendDynamicsReport extends StatefulWidget {
    FriendDynamicsReport({Key key}) : super(key: key);
    _FriendDynamicsReportState createState() => _FriendDynamicsReportState();
}

class _FriendDynamicsReportState extends State<FriendDynamicsReport> {
    int _listIndex = -1;
    List<Map> _list = [
        {"id": 1, "name": "淫秽色情"},
        {"id": 2, "name": "不实信息"},
        {"id": 3, "name": "违法犯罪"},
        {"id": 4, "name": "骚扰"},
        {"id": 5, "name": "侵权（冒充他人、侵犯名誉"},
        {"id": 6, "name": "其他"}
    ];

    Widget _item (String name, int index, {bool isBorder = true}) {
        return Container(
            padding: EdgeInsets.only(
                top: ScreenAdaper.height(30),
                bottom: ScreenAdaper.height(30)
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: isBorder ? BorderSide(
                        color: ColorClass.borderColor,
                        width: ScreenAdaper.width(2)
                    ) : BorderSide.none
                )
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Text(name, style: TextStyle(
                        color: ColorClass.titleColor,
                        fontSize: ScreenAdaper.fontSize(28)
                    )),
                    Offstage(
                        offstage: !(this._listIndex == index),
                        child: Icon(
                            IconData(0xe643, fontFamily: "iconfont"),
                            size: ScreenAdaper.fontSize(28),
                            color: ColorClass.common
                        )
                    )
                ]
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("举报"),
            backgroundColor: Colors.white,
            bottomSheet: Container(
                width: double.infinity,
                height: ScreenAdaper.height(88) + MediaQueryData.fromWindow(window).padding.bottom,
                padding: EdgeInsets.only(
                    bottom: MediaQueryData.fromWindow(window).padding.bottom + ScreenAdaper.height(10),
                    top: ScreenAdaper.height(10),
                    left: ScreenAdaper.width(30),
                    right: ScreenAdaper.width(30)
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                        BoxShadow(color: Colors.grey[300],offset: Offset(1, 1)),
                        BoxShadow(color: Colors.grey[300], offset: Offset(-1, -1), blurRadius: 2),
                        BoxShadow(color: Colors.grey[300], offset: Offset(1, -1), blurRadius: 2),
                        BoxShadow(color: Colors.grey[300], offset: Offset(-1, 1), blurRadius: 2)
                    ]
                ),
                child: RaisedButton(
                    elevation: 0,
                    onPressed: () {},
                    color: ColorClass.common,
                    child: Text("提交", style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdaper.fontSize(40)
                    ))
                )
            ),
            body: Container(
                padding: EdgeInsets.only(
                    left: ScreenAdaper.width(30),
                    right: ScreenAdaper.width(30),
                    bottom: ScreenAdaper.height(88) + ScreenAdaper.height(20)
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                top: ScreenAdaper.height(30)
                            ),
                            child: Text("请选择举报原因", style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(28),
                                fontWeight: FontWeight.w500
                            ))
                        ),
                        Expanded(
                            child: ListView.builder(
                                itemCount: _list.length,
                                itemBuilder: (BuildContext context, int index) {
                                    return GestureDetector(
                                        onTap: () {
                                            setState(() {
                                                this._listIndex = index;
                                            });
                                        },
                                        child: _item(
                                            this._list[index]['name'],
                                            index,
                                            isBorder: index != _list.length - 1
                                        )
                                    );
                                },
                            )
                        )
                    ],
                ),
            )
        );
    }
}