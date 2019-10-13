import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../components/AppBarWidget.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/HttpUtil.dart';
import '../../model/store/user/User.dart';
class Payment extends StatefulWidget {
  final arguments;
  Payment({Key key,this.arguments}) : super(key: key);

  _PaymentState createState() => _PaymentState(arguments:this.arguments);
}

class _PaymentState extends State<Payment> {
  final arguments;
  _PaymentState({this.arguments});
  	String _payType = 'Wechat';
  	static String _inputText = '';
	TextEditingController _moneyController = TextEditingController.fromValue(
      	TextEditingValue(
        	text: _inputText,
    	)
  	);
	final HttpUtil http = HttpUtil();
 	User _userModel;
	List couponList = [];
	@override
	void didChangeDependencies() {
		super.didChangeDependencies();
		_userModel = Provider.of<User>(context);
		_getData();
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('付款'),
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
									bottom: BorderSide(
										color: Color(0xffd9d9d9), width: 1))),
							child: 
							arguments['type']=='house'?
							Text(
								'¥ ${arguments['amount']}',
								style: TextStyle(
									color: Color(0xff333333),
									fontSize: ScreenAdaper.fontSize(60)),
							):Container(
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
													hintText: '请输入金额',
													hintStyle: TextStyle(
														color: Color(0xff666666),
														fontSize: ScreenAdaper.fontSize(30),
													),
													border: InputBorder.none,
													contentPadding: EdgeInsets.fromLTRB(0, 0, 0, _inputText==''?4:0)
												),
												style: TextStyle(
													color: Color(0xff333333),
													fontSize: ScreenAdaper.fontSize(50),
												),
												controller: _moneyController,
												keyboardType: TextInputType.number,
												inputFormatters: <TextInputFormatter>[
													WhitelistingTextInputFormatter.digitsOnly,
													// LengthLimitingTextInputFormatter(6)
												],
												onChanged: (val){
													setState(() {
													_inputText = val;
													});
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
									Navigator.of(context).pushReplacementNamed( '/chooseCoupon',arguments: {
										'firmId':arguments['firmId'],
										'type':arguments['type'],
										'orderSn':arguments['orderSn'],
										'amount':arguments['amount'],
										'couponId':arguments['couponId']!=null?arguments['couponId']:0
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
										arguments['worth'] ==null?Container(
											child: this.couponList.length > 0 ? Text(
												'${this.couponList.length}张可用',
												style: TextStyle(
													fontFamily:
														"SourceHanSansCN-Medium",
													fontSize: ScreenAdaper.fontSize(28),
													color: Color(0xff999999)
												),
											):Text(
												'暂无可用优惠券',
												style: TextStyle(
													fontFamily:
														"SourceHanSansCN-Medium",
													fontSize: ScreenAdaper.fontSize(28),
													color: Color(0xff999999)),
											),
										):Text(
											'${arguments['worth']}元代金券',
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
								arguments['worth']!=null?Container(
									alignment: Alignment.bottomRight,
									child: Text(
										'- ¥ ${arguments['worth']}',
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
									child:arguments['worth']==null? Text(
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
									child:arguments['worth']==null?
										Text(
											'¥ $_inputText',
											style: TextStyle(
												color: Color(0xff333333),
												fontSize: ScreenAdaper.fontSize(48)),
										):Text(
											'¥ ${double.parse(_inputText)-double.parse(arguments['worth'])}',
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
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffd9d9d9), width: 1))),
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
                      child: Container(
						  height: ScreenAdaper.height(100),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            this._payType = 'Alipay';
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
                            _payType == 'Alipay'
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
                    onPressed: () {
						setState(() {
						  _inputText = '';
						  _moneyController.text = '';
						});
					},
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
