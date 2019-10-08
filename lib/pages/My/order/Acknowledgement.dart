import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter_sml/common/Color.dart';
import '../../../components/AppBarWidget.dart';
import '../../../services/ScreenAdaper.dart';
import '../../../common/HttpUtil.dart';
import '../../../components/LoadingSm.dart';
class Acknowledgement extends StatefulWidget {
  final arguments;
  Acknowledgement({Key key,this.arguments}) : super(key: key);

  _AcknowledgementState createState() => _AcknowledgementState(arguments:this.arguments);
}

class _AcknowledgementState extends State<Acknowledgement> {
  final arguments;
  _AcknowledgementState({this.arguments});
  final HttpUtil http = HttpUtil();
  var data;
  bool _isLoading = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // print(arguments['orderSn']);
    _getData();
  }
  _getData() async {
    Map response = await this
        .http
        .get('/api/v1/order/one', data: {'orderSn': arguments['orderSn']});

    // print(response);
    if (response['code'] == 200) {
      setState(() {
        this.data = response['data'];
        this._isLoading = false;
      });
    }
  }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return _isLoading?
        Scaffold(
            appBar: AppBarWidget().buildAppBar("我的订单"),
            body: Container(
              margin: EdgeInsets.only(top: ScreenAdaper.height(200)),
              child: Loading(),
            ),
          )
        : 
        
         Scaffold(
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
                        BoxShadow(color: Colors.grey[300],offset: Offset(1, 1)),
                        BoxShadow(color: Colors.grey[300], offset: Offset(-1, -1), blurRadius: 2),
                        BoxShadow(color: Colors.grey[300], offset: Offset(1, -1), blurRadius: 2),
                        BoxShadow(color: Colors.grey[300], offset: Offset(-1, 1), blurRadius: 2)
                    ]
                ),
                child: Row(
                    children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: ScreenAdaper.height(110),
                                alignment: Alignment.center,
                                child: Text.rich(
                                    new TextSpan(
                                        style: TextStyle(
                                            color: Color(0xFFfb4135)
                                        ),
                                        children: <TextSpan> [
                                            new TextSpan(
                                                text: '¥',
                                                style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(26)
                                                )
                                            ),
                                            new TextSpan(
                                                text: data['amount'],
                                                style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(46)
                                                )
                                            )
                                        ]
                                    )
                                ),
                            ),
                        ),
                        Container(
                            width: ScreenAdaper.width(480),
                            height: ScreenAdaper.height(110),
                            child: RaisedButton(
                                elevation: 0,
                                color: ColorClass.common,
                                onPressed: () {
                                  Navigator.pushNamed(context, '/payment',arguments: {
                                    'amount':data['amount']
                                  });
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0)
                                ),
                                child: Text("付款", style: TextStyle(
                                    color: Colors.white,
                                    fontSize: ScreenAdaper.fontSize(34)
                                )),
                            ),
                        )
                    ]
                )
            ),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    Container(
                        padding: EdgeInsets.all(ScreenAdaper.width(30)),
                        width: double.infinity,
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Text("标准大床房", style: TextStyle(
                                    color: ColorClass.titleColor,
                                    fontSize: ScreenAdaper.fontSize(32),
                                    fontWeight: FontWeight.w500
                                )),
                                SizedBox(height: ScreenAdaper.height(30)),
                                Text("${data['createTime'].substring(0,11)} 入驻  —— ${data['houseDetail']['quiteTime'].substring(0,11)} 离店" , style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(28)
                                ))
                            ]
                        )
                    ),
                    Container(
                        padding: EdgeInsets.all(ScreenAdaper.width(30)),
                        margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                        color: Colors.white,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Row(
                                    children: <Widget>[
                                        Container(
                                            width: ScreenAdaper.width(195),
                                            child: Text("入住人", style: TextStyle(
                                                color: ColorClass.titleColor,
                                                fontSize: ScreenAdaper.fontSize(28)
                                            ))
                                        ),
                                        Text(data['houseDetail']['realName'], style: TextStyle(
                                            color: ColorClass.fontColor,
                                            fontSize: ScreenAdaper.fontSize(28)
                                        ))
                                    ]
                                ),
                                Row(
                                    children: <Widget>[
                                        Container(
                                            width: ScreenAdaper.width(195),
                                            child: Text("联系手机", style: TextStyle(
                                                color: ColorClass.titleColor,
                                                fontSize: ScreenAdaper.fontSize(28)
                                            )),
                                        ),
                                        SizedBox(height: ScreenAdaper.height(30)),
                                        Text(data['houseDetail']['phone'], style: TextStyle(
                                            color: ColorClass.fontColor,
                                            fontSize: ScreenAdaper.fontSize(28)
                                        ))
                                    ]
                                )
                            ]
                        )
                    ),
                    Container(
                        padding: EdgeInsets.all(ScreenAdaper.width(30)),
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(20)
                        ),
                        color: Colors.white,
                        child: Row(
                            children: <Widget>[
                                Container(
                                    width: ScreenAdaper.width(195),
                                    child: Text("发票", style: TextStyle(
                                        color: ColorClass.titleColor,
                                        fontSize: ScreenAdaper.fontSize(28)
                                    )),
                                ),
                                Text("如需发票，请向酒店前台索取", style: TextStyle(
                                    color: ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(28)
                                ))
                            ]
                        )
                    )
                ]
            )
        );
    }
}