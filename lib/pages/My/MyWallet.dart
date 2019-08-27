import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
class MyWallet extends StatefulWidget {
  MyWallet({Key key}) : super(key: key);

  _MyWalletState createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('我的钱包'),
      body: Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: ScreenAdaper.height(50)),
              width: ScreenAdaper.width(180),
              height: ScreenAdaper.height(160),
              child: Image.asset(
                'images/money.png',
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdaper.height(62)),
              child: Text(
                '账户余额',
                style:TextStyle(
                  color: Color(0xff666666),
                  fontSize: ScreenAdaper.fontSize(28)
                )
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdaper.height(10)),
              child: Text(
                '¥ 5000.00',
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: ScreenAdaper.fontSize(60)
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: ScreenAdaper.height(80)),
              width: double.infinity,
              child: RaisedButton(
                  child: Text(
                    '提现',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenAdaper.fontSize(40)
                    ),
                  ),
                    disabledColor: Color(0XFF86d4ca),//禁用时的颜色
                    splashColor: Color.fromARGB(0, 0, 0, 0),//水波纹
                    highlightColor:Color(0xff009a8a),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    color: Color(0XFF22b0a1),//默认颜色
                    onPressed: (){
                      Navigator.pushNamed(context, '/cashOut');
                    },
                ),
            )
          ],
        ),
      ),
    );
  }
}