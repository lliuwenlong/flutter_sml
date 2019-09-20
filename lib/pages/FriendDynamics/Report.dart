import 'package:flutter/material.dart';
import 'package:flutter_sml/model/store/user/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import 'package:provider/provider.dart';
import '../../common/HttpUtil.dart';
import 'dart:ui';
class FriendDynamicsReport extends StatefulWidget {
    Map arguments;
    FriendDynamicsReport({Key key, this.arguments}) : super(key: key);
    _FriendDynamicsReportState createState() => _FriendDynamicsReportState();
}

class _FriendDynamicsReportState extends State<FriendDynamicsReport> {
    int _listIndex = -1;
    List _list = [];
    User _userModel;
    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
    }

    @override 
    void initState() {
        this._getData();
    }

    _getData () async {
        Map response = await HttpUtil().get("/api/v1/circle/msg/{messageId}/report/reasons");
        if (response["code"] == 200) {
            setState(() {
                this._list = response["data"];
            });
        }
    }

    _submit () async {
        if (this._listIndex == -1) {
            Fluttertoast.showToast(
                msg: "请选择一项举报的内容",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIos: 1,
                textColor: Colors.white,
                fontSize: ScreenAdaper.fontSize(30)
            );
            return;
        }
        final Map response = await HttpUtil().post("/api/v1/circle/msg/${this.widget.arguments["id"]}/report/", data: {
            "userId": this._userModel.userId,
            "reason": this._list[this._listIndex]["name"]
        });
        if (response["code"] == 200) {
            Navigator.pop(context);
        }
    }
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
                height: ScreenAdaper.height(108) + MediaQueryData.fromWindow(window).padding.bottom,
                padding: EdgeInsets.only(
                    bottom: MediaQueryData.fromWindow(window).padding.bottom + ScreenAdaper.height(10),
                    top: ScreenAdaper.height(10),
                    left: ScreenAdaper.width(30),
                    right: ScreenAdaper.width(30)
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 1)
                    ]
                ),
                child: RaisedButton(
                    elevation: 0,
                    onPressed: () {
                        this._submit();
                    },
                    color: ColorClass.common,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                    ),
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
                                            this._list[index],
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