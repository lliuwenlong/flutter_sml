import 'package:flutter/material.dart';
import 'package:flutter_sml/common/Color.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';

import 'dart:ui';
class ReleaseEvaluate extends StatefulWidget {
    ReleaseEvaluate({Key key}) : super(key: key);
    _ReleaseEvaluateState createState() => _ReleaseEvaluateState();
}

class _ReleaseEvaluateState extends State<ReleaseEvaluate> {
    FocusNode _commentFocus = FocusNode();
    @override
    void initState() {
        super.initState();
    }
    Widget _imageUpload () {
        return Container(
            width: ScreenAdaper.width(155),
            height: ScreenAdaper.width(155),
            child: Stack(
                children: <Widget>[
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            width: ScreenAdaper.width(140),
                            height: ScreenAdaper.width(140),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("images/border.png"),
                                    fit: BoxFit.cover
                                )
                            ),
                            child: Icon(
                                IconData(0xe63d, fontFamily: "iconfont"),
                                color: Color(0XFFaaaaaa),
                                size: ScreenAdaper.fontSize(50)
                            ),
                        )
                    )                                       ]
            )
        );
    }
    Widget _imageWidget () {
        return Container(
            width: ScreenAdaper.width(155),
            height: ScreenAdaper.width(155),
            child: Stack(
                children: <Widget>[
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                            width: ScreenAdaper.width(140),
                            height: ScreenAdaper.width(140),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                child: Image.network(
                                    "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                                    fit: BoxFit.cover,
                                )
                            )
                        )
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: Container(
                            alignment: Alignment.topLeft,
                            width: ScreenAdaper.width(30),
                            height: ScreenAdaper.width(30),
                            child: Icon(
                                IconData(0xe61f, fontFamily: "iconfont"),
                                size: ScreenAdaper.fontSize(30),
                                color: Color(0XFFd4746c)
                            )
                        )
                    )                                        ]
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarWidget().buildAppBar("评价"),
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
                padding: EdgeInsets.fromLTRB(
                    ScreenAdaper.width(30),
                    ScreenAdaper.height(20),
                    ScreenAdaper.width(30),
                    ScreenAdaper.height(20)
                ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Row(
                            children: <Widget>[
                                Container(
                                    width: ScreenAdaper.width(100),
                                    height: ScreenAdaper.width(100),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.network(
                                            "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                                            fit: BoxFit.cover,
                                        )
                                    ),
                                ),
                                SizedBox(width: ScreenAdaper.width(30)),
                                Text("神木林咖啡厅", style: TextStyle(
                                    color: Color(0XFF333333),
                                    fontSize: ScreenAdaper.fontSize(34)
                                ))
                            ]
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(20)
                            ),
                            child: TextField(
                                autofocus: true,
                                focusNode: _commentFocus,
                                maxLines: 8,
                                decoration: InputDecoration(
                                    hintText: "亲，麻烦给商家的服务和环境一个真实的评价哦~",
                                    hintStyle: TextStyle(
                                        color: Color(0XFFaaaaaa),
                                        fontSize: ScreenAdaper.fontSize(26)
                                    ),
                                    filled: true,
                                    fillColor: Color(0XFFf5f5f5),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                        borderSide: BorderSide.none
                                    )
                                )
                            )
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(20)
                            ),
                            child: Wrap(
                                runSpacing: ScreenAdaper.width(20),
                                spacing: ScreenAdaper.width(20),
                                alignment: WrapAlignment.start,
                                children: <Widget>[
                                    this._imageWidget(),
                                    this._imageWidget(),
                                    this._imageWidget(),
                                    this._imageWidget(),
                                    this._imageWidget(),
                                    this._imageWidget(),
                                    this._imageUpload()
                                ]
                            ),
                        )
                    ]
                )
            ),
        );
    }
}