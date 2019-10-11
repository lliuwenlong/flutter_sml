import 'package:flutter/material.dart';
import 'package:flutter_sml/common/Color.dart';
import '../../services/ScreenAdaper.dart';
class ServiceItem extends StatelessWidget {
    bool isShowBorder;
    String title;//标题
    String area;//面积
    String room;//容量
    String window;//窗户
    String bed;//床型
    String intnet;//宽带
    String bathroom;//卫浴
    String picture;//封面图
    String price;//价格

    ServiceItem({Key key, this.isShowBorder = true,this.title,this.area,this.room,this.window,this.bed,this.intnet,this.bathroom,this.picture,this.price});
    Widget _rowItem (String name,String desc) {
        return Row(
            children: <Widget>[
                Text(name, style: TextStyle(
                    color: ColorClass.fontColor,
                    fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true)
                )),
                SizedBox(width: ScreenAdaper.width(20)),
                Text(desc, style: TextStyle(
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
                                    this.picture,
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
                                                Text(this.title, style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(30, allowFontScaling: true),
                                                    color: ColorClass.fontColor
                                                )),
                                                Text("¥${this.price}", style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(30, allowFontScaling: true),
                                                    color: ColorClass.fontRed
                                                ))
                                            ],
                                        ),
                                        Row(
                                            children: <Widget>[
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem('面积',this.area),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem('可住',this.room),
                                                )
                                            ],
                                        ),
                                        Row(
                                            children: <Widget>[
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem('窗户',this.window),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem('床型',this.bed),
                                                )
                                            ],
                                        ),
                                        Row(
                                            children: <Widget>[
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem('宽带',this.intnet),
                                                ),
                                                Expanded(
                                                    flex: 1,
                                                    child: this._rowItem('卫浴',this.bathroom),
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