import 'package:flutter/material.dart';
import 'package:flutter_sml/common/Color.dart';
import '../../services/ScreenAdaper.dart';
class ServiceItem extends StatelessWidget {
    bool isShowBorder;
    List listData = [];
    ServiceItem({Key key, this.isShowBorder = true});
    Widget _rowItem () {
        return Row(
            children: <Widget>[
                Text("面积", style: TextStyle(
                    color: ColorClass.fontColor,
                    fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true)
                )),
                SizedBox(width: ScreenAdaper.width(20)),
                Text("25㎡", style: TextStyle(
                    color: ColorClass.titleColor,
                    fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true)
                ))
            ]
        );
    }

    @override
    Widget build(BuildContext context) {
        return Container(
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
                        bottom: isShowBorder ? BorderSide(
                            color: Color(0XFFd9d9d9),
                            width: 1
                        ) : BorderSide.none
                    )
                ),
                child: Row(
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(150),
                            height: ScreenAdaper.height(176),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Image.network(
                                    "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                                    fit: BoxFit.cover,
                                ),
                            )
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
                                height: ScreenAdaper.height(177),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                                Text("高级大床房", style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(30, allowFontScaling: true),
                                                    color: ColorClass.fontColor
                                                )),
                                                Text("¥179", style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(30, allowFontScaling: true),
                                                    color: ColorClass.fontRed
                                                ))
                                            ],
                                        ),
                                        Row(
                                            children: <Widget>[
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem(),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem(),
                                                )
                                            ],
                                        ),
                                        Row(
                                            children: <Widget>[
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem(),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem(),
                                                )
                                            ],
                                        ),
                                        Row(
                                            children: <Widget>[
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem(),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem(),
                                                )
                                            ],
                                        )
                                    ]
                                )
                            )
                        )
                    ]
                )
            )
        );
    }
}