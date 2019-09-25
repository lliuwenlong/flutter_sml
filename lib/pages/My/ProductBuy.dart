import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../common/HttpUtil.dart';
import 'dart:ui';

class ProductBuy extends StatefulWidget {
  int userId;
    double price;
    String woodSn;
    ProductBuy({Key key,this.userId, this.price,this.woodSn});
    _ProductBuyState createState() => _ProductBuyState(userId:this.userId,price: this.price,woodSn:this.woodSn);
}

class _ProductBuyState extends State<ProductBuy>  {
    BuildContext _selfContext;
    int userId;
    double price;
    String woodSn;
    _ProductBuyState({Key key,this.userId, this.price, this.woodSn});
    bool isPay = true;
    String payType = "Wechat";
    final HttpUtil http = HttpUtil();
    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
    }

    @override
    initState () {
        super.initState();
    }
    _payment () async {
        Map  response =  await this.http.post('/api/v1/wood/renew',data: {
          'userId': this.userId,
          'woodSn': this.woodSn,
        });
        if(response['code'] == 200){
            Fluttertoast.showToast(
              msg: '支付成功',
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              timeInSecForIos: 1,
              gravity: ToastGravity.CENTER,
              fontSize: ScreenAdaper.fontSize(30)
            );
             Navigator.pop(context);
        }else{
           Fluttertoast.showToast(
              msg: response['msg'],
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.black87,
              textColor: Colors.white,
              timeInSecForIos: 1,
              gravity: ToastGravity.CENTER,
              fontSize: ScreenAdaper.fontSize(30)
            );
        }

    }
    _onPay () {
        print(this.payType);
      this._payment();

    }
    Widget _header (String name) {
        return Container(
            padding: EdgeInsets.all(
                ScreenAdaper.width(30)
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                    Text(name, style: TextStyle(
                        color: ColorClass.fontColor,
                        fontSize: ScreenAdaper.fontSize(30)
                    )),
                    GestureDetector(
                        onTap: () {
                            Navigator.pop(_selfContext);
                        },
                        child: Icon(
                            IconData(0xe633, fontFamily: "iconfont"),
                            color: ColorClass.borderColor,
                            size: ScreenAdaper.fontSize(30)
                        )
                    )
                ]
            )
        );
    }

    Widget _rowItem (String type) {
        Map<String, Map> icon = {
            "Wechat": {
                "icon": 0xe622,
                "color": 0xFF00c803,
                "text": "微信支付"
            },
            "Alipay": {
                "icon": 0xe623,
                "color": 0xFF00a9e9,
                "text": "支付宝支付"
            }
        };
        Map obj = icon[type];
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
                Row(
                    children: <Widget>[
                        Icon(
                            IconData(obj["icon"], fontFamily: "iconfont"),
                            size: ScreenAdaper.fontSize(40),
                            color: Color(obj["color"]),
                        ),
                        SizedBox(width: ScreenAdaper.width(20)),
                        Text(obj["text"])
                    ]
                ),
                this.payType == type
                ? Icon(IconData(
                    0xe621,
                    fontFamily: "iconfont"
                ), size: ScreenAdaper.fontSize(40), color: Color(0xFFd4746c))
                : GestureDetector(
                    onTap: () {
                        setState(() {
                            this.payType = type;
                        });
                    },
                    child: Container(
                        width: ScreenAdaper.width(40),
                        height: ScreenAdaper.width(40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(150),
                            color: Color(0xFFf7f7f7),
                            border: Border.all(
                                width: ScreenAdaper.width(2),
                                color: ColorClass.subTitleColor
                            )
                        )
                    )
                )
            ]
        );
    }

    Widget _paymentType () {
        return Container(
            width: double.infinity,
            padding: EdgeInsets.all(ScreenAdaper.width(30)),
            child: Column(
                children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                            Text("支付金额：", style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(34)
                            )),
                            Text("¥ ${this.price}", style: TextStyle(
                                color: ColorClass.fontRed,
                                fontSize: ScreenAdaper.fontSize(34)
                            )),
                            Text("元", style: TextStyle(
                                color: ColorClass.titleColor,
                                fontSize: ScreenAdaper.fontSize(34)
                            )),
                        ],
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            top: ScreenAdaper.height(30),
                            bottom: ScreenAdaper.height(30)
                        ),
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(10),
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: ColorClass.borderColor,
                                    width: ScreenAdaper.width(1)
                                )
                            )
                        ),
                        child: _rowItem("Wechat")
                    ),
                    Container(
                        padding: EdgeInsets.only(
                            top: ScreenAdaper.height(30),
                            bottom: ScreenAdaper.height(30)
                        ),
                        child: _rowItem("Alipay")
                    ),
                    Container(
                        margin:  EdgeInsets.only(
                            top: ScreenAdaper.height(20),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                                Text("请仔细阅读", style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(22),
                                    color: ColorClass.subTitleColor
                                )),
                                Text("神木林购买协议", style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(22),
                                    color: ColorClass.common
                                )),
                                Text(",支付代表您接受本协议内容", style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(22),
                                    color: ColorClass.subTitleColor
                                ))
                            ]
                        ),
                    )
                ]
            )
        );
    }

    Widget _button ({Function onTap}) {
        return Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                ScreenAdaper.height(20),
                ScreenAdaper.width(30),
                ScreenAdaper.height(20)
            ),
            child: Container(
                height: ScreenAdaper.height(88),
                child: RaisedButton(
                    elevation: 0,
                    onPressed: () {
                        onTap != null && onTap();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                    ),
                    color: ColorClass.common,
                    child: Text("购买", style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenAdaper.fontSize(40)
                    ))
                )
            )
        );
    }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        this._selfContext = context;
        return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQueryData.fromWindow(window).padding.bottom
            ),
            child: Container(
                width: double.infinity,
                child: Wrap(
                            children: <Widget>[
                                _header("确认支付"),
                                _paymentType(),
                                _button(onTap: _onPay)
                            ]
                        )
            )
        );
    }
}