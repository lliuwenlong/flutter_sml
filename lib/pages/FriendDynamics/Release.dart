import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import 'dart:ui';
class FriendDynamicsRelease extends StatelessWidget {
    const FriendDynamicsRelease({Key key}) : super(key: key);
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

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("发布"),
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
                    ScreenAdaper.height(88) + ScreenAdaper.height(20)
                ),
                child: Column(
                    children: <Widget>[
                        TextField(
                            maxLines: 6,
                            decoration: InputDecoration(
                                fillColor: Color(0xFFf5f5f5),
                                filled: true,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                    borderSide: BorderSide.none,
                                ),
                                contentPadding: EdgeInsets.fromLTRB(
                                    ScreenAdaper.width(30),
                                    ScreenAdaper.width(25),
                                    ScreenAdaper.width(30),
                                    ScreenAdaper.width(25)
                                ),
                                hintText: "想对大家说",
                                hintStyle: TextStyle(
                                    color: ColorClass.subTitleColor,
                                    fontSize: ScreenAdaper.fontSize(28)
                                )
                            ),
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
            )
        );
    }
}