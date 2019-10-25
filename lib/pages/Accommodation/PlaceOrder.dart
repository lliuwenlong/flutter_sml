import 'package:flutter/material.dart';
import 'package:flutter_sml/components/calendarPage/calendar_page_viewModel.dart';
import 'package:flutter_sml/components/calendarPage/toast_widget.dart';
import 'package:flutter_sml/model/store/user/User.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import 'package:intl/intl.dart';
import 'dart:ui';

class PlaceOrder extends StatefulWidget {
    String title;
    DayModel startTime;
    DayModel endTime;
    String price;
    int goodId;
    int firmId;
    int dayNum;
    PlaceOrder({Key key, this.title, this.startTime, this.endTime, this.price, this.goodId, this.firmId,this.dayNum, Map arguments}) : super(key: key);
    _PlaceOrderState createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
    _PlaceOrderState({Key key});
    TextEditingController usernameContainer = TextEditingController.fromValue(
        TextEditingValue(
            text: ""
        )
    );
    TextEditingController telContainer = TextEditingController.fromValue(
        TextEditingValue(
            text: ""
        )
    );
    User _userModel;
    HttpUtil http = HttpUtil();
    Map chooseCouponParams = {};
    int couponLength = 0;
    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
        _userModel = Provider.of<User>(context);
        _getCoupon();
    }

    submitData () async {
    
        if (this.usernameContainer.text.isEmpty) {
            ShowToast().showToast('入住人姓名不可为空');
            return;
        }
        if (this.telContainer.text.isEmpty) {
            ShowToast().showToast('入住联系手机不可为空');
            return;
        }
        RegExp exp = RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$');
        if (!exp.hasMatch(this.telContainer.text)) {
            ShowToast().showToast('手机号格式不正确');
            return;
        }
        DateFormat formatter = new DateFormat('yyyy-MM-dd');
        print(widget.startTime.day);
        DateTime startTime = DateTime(widget.startTime.year, widget.startTime.month, widget.startTime.dayNum);
        DateTime endTime = DateTime(widget.endTime.year, widget.endTime.month, int.parse(widget.endTime.day));
        Map res = await http.post("/api/v1/house/order", params: {
            "firmId": widget.firmId,
            "goodsId": widget.goodId,
            "incomeDate": formatter.format(startTime),
            "phone": this.telContainer.text,
            "quitDate": formatter.format(endTime),
            "realName": this.usernameContainer.text,
            "userId": _userModel.userId
        });
        if (res["code"] == 200) {
            FocusScope.of(context).requestFocus(FocusNode());
            Navigator.pushNamed(context, "/order");
        } else {
            ShowToast().showToast(res["msg"]);
        }
    }
    _getCoupon () async{
        Map response = await this.http.get('/api/v1/coupon/user',data: {
          'firmId': widget.firmId,
          'userId': this._userModel.userId
        });
        if (response['code'] == 200) {
          setState(() {
              this.couponLength =response['data'].length;
          });
        }

        print(couponLength);
    }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: PreferredSize(
                child: AppBarWidget().buildAppBar("订单确认"),
                preferredSize: Size.fromHeight(ScreenAdaper.height(88))
            ),
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
                                          chooseCouponParams['worth']!=null&&int.parse(chooseCouponParams['worth']) > 0?TextSpan(
                                                text: '${double.parse(widget.price)*widget.dayNum -int.parse(chooseCouponParams['worth'])}',
                                                style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(44)
                                                )
                                            ):TextSpan(
                                                text: '${chooseCouponParams['worth']=='0'?0:double.parse(widget.price)*widget.dayNum}',
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
                                    onPressed: this.submitData,
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
                                    Text("${widget.title}", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(34),
                                        fontWeight: FontWeight.w500
                                    )),
                                    SizedBox(height: ScreenAdaper.width(20)),
                                    Container(
                                        child: Row(
                                            children: <Widget>[
                                                Text("${widget.startTime.month}月${widget.startTime.dayNum}日", style: TextStyle(
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
                                                Text("${widget.endTime.month}月${widget.endTime.day}日", style: TextStyle(
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
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                                controller: usernameContainer,
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
                                                controller: telContainer,
                                                keyboardType: TextInputType.phone,
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
                        ),
                        GestureDetector(
                            onTap: () {
                                Navigator.pushNamed(context, '/chooseCoupon',arguments: {
                                    "firmId": widget.firmId,
                                    "type": 3,
                                    "orderSn": null,
                                    "amount": widget.price,
                                    "couponId": this.chooseCouponParams["couponId"] == null ? 0 : this.chooseCouponParams["couponId"],
                                    'worth': 0
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
                            child: Container(
                            padding: EdgeInsets.all(ScreenAdaper.width(30)),
                            margin: EdgeInsets.only(
                                top: ScreenAdaper.height(30)
                            ),
                            color: Colors.white,
                            child: Row(
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
                                                  chooseCouponParams['worth']==null?Container(
                                                    child: couponLength>0?Text(
                                                        '$couponLength张可用',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "SourceHanSansCN-Medium",
                                                            fontSize: ScreenAdaper.fontSize(28),
                                                            color: Color(0xff999999)),
                                                    ):Text(
                                                        '暂无可用优惠券',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "SourceHanSansCN-Medium",
                                                            fontSize: ScreenAdaper.fontSize(28),
                                                            color: Color(0xff999999)),
                                                    ),
                                                  ):Container(
                                                    child: 
                                                    int.parse(chooseCouponParams['worth'])>0?
                                                    Text(
                                                        '- ${chooseCouponParams['worth']}元',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "SourceHanSansCN-Medium",
                                                            fontSize: ScreenAdaper.fontSize(28),
                                                            color: Colors.red),
                                                    ):Text(
                                                        '抵用券',
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "SourceHanSansCN-Medium",
                                                            fontSize: ScreenAdaper.fontSize(28),
                                                            color: Colors.red),
                                                    ),
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
                                    )
                        ),
                        )
                        
                    ]
                )
            )
        );
    }
}