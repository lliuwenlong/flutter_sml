import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
class Base extends StatefulWidget {
    Base({Key key}) : super(key: key);
    _BaseState createState() => _BaseState();
}

class _BaseState extends State<Base> {
    Widget _cardItem() {
        return Container(
            margin: EdgeInsets.only(top: ScreenAdaper.height(30)),
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                0,
                ScreenAdaper.width(30),
                0
            ),
            child: Card(
                elevation: 0,
                child: Column(
                    children: <Widget>[
                        AspectRatio(
                            aspectRatio: 690 / 276,
                            child: GestureDetector(
                                onTap: () {
                                    Navigator.pushNamed(context, "/baseDetails");
                                },
                                child: ClipRRect(
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(4),
                                        topLeft: Radius.circular(4)
                                    ),
                                    child: Image.network(
                                        "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                                        fit: BoxFit.cover,
                                    )
                                )
                            ),
                        ),
                        Padding(
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(20),
                                ScreenAdaper.height(30),
                                ScreenAdaper.width(20),
                                ScreenAdaper.height(30)
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Row(
                                        children: <Widget>[
                                            Icon(
                                                IconData(0xe61d, fontFamily: "iconfont"),
                                                size: ScreenAdaper.fontSize(30, allowFontScaling: true),
                                                color: Color(0xFF22b0a1)
                                            ),
                                            SizedBox(width: ScreenAdaper.width(20)),
                                            Text("神木基地名称", style: TextStyle(
                                                color: Color(0xFF666666),
                                                fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true)
                                            ))
                                        ],
                                    ),
                                    Container(
                                        child: RaisedButton(
                                            onPressed: () {
                                                Navigator.pushNamed(context, '/baseList');
                                            },
                                            color: Color(0xFF22b0a1),
                                            splashColor: Color.fromRGBO(0, 0, 0, 0),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(6))
                                            ),
                                            child: Text("查看神木", style: TextStyle(
                                                color: Color(0xFFffffff)
                                            )),
                                        )
                                    )
                                ]
                            ),
                        )
                    ]
                )
            )
        );
    }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("神木基地", style: TextStyle(
                    color: Colors.black,
                )),
                elevation: 1,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                centerTitle: true,
                brightness: Brightness.light
            ),
            body: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, item) {
                    return _cardItem();
                },
            )
        );
    }
}