import 'package:flutter/material.dart';
import 'package:flutter_sml/components/calendarPage/calendar_page_viewModel.dart';
import 'package:flutter_sml/model/api/restaurant/FoodFirmApiModel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../services/ScreenAdaper.dart';
import '../../../common/Color.dart';
import 'dart:ui';
class Reserve extends StatelessWidget {
    BuildContext _selfContext;
     String title;//标题
    String area;//面积
    String room;//容量
    String windows;//窗户
    String bed;//床型
    String intnet;//宽带
    String bathroom;//卫浴
    String picture;//封面图
    String price;//价格
    int dayNum;
    DayModel startTime;
    DayModel endTime;
    Function placeOrder;
    FoodFirmApiModel firm;
    Reserve({Key key,this.title,this.area,this.room,this.windows,this.bed,this.intnet,this.bathroom,this.picture,this.price, this.dayNum,  this.placeOrder, this.firm});

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
                        )
                    )
                ]
            )
        );
    }

    Widget _rowItem (String name, String value) {
        return Row(
            children: <Widget>[
                Text(name, style: TextStyle(
                    color: ColorClass.fontColor,
                    fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true)
                )),
                SizedBox(width: ScreenAdaper.width(20)),
                Text(value, style: TextStyle(
                    color: ColorClass.titleColor,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true)
                ))
            ]
        );
    }

    Widget _banner () {
        return Column(
            children: <Widget>[
              Stack(
                    children: <Widget>[
                      
                        AspectRatio(
                            aspectRatio: 750 / 300,
                            child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                height: ScreenAdaper.height(300),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          this.picture,
                                        ),
                                        fit: BoxFit.cover)));
                          },
                          itemCount:1,
                          control: new SwiperPagination(
                            builder: FractionPaginationBuilder(
                              color: Colors.white,
                              activeColor: Colors.white,
                              fontSize: ScreenAdaper.fontSize(30),
                              activeFontSize: ScreenAdaper.fontSize(40),
                            ),
                            margin: EdgeInsets.only(
                                bottom: ScreenAdaper.height(30),
                                right: ScreenAdaper.width(30)),
                            alignment: Alignment.bottomRight,
                          ),
                        )
                            
                        ),
                        // Positioned(
                        //     bottom: ScreenAdaper.width(30),
                        //     right: ScreenAdaper.width(30),
                        //     child: Container(
                        //         padding: EdgeInsets.fromLTRB(
                        //             ScreenAdaper.width(25),
                        //             ScreenAdaper.height(5),
                        //             ScreenAdaper.width(25),
                        //             ScreenAdaper.height(5)
                        //         ),
                        //         decoration: BoxDecoration(
                        //             borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                        //             color: Color.fromRGBO(0, 0, 0, 0.7)
                        //         ),
                        //         child: Text("1/1", style: TextStyle(
                        //             color: Colors.white,
                        //             fontSize: ScreenAdaper.fontSize(30)
                        //         )),
                        //     ),
                        // )
                    ],
                ),
                Container(
                    margin: EdgeInsets.only(
                        top: ScreenAdaper.height(25)
                    ),
                    padding: EdgeInsets.only(
                        left: ScreenAdaper.width(30),
                        right: ScreenAdaper.width(30)
                    ),
                    child: Column(
                        children: <Widget>[
                            Row(
                                children: <Widget>[
                                    Expanded(
                                        child: this._rowItem("面积", this.area)
                                    ),
                                    Expanded(
                                        child: this._rowItem("可住", this.room)
                                    )
                                ],
                            ),
                            SizedBox(height: ScreenAdaper.height(25)),
                            Row(
                                children: <Widget>[
                                    Expanded(
                                        child: this._rowItem("窗户", this.windows)
                                    ),
                                    Expanded(
                                        child: this._rowItem("床型",this.bed)
                                    )
                                ],
                            ),
                            SizedBox(height: ScreenAdaper.height(25)),
                            Row(
                                children: <Widget>[
                                    Expanded(
                                        child: this._rowItem("宽带", this.intnet)
                                    ),
                                    Expanded(
                                        child: this._rowItem("卫浴", this.bathroom)
                                    )
                                ],
                            )
                        ]
                    )
                )
            ]
        );
    }
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        this._selfContext = context;
        return Container(
            padding: EdgeInsets.only(
                bottom: MediaQueryData.fromWindow(window).padding.bottom
            ),
            child: Wrap(
                children: <Widget>[
                    _header(this.title),
                    _banner(),
                    Container(
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(65)
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 1)
                            ]
                        ),
                        child: Row(
                            children: <Widget>[
                                Expanded(
                                    flex: 1,
                                    child:Container(
                                        // height: ScreenAdaper.height(110),
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
                                                    text: '${double.parse(this.price)*this.dayNum}',
                                                    style: TextStyle(
                                                        fontSize: ScreenAdaper.fontSize(44)
                                                    )
                                                )
                                            ]
                                        )),
                                    ),
                                ),
                                Container(
                                    width: ScreenAdaper.width(480),
                                    color: ColorClass.common,
                                    child: RaisedButton(
                                        padding: EdgeInsets.only(
                                            top: ScreenAdaper.height(30),
                                            bottom: ScreenAdaper.height(30)
                                        ),
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero
                                        ),
                                        onPressed: () {
                                            this.placeOrder != null && this.placeOrder();
                                        },
                                        color: ColorClass.common,
                                        child: Text("在线预订，商家确认后付款", style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenAdaper.fontSize(34)
                                        ))
                                    ),
                                )
                                
                            ]
                        ),
                    )
                ]
            )
        );
    }
}