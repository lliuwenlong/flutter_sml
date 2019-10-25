import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_sml/model/store/user/User.dart';
import 'package:flutter_sml/pages/Shop/PurchaseAgreement.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sy_flutter_wechat/sy_flutter_wechat.dart';
import '../../model/store/shop/Shop.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../model/api/shop/DistsModel.dart';
import '../../common/HttpUtil.dart';
import 'dart:ui';
import 'dart:io';
// import 'package:fluwx/fluwx.dart' as fluwx;

class Purchase extends StatefulWidget {
    int prodId;
    double price;
    String woodSn;
    Purchase({Key key, this.prodId, this.price, this.woodSn});
    _PurchaseState createState() => _PurchaseState(prodId: this.prodId, price: this.price, woodSn:this.woodSn);
}

class _PurchaseState extends State<Purchase>  {
    BuildContext _selfContext;
    int prodId;
    double price;
    String woodSn;
    List<Data> list = [];
    _PurchaseState({this.prodId = 0, Key key, this.price,this.woodSn});
    bool isPay = false;
    String payType = "Wechat";
    int treeNum = 1;
    final HttpUtil http = HttpUtil();
    bool isDisabled = false;
    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
    }

    @override
    initState () {
        super.initState();
        // fluwx.responseFromPayment.listen((response){
        //     if (response.errCode == 0) {
        //         Navigator.pushReplacementNamed(context, "/order");
        //         setState(() {
        //             this.isDisabled = false;
        //         });
        //     } else {
        //         setState(() {
        //             this.isDisabled = false;
        //         });
        //     }
        // });
    }
    _payment () async {
        setState(() {
            this.isDisabled = true;
        });
        Map res = await this.http.post('/api/v12/wxpay/unifiedorder', params: {
            "valueProduct": {
                "amount": this.price*this.treeNum,
                "channel": "Wechat",
                "num": this.treeNum,
                "platform": Platform.isAndroid?'Android' : Platform.isIOS ? 'IOS' : 'Other',
                "prodId": this.prodId,
                "tradeType": "APP",
                "userId": Provider.of<User>(context).userId,
                "woodSn": this.woodSn
            },
            "goodsType": "valuepro"
        });
        
		if(res['code']== 200){
			var data = jsonDecode(res["data"]);
            Map<String, String> payInfo = {
                "appid":"wxa22d7212da062286",
                "partnerid": data["partnerid"],
                "prepayid": data["prepayid"],
                "package": "Sign=WXPay",
                "noncestr": data["noncestr"],
                "timestamp": data["timestamp"],
                "sign": data["sign"].toString()
            };
            try  {
                SyPayResult payResult = await SyFlutterWechat.pay(SyPayInfo.fromJson(payInfo));
                if (payResult == SyPayResult.success) {
                    Navigator.pushReplacementNamed(context, "/order");
                }
                setState(() {
                    this.isDisabled = false;
                });
            } catch (e) {
                print(e);
            }
            // fluwx.pay(appId: "wxa22d7212da062286", 
            //     partnerId: data["partnerid"],
            //     prepayId: data["prepayid"],
            //     packageValue: data["package"],
            //     nonceStr: data["noncestr"],
            //     timeStamp: int.parse(data["timestamp"]),
            //     sign: data["sign"].toString(),
            //     signType: data["signType"]
            // ).then((val) {
            //     Fluttertoast.showToast(
            //         msg: "${val}",
            //         toastLength: Toast.LENGTH_SHORT,
            //         gravity: ToastGravity.CENTER,
            //         timeInSecForIos: 1,
            //         textColor: Colors.white,
            //         fontSize: ScreenAdaper.fontSize(30)
            //     );
            // });
		}
    }
    _onPay () {
		this._payment();
        print(this.payType);
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
                        fontSize: ScreenAdaper.fontSize(26)
                    )),
                    Container(
                        width: ScreenAdaper.width(50),
                        height: ScreenAdaper.width(50),
                        child: IconButton(
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                                Navigator.pop(_selfContext);
                            },
                            icon: Icon(
                                Icons.close,
                                color: ColorClass.borderColor,
                                size: ScreenAdaper.fontSize(60)
                            )
                        ),
                    )
                ]
            )
        );
    }

    Widget _purchaseQuantity() {
        return Container(
            child: Column(
                children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            left: ScreenAdaper.width(30),
                            right: ScreenAdaper.width(30)
                        ),
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(20)
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                                Text("数量", style: TextStyle(
                                    color: ColorClass.titleColor,
                                    fontSize: ScreenAdaper.fontSize(28),
                                    fontWeight: FontWeight.w500
                                )),
                                Container(
                                    height: ScreenAdaper.height(50),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Color(0xFFd9d9d9),
                                            width: 1
                                        )
                                    ),
                                    child: Row(
                                        children: <Widget>[
                                            Container(
                                                width: ScreenAdaper.height(50),
                                                height: ScreenAdaper.height(50),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                          this.treeNum = this.treeNum -1;
                                                      });
                                                    },
                                                    icon: Icon(IconData(0xe635, fontFamily: "iconfont")),
                                                    color: treeNum == 1 ? Color(0xFFd9d9d9) : ColorClass.fontRed,
                                                    iconSize: ScreenAdaper.fontSize(20),
                                                )
                                            ),
                                            Container(
                                                height: ScreenAdaper.height(50),
                                                width: ScreenAdaper.width(80),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border(
                                                        left: BorderSide(
                                                            color: Color(0xFFd9d9d9),
                                                            width: 1
                                                        ),
                                                        right: BorderSide(
                                                            color: Color(0xFFd9d9d9),
                                                            width: 1
                                                        )
                                                    )
                                                ),
                                                child: Text("$treeNum", style: TextStyle(
                                                    color: Color(0xFF000000),
                                                    fontSize: ScreenAdaper.fontSize(30)
                                                ))
                                            ),
                                            Container(
                                                width: ScreenAdaper.height(50),
                                                height: ScreenAdaper.height(50),
                                                child: IconButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        this.treeNum = this.treeNum + 1;
                                                      });
                                                    },
                                                    icon: Icon(IconData(0xe634, fontFamily: "iconfont")),
                                                    color: ColorClass.fontRed,
                                                    iconSize: ScreenAdaper.fontSize(20),
                                                )
                                            )
                                        ]
                                    )
                                )
                            ]
                        )
                    )
                ]
            ),
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
                            Text("¥ ${this.treeNum * this.price }", style: TextStyle(
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
                            // border: Border(
                            //     bottom: BorderSide(
                            //         color: ColorClass.borderColor,
                            //         width: ScreenAdaper.width(1)
                            //     )
                            // )
                        ),
                        child: _rowItem("Wechat")
                    ),
                    // Container(
                    //     padding: EdgeInsets.only(
                    //         top: ScreenAdaper.height(30),
                    //         bottom: ScreenAdaper.height(30)
                    //     ),
                    //     child: _rowItem("Alipay")
                    // ),
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
                                GestureDetector(
                                    onTap: () {
                                        Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
                                            return PurchaseAgreement();
                                        }));
                                    },
                                    child: Text("神木林购买协议", style: TextStyle(
                                        fontSize: ScreenAdaper.fontSize(22),
                                        color: ColorClass.common
                                    )),
                                ),
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
                    onPressed: isDisabled ? null : () {
                        onTap != null && onTap();
                    },
                    disabledColor: Color(0xFF86d4ca),
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
                child: Consumer<ShopModel>(
                    builder: (BuildContext context, ShopModel shopModel, child) {
                        return !isPay ? Wrap(
                            children: <Widget>[
                                _header("购买数量"),
                                _purchaseQuantity(),
                                _button(
                                    onTap: () {
                                        setState(() {
                                            isPay = true;
                                        });
                                    }
                                )
                            ]
                        )
                        :  Wrap(
                            children: <Widget>[
                                _header("确认支付"),
                                _paymentType(),
                                _button(onTap: _onPay)
                            ]
                        );
                    },
                )
            )
        );
    }
}