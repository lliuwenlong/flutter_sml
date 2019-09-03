import 'package:flutter/material.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';

class Payment extends StatefulWidget {
  Payment({Key key}) : super(key: key);

  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  String _payType = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('付款'),
      body: SafeArea(
        top: false,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            children: <Widget>[
              Container(
                // color: Colors.white,
                
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
                                bottom: BorderSide(
                                    color: Color(0xffd9d9d9), width: 1))),
                        child: Text(
                          '¥ 168',
                          style: TextStyle(
                              color: Color(0xff333333),
                              fontSize: ScreenAdaper.fontSize(60)),
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
                            Navigator.pushNamed(context, '/coupon');
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
                                      Text(
                                        '20元代金券',
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
                              Container(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    '- ¥ 18',
                                    style: TextStyle(
                                        fontSize: ScreenAdaper.fontSize(34),
                                        color: Color(0xfffb4135)),
                                  ))
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
                            Text(
                              '¥ 50',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: ScreenAdaper.fontSize(48)),
                            )
                          ],
                        )
						),
					),
                    Container(
						padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
						color: Colors.white,
                     child: Container(
						  height: ScreenAdaper.height(100),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffd9d9d9), width: 1))),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            this._payType = 'wx';
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
                            _payType == 'wx'
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
                      child: Container(
						  height: ScreenAdaper.height(100),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            this._payType = 'zfb';
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Icon(
                                  IconData(0xe623, fontFamily: 'iconfont'),
                                  size: ScreenAdaper.fontSize(40),
                                  color: Color(0xff00a9e9),
                                ),
                                SizedBox(
                                  width: ScreenAdaper.width(20),
                                ),
                                Text(
                                  '支付宝支付',
                                  style: TextStyle(
                                      color: Color(0xff333333),
                                      fontSize: ScreenAdaper.fontSize(28)),
                                )
                              ],
                            ),
                            _payType == 'zfb'
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
                                                Radius.circular(40)))),
                                  )
                          ],
                        ),
                      )
					  ),
                    )
                  ],
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  height: ScreenAdaper.height(110),
                  margin: EdgeInsets.only(
                      left: ScreenAdaper.width(30),
                      right: ScreenAdaper.width(30)),
                  padding: EdgeInsets.only(
                      top: ScreenAdaper.height(12),
                      bottom: ScreenAdaper.height(12)),
                  child: RaisedButton(
                    child: Text(
                      '付款',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenAdaper.fontSize(40)),
                    ),
                    disabledColor: Color(0XFF86d4ca), //禁用时的颜色
                    splashColor: Color.fromARGB(0, 0, 0, 0), //水波纹
                    highlightColor: Color(0xff009a8a),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5))),
                    color: Color(0XFF22b0a1), //默认颜色
                    onPressed: () {},
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
