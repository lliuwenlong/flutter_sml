import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';

class RemarksInformation extends StatelessWidget {
    RemarksInformation({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("备注信息"),
            body: Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdaper.width(30),
                    ScreenAdaper.height(20),
                    ScreenAdaper.width(30),
                    0
                ),
                child: Column(
                    children: <Widget>[
                        TextField(
                            maxLines: 8,
                            decoration: InputDecoration(
                                hintText: "请输入您的备注信息",
                                hintStyle: TextStyle(
                                    color: Color(0XFFaaaaaa),
                                    fontSize: ScreenAdaper.fontSize(26),
                                ),
                                filled: true,
                                fillColor: Color(0XFFf5f5f5),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                    borderSide: BorderSide.none
                                )
                            )
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(50)
                            ),
                            height: ScreenAdaper.height(88),
                            width: double.infinity,
                            child: RaisedButton(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                                ),
                                onPressed: () {
                                },
                                child: Text("提交", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdaper.fontSize(40)
                                )),
                                color: ColorClass.common,
                            ),
                        )
                    ]
                )
            )
        );
    }
}