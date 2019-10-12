import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
import '../../components/AppBarWidget.dart';
class ChooseCoupon extends StatefulWidget {
  final arguments;
    ChooseCoupon({Key key,this.arguments}) : super(key: key);
    _ChooseCouponState createState() => _ChooseCouponState(arguments:this.arguments);
}

class _ChooseCouponState extends State<ChooseCoupon> with SingleTickerProviderStateMixin {
    final arguments;
    _ChooseCouponState({this.arguments});

    @override
    void didChangeDependencies() {
        super.didChangeDependencies();
    }

    Widget _cardItem () {
        return Container(
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(25),
                0,
                ScreenAdaper.width(25),
                0
            ),
            margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: GestureDetector(
              onTap: (){
                print('object');
              },
              child: Card(
                child: Column(
                    children: <Widget>[
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(35),
                                ScreenAdaper.height(30),
                                ScreenAdaper.width(35),
                                ScreenAdaper.height(8)
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                    Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text('人间有味', style: TextStyle(
                                                fontSize: ScreenAdaper.fontSize(28)
                                            )),
                                            SizedBox(height: ScreenAdaper.height(15)),
                                            Text("有效期至：2019-09-15", style: TextStyle(
                                                fontSize: ScreenAdaper.fontSize(24),
                                                color: Color(0xff999999)
                                            ))
                                        ],
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: Container(
                                            height: ScreenAdaper.height(80),
                                            child: Stack(
                                                children: <Widget>[
                                                    Align(
                                                        alignment: Alignment.bottomRight,
                                                        child: Text("¥ 20", style: TextStyle(
                                                            fontSize: ScreenAdaper.fontSize(44),
                                                            color: Color(0xfffb4135),
                                                        )),
                                                    )
                                                ]
                                            ),
                                        ),
                                    )
                                ]
                            )
                        ),
                        Container(
                            padding: EdgeInsets.only(
                                left: ScreenAdaper.width(35),
                                right: ScreenAdaper.width(35)
                            ),
                            child: Divider(
                                color: Color(0XFFd9d9d9),
                            )
                        ),
                        Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(35),
                                ScreenAdaper.height(0),
                                ScreenAdaper.width(35),
                                ScreenAdaper.height(20)
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                   Text("平台赠送", style: TextStyle(
                                        fontSize: ScreenAdaper.fontSize(28)
                                    )),
                                    Container(
                                            width: ScreenAdaper.width(136),
                                            height: ScreenAdaper.height(50),
                                    ),
                                ]
                            )
                        )
                    ]
                )
            ),
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBarWidget().buildAppBar('选择优惠券'),
            body: SafeArea(
              bottom: true,
              child: ListView.builder(
                itemBuilder: (BuildContext context,int index){
                    return _cardItem();
                },
                itemCount: 4,
              ),
            )
        );
    }
}