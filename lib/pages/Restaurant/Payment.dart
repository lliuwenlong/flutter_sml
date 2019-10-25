import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sml/model/store/shop/Shop.dart';
import 'package:provider/provider.dart';
import 'package:sy_flutter_wechat/sy_flutter_wechat.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/HttpUtil.dart';
import '../../model/store/user/User.dart';
// import 'package:fluwx/fluwx.dart' as fluwx;

class Payment extends StatefulWidget {
  final arguments;
  Payment({Key key,this.arguments}) : super(key: key);

  _PaymentState createState() => _PaymentState(arguments:this.arguments);
}

class _PaymentState extends State<Payment> {
  final arguments;
  _PaymentState({this.arguments});
  	String _payType = 'Wechat';
  	String _inputText = '';
	TextEditingController _moneyController = TextEditingController.fromValue(
      	TextEditingValue(
        	text: "",
    	)
  	);
	final HttpUtil http = HttpUtil();
 	User _userModel;
	List couponList = [];
    bool isDisabled = false;
    Map chooseCouponParams = {};
    @override
    void initState() {
        // print(this.arguments);
        super.initState();
        // fluwx.responseFromPayment.listen((response){
        //     setState(() {
        //         this.isDisabled = false;
        //     });
        //     if (response.errCode == 0) {
        //         Navigator.pushReplacementNamed(context, "/order");
        //     } else {
        //     }
        // });
    }
	@override
	void didChangeDependencies() {
		super.didChangeDependencies();
		_userModel = Provider.of<User>(context);
		_getData();
	}

