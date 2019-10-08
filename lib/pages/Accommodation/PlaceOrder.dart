import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../components/AppBarWidget.dart';
import 'dart:ui';
class PlaceOrder extends StatelessWidget {
    const PlaceOrder({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar("订单确认"),
            bottomSheet: Container(
                width: double.infinity,
                height: ScreenAdaper.height(110) + MediaQueryData.fromWindow(window).padding.bottom,
                padding: EdgeInsets.only(
                    bottom: MediaQueryData.fromWindow(window).padding.bottom
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 1)
                    ]
                ),
                child: Container(
                    child: Row(
                        children: <Widget>[
                            Expanded(
                                flex: 1,
                                child:Container(
                                    height: ScreenAdaper.height(110),
                                    alignment: Alignment.center,
                                    child: Text.rich(new TextSpan(
                                        style: TextStyle(
                                            color: Color(0xFFfb4135),
                                            fontWeight: FontWeight.w500
                                        ),
                                        children: <TextSpan>[
                                            TextSpan(
                                                text: '¥',
                                                style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(26)
                                                )
                                            ),
                                            TextSpan(
                                                text: '188',
                                                style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(44)
                                                )
                                            )
                                        ]
                                    )),
                                ),
                            ),
                            Container(
                                height: ScreenAdaper.height(110),
                                child: RaisedButton(
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero
                                    ),
                                    onPressed: () {
                                    },
                                    color: ColorClass.common,
                                    child: Text("在线预订，商家确认后付款", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenAdaper.fontSize(34)
                                    ))
                                )
                            )
                        ]
                    ),
                )
            ),
            body: Container(
                child: Column(
                    children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(ScreenAdaper.width(30)),
                            color: Colors.white,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Text("高级大床房", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(34),
                                        fontWeight: FontWeight.w500
                                    )),
                                    SizedBox(height: ScreenAdaper.width(20)),
                                    Container(
                                        child: Row(
                                            children: <Widget>[
                                                Text("8月3日", style: TextStyle(
                                                    color: Color(0xFFc1a786),
                                                    fontSize: ScreenAdaper.fontSize(34),
                                                    fontWeight: FontWeight.w500
                                                )),
                                                SizedBox(width: ScreenAdaper.width(20)),
                                                Text("入住", style: TextStyle(
                                                    color: ColorClass.fontColor,
                                                    fontSize: ScreenAdaper.fontSize(24),
                                                )),
                                                SizedBox(width: ScreenAdaper.width(40)),
                                                Text("——", style: TextStyle(
                                                    color: Color(0xFFd9d9d9),
                                                    fontSize: ScreenAdaper.fontSize(24),
                                                )),
                                                SizedBox(width: ScreenAdaper.width(40)),
                                                Text("8月3日", style: TextStyle(
                                                    color: Color(0xFFc1a786),
                                                    fontSize: ScreenAdaper.fontSize(34),
                                                    fontWeight: FontWeight.w500
                                                )),
                                                SizedBox(width: ScreenAdaper.width(20)),
                                                Text("离店", style: TextStyle(
                                                    color: ColorClass.fontColor,
                                                    fontSize: ScreenAdaper.fontSize(24),
                                                )),
                                            ]
                                        )
                                    )
                                ]
                            )
                        ),
                        Container(
                            color: Colors.white,
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
                                        bottom: BorderSide(
                                            color: ColorClass.borderColor,
                                            width: ScreenAdaper.width(1)
                                        )
                                    )
                                ),
                                child: Row(
                                    children: <Widget>[
                                        Container(
                                            width: ScreenAdaper.width(120),
                                            child: Text("入住人", style: TextStyle(
                                                color: ColorClass.titleColor,
                                                fontSize: ScreenAdaper.fontSize(28)
                                            )),
                                        ),
                                        SizedBox(width: ScreenAdaper.width(20)),
                                        Expanded(
                                            flex: 1,
                                            child: TextField(
                                                textAlign: TextAlign.end,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                                        borderSide: BorderSide.none,
                                                    ),
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 1),
                                                    hintText: "请填写入住人姓名",
                                                    hintStyle: TextStyle(
                                                        color: ColorClass.subTitleColor,
                                                        fontSize: ScreenAdaper.fontSize(28)
                                                    ),
                                                ),
                                            )
                                        )
                                    ]
                                )
                            ),
                        ),
                        Container(
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                left: ScreenAdaper.width(30),
                                right: ScreenAdaper.width(30)
                            ),
                            child: Container(
                                padding: EdgeInsets.only(
                                    top: ScreenAdaper.width(30),
                                    bottom: ScreenAdaper.width(30)
                                ),
                                child: Row(
                                    children: <Widget>[
                                        Container(
                                            width: ScreenAdaper.width(120),
                                            child: Text("联系手机", style: TextStyle(
                                                color: ColorClass.titleColor,
                                                fontSize: ScreenAdaper.fontSize(28)
                                            )),
                                        ),
                                        SizedBox(width: ScreenAdaper.width(20)),
                                        Expanded(
                                            flex: 1,
                                            child: TextField(
                                                textAlign: TextAlign.end,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                                        borderSide: BorderSide.none,
                                                    ),
                                                    contentPadding: const EdgeInsets.symmetric(vertical: 1),
                                                    hintText: "请填填写手机号",
                                                    hintStyle: TextStyle(
                                                        color: ColorClass.subTitleColor,
                                                        fontSize: ScreenAdaper.fontSize(28)
                                                    ),
                                                ),
                                            )
                                        )
                                    ]
                                )
                            ),
                        ),
                        Container(
                            padding: EdgeInsets.all(ScreenAdaper.width(30)),
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(20)
                            ),
                            color: Colors.white,
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Text("发票", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(28)
                                    )),
                                    Text("如需发票，请向酒店前台索取", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(28)
                                    )),
                                ]
                            )
                        )
                    ]
                )
            )
        );
    }
}