    _getPrice () {
        return ((_inputText.isEmpty ? 0 : double.parse(_inputText)) - double.parse(this.chooseCouponParams['worth']));
    }
  	_getData () async{
		Map res = await this.http.get('/api/v1/coupon/user',data: {
			'firmId': arguments['firmId'],
			'userId': this._userModel.userId
		});
		if (res['code'] == 200) {
			setState(() {
			  	this.couponList  = res['data'];
			});
		}
    }
    onPay () async {
        Map type = {
            1: "food",
            2: "shopping",
            3: "nearplay"
        };

        Map typeName = {
            1: "餐饮",
            2: "购物",
            3: "周边游"
        };
        setState(() {
            isDisabled = true;
        });
     
        if (this._payType == "Wechat") {
            Map res = await this.http.post("/api/v12/wxpay/unifiedorder", params: {
                 "food": {
                    "amount": this._moneyController.text,
                    "channel": "Wechat",
                    "desc": typeName[this.arguments['type']],
                    "firmId": this.arguments['firmId'],
                    "platform": Platform.isAndroid ? "Android" : "IOS",
                    "tradeType": "APP",
                    "type": type[this.arguments['type']],
                    "userCouponId": this.chooseCouponParams["couponId"] != null ? this.chooseCouponParams["couponId"] : null,
                    "userId": this._userModel.userId
                },
                "goodsType": type[this.arguments['type']]
            });
            if (res["code"] == 200) {
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

                SyPayResult payResult = await SyFlutterWechat.pay(SyPayInfo.fromJson(payInfo));
                Provider.of<ShopModel>(context).changeIsDisabled(false);
                if (payResult == SyPayResult.success) {
                    Navigator.pushReplacementNamed(context, "/order");
                }
                setState(() {
                    this.isDisabled = false;
                });
                // await fluwx.pay(appId: "wxa22d7212da062286", 
                //     partnerId: data["partnerid"],
                //     prepayId: data["prepayid"],
                //     packageValue: data["package"],
                //     nonceStr: data["noncestr"],
                //     timeStamp: int.parse(data["timestamp"]),
                //     sign: data["sign"].toString(),
                //     signType: data["signType"]
                // );
            }
        }
    }
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBarWidget().buildAppBar('付款'),
            bottomSheet: Container(
                width: double.infinity,
                height: ScreenAdaper.height(110) + MediaQueryData.fromWindow(window).padding.bottom,
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
                    child: Text(
                        arguments["type"] == 1 ? "确认买单" : '付款',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenAdaper.fontSize(28)),
                    ),
                    disabledColor: Color(0XFF86d4ca), //禁用时的颜色
                    splashColor: Color.fromARGB(0, 0, 0, 0), //水波纹
                    highlightColor: Color(0xff009a8a),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    color: Color(0XFF22b0a1), //默认颜色
                    onPressed: _inputText != "" && !isDisabled ? () {
                        this.onPay();
                    } : null,
                )
            ),
            body: SafeArea(
                top: false,
                child:ConstrainedBox(
                constraints: BoxConstraints.expand(),
                child: Stack(
                    children: <Widget>[
                    Container(
                        child: Column(
                            children: <Widget>[
                                Container(
                                    color: Colors.white,
                                    padding: EdgeInsets.only(
                                        left: ScreenAdaper.width(30),
                                        right: ScreenAdaper.width(30)),
                                    child: Container(
                                    height: ScreenAdaper.height(124),
                                    alignment: Alignment.centerLeft,
                                    decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                    bottom: BorderSide(color: Color(0xffd9d9d9), width: 1))),
                                    child: arguments['type']=='house'?
                                    Text(
                                        '¥ ${arguments['amount']}',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: ScreenAdaper.fontSize(60)),
                                    ): Container(
                                        child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                                Text('¥',
                                                    style: TextStyle(
                                                        color: Color(0xff333333),
                                                        fontSize: ScreenAdaper.fontSize(60),
                                                )),
                                                SizedBox(width: ScreenAdaper.width(10),),
                                                Expanded(
                                                    flex: 1,
                                                    child: TextField(
                                                        decoration: InputDecoration(
                                                            hintText: '请询问店员后输入金额',
                                                            hintStyle: TextStyle(
                                                                color: Color(0xff666666),
                                                                fontSize: ScreenAdaper.fontSize(30),
                                                            ),
                                                            border: InputBorder.none
                                                        ),
                                                        style: TextStyle(
                                                            color: Color(0xff333333),
                                                            fontSize: ScreenAdaper.fontSize(_inputText != "" ? 50 : 30),
                                                        ),
                                                        controller: _moneyController,
                                                        keyboardType: TextInputType.number,
                                                        inputFormatters: <TextInputFormatter>[
                                                            // WhitelistingTextInputFormatter.digitsOnly,
                                                            WhitelistingTextInputFormatter(RegExp("[0-9.]"))
                                                            // LengthLimitingTextInputFormatter(6)
                                                        ],
                                                        onChanged: (val){
                                                            List arr = val.split(".");
                                                            if ((arr.length == 2 && arr[1].length > 2) || arr.length > 2) {
                                                                TextEditingController controller = TextEditingController.fromValue(TextEditingValue(
                                                                    text: _inputText,
                                                                    selection: TextSelection.fromPosition(TextPosition(
                                                                        affinity: TextAffinity.downstream,
                                                                        offset: _inputText.length)))
                                                                );
                                                                setState(() {
                                                                    _moneyController = controller;
                                                                });
                                                            } else {
                                                                setState(() {
                                                                    this._inputText = val;  
                                                                });
                                                            }
                                                        },
                                                    ),
                                                )
                                            ],
                                        ),
                                    )
                                ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
                                color: Colors.white,
                                child: Container(
                                    padding: EdgeInsets.only(
                                    top: ScreenAdaper.height(32),
                                    bottom: ScreenAdaper.height(32)),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xffd9d9d9), width: 1))),
                                    child: GestureDetector(
                                        onTap: () {
                                            Navigator.of(context).pushNamed( '/chooseCoupon',arguments: {
                                                'firmId': arguments['firmId'],
                                                'type': arguments['type'],
                                                'orderSn': arguments['orderSn'],
                                                'amount': arguments['amount'],
                                                'couponId': this.chooseCouponParams['couponId'] != null ? this.chooseCouponParams['couponId'] : 0
                                            }).then((val) {
                                                Map params = val;
                                                if (val == null) {
                                                    return;
                                                }
                                                setState(() {
                                                    this.chooseCouponParams = params;
                                                });
                                            });
                                        },
                                        child: Column(
                                        children: <Widget>[
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                            Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: <Widget>[
                                                Container(
                                                    width: ScreenAdaper.width(40),
                                                    height: ScreenAdaper.width(40),
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage('images/hui.png'),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                ),
                                                SizedBox(
                                                    width: ScreenAdaper.width(20),
                                                ),
                                                Text(
                                                    '优惠券',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "SourceHanSansCN-Medium",
                                                        fontSize: ScreenAdaper.fontSize(28),
                                                        color: Color(0xff333333)),
                                                )
                                                ],
                                            ),
                                            Row(
                                                children: <Widget>[
                                                this.chooseCouponParams['worth'] == null ? Container(
                                                    child: this.couponList.length > 0 ? Text(
                                                        '${this.couponList.length}张可用',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "SourceHanSansCN-Medium",
                                                            fontSize: ScreenAdaper.fontSize(28),
                                                            color: Color(0xff999999)
                                                        ),
                                                    ): Text(
                                                        '暂无可用优惠券',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "SourceHanSansCN-Medium",
                                                            fontSize: ScreenAdaper.fontSize(28),
                                                            color: Color(0xff999999)),
                                                    ),
                                                ): Text(
                                                    '${this.chooseCouponParams['worth']}元代金券',
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "SourceHanSansCN-Medium",
                                                        fontSize: ScreenAdaper.fontSize(28),
                                                        color: Color(0xff999999)),
                                                ),
                                                Icon(
                                                    IconData(0xe61e,
                                                        fontFamily: 'iconfont'),
                                                    color: Color(0xff999999),
                                                    size: ScreenAdaper.fontSize(26),
                                                )
                                                ],
                                            )
                                            ],
                                        ),
                                        SizedBox(
                                            height: ScreenAdaper.height(10),
                                        ),
                                        this.chooseCouponParams['worth']!=null?Container(
                                            alignment: Alignment.bottomRight,
                                            child: Text(
                                                '- ¥ ${this.chooseCouponParams['worth']}',
                                                style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(34),
                                                    color: Color(0xfffb4135)),
                                            )):SizedBox(height: 0,)
                                        ],
                                    ),
                                )
                                ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
                                color: Colors.white,
                                child: Container(
                                    height: ScreenAdaper.height(100),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Color(0xffd9d9d9), width: 1))),
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                    Text(
                                    '合计',
                                    style: TextStyle(
                                        color: Color(0xff666666),
                                        fontSize: ScreenAdaper.fontSize(28)),
                                    ),
                                    SizedBox(
                                    width: ScreenAdaper.width(30),
                                    ),

                                    arguments['type'] =='house'? 
                                        Container(
                                            child: this.chooseCouponParams['worth']==null ? Text(
                                                '¥ ${arguments['amount']}',
                                                style: TextStyle(
                                                    color: Color(0xff333333),
                                                    fontSize: ScreenAdaper.fontSize(48)),
                                            ):Text(
                                                '¥ ${double.parse(arguments['amount']) - double.parse(arguments['worth'])}',
                                                style: TextStyle(
                                                    color: Color(0xff333333),
                                                    fontSize: ScreenAdaper.fontSize(48)),
                                            ),
                                        ):Container(
                                            child: this.chooseCouponParams['worth'] == null ?
                                                Text(
                                                    '¥ $_inputText',
                                                    style: TextStyle(
                                                        color: Color(0xff333333),
                                                        fontSize: ScreenAdaper.fontSize(48)),
                                                ):Text(
                                                    '¥ ${_getPrice() > 0 ? _getPrice()  : 0.01}',
                                                    style: TextStyle(
                                                        color: Color(0xff333333),
                                                        fontSize: ScreenAdaper.fontSize(48)),
                                                ),
                                        ),
                                ],
                                )
                                ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
                                color: Colors.white,
                            child: Container(
                                height: ScreenAdaper.height(100),
                            // decoration: BoxDecoration(
                            //     border: Border(
                            //         bottom: BorderSide(
                            //             color: Color(0xffd9d9d9), width: 1))),
                            child: GestureDetector(
                                onTap: () {
                                setState(() {
                                    this._payType = 'Wechat';
                                });
                                },
                                child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                    Row(
                                    children: <Widget>[
                                        Icon(
                                        IconData(0xe622, fontFamily: 'iconfont'),
                                        size: ScreenAdaper.fontSize(40),
                                        color: Color(0xff00c803),
                                        ),
                                        SizedBox(
                                        width: ScreenAdaper.width(20),
                                        ),
                                        Text(
                                        '微信支付',
                                        style: TextStyle(
                                            color: Color(0xff333333),
                                            fontSize: ScreenAdaper.fontSize(28)),
                                        )
                                    ],
                                    ),
                                    _payType == 'Wechat'
                                        ? CircleAvatar(
                                            backgroundColor: Color(0xffd4746c),
                                            radius: ScreenAdaper.width(20),
                                            child: Icon(
                                            IconData(0xe643, fontFamily: 'iconfont'),
                                            size: ScreenAdaper.fontSize(20),
                                            color: Color(0xffffffff),
                                            ),
                                        )
                                        : CircleAvatar(
                                            radius: ScreenAdaper.width(20),
                                            backgroundColor:Colors.white,
                                            child: Container(
                                                width: ScreenAdaper.width(40),
                                                height: ScreenAdaper.height(40),
                                                decoration: BoxDecoration(
                                                    color: Color(0xfff7f7f7),
                                                    border: Border.all(
                                                        color: Color(0xff999999),
                                                        width: ScreenAdaper.width(1)
                                                    ),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(20)))),
                                        )
                                ],
                                ),
                            )
                            ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30),bottom: ScreenAdaper.height(50)),
                                color: Colors.white,
                            // child: Container(
                            //     height: ScreenAdaper.height(100),
                            //     child: GestureDetector(
                            //         onTap: () {
                            //             setState(() {
                            //                 this._payType = 'Alipay';
                            //             });
                            //         },
                            //         child: Row(
                            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //         children: <Widget>[
                            //             Row(
                            //                 children: <Widget>[
                            //                     Icon(
                            //                         IconData(0xe623, fontFamily: 'iconfont'),
                            //                         size: ScreenAdaper.fontSize(40),
                            //                         color: Color(0xff00a9e9),
                            //                     ),
                            //                     SizedBox(
                            //                         width: ScreenAdaper.width(20),
                            //                     ),
                            //                     Text(
                            //                     '支付宝支付',
                            //                     style: TextStyle(
                            //                         color: Color(0xff333333),
                            //                         fontSize: ScreenAdaper.fontSize(28)),
                            //                     )
                            //                 ],
                            //             ),
                            //             _payType == 'Alipay'
                            //                 ? CircleAvatar(
                            //                     backgroundColor: Color(0xffd4746c),
                            //                     radius: ScreenAdaper.width(20),
                            //                     child: Icon(
                            //                     IconData(0xe643, fontFamily: 'iconfont'),
                            //                     size: ScreenAdaper.fontSize(20),
                            //                     color: Color(0xffffffff),
                            //                     ),
                            //                 )
                            //                 : CircleAvatar(
                            //                     radius: ScreenAdaper.width(20),
                            //                     backgroundColor:Colors.white,
                            //                     child: Container(
                            //                         width: ScreenAdaper.width(40),
                            //                         height: ScreenAdaper.height(40),
                            //                         decoration: BoxDecoration(
                            //                             color: Color(0xfff7f7f7),
                            //                             border: Border.all(
                            //                                 color: Color(0xff999999),
                            //                                 width: ScreenAdaper.width(1)
                            //                             ),
                            //                             borderRadius: BorderRadius.all(
                            //                                 Radius.circular(40)))),
                            //                 )
                            //             ],
                            //         ),
                            //     )
                            //     ),
                            ),
                            Container(
                                padding: EdgeInsets.only(
                                    left: ScreenAdaper.width(30),
                                    top: ScreenAdaper.height(30)
                                ),
                                alignment: Alignment.centerLeft,
                                child: Text("仅限于到店付，请确认金额后付款", style: TextStyle(
                                    color: Color(0xFF666666),
                                    fontSize: ScreenAdaper.fontSize(28)
                                )),
                            )
                        ],
                        ),
                    )
                    ],
                ),
                ),
            ),
        );
    }
}
