import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';

class Business extends StatelessWidget {
    String name = "";
    bool isBorder = true;
    bool isIcon = false;
    String subTitle;
    Icon icon;
    Color color;
    Business(this.name, {this.isBorder = true, this.isIcon = false, this.subTitle = '', this.icon, this.color, Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Container(
            color: Colors.white,
            padding: EdgeInsets.only(
                left: ScreenAdaper.width(30),
                right: ScreenAdaper.width(30)
            ),
            child: Container(
                padding: EdgeInsets.only(
                    top: ScreenAdaper.height(30),
                    bottom: ScreenAdaper.height(30)
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: this.isBorder ? BorderSide(
                            color: Color(0XFFd9d9d9),
                            width: ScreenAdaper.height(1)
                        ) : BorderSide.none
                    )
                    
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Text(name == null ? "" : name, style: TextStyle(
                            color: ColorClass.titleColor,
                            fontSize: ScreenAdaper.fontSize(28)
                        )),
                        SizedBox(width: ScreenAdaper.width(100)),
                        Expanded(
                            flex: 1,
                            child: Container(
                                alignment: Alignment.centerRight,
                                child: !isIcon ? Text(subTitle == null ? "" : this.subTitle, style: TextStyle(
                                    color: color != null ? color : ColorClass.fontColor,
                                    fontSize: ScreenAdaper.fontSize(24)
                                ), textAlign: TextAlign.end) : icon,
                            ),
                        )
                    ],
                )
            ),
        );
    }
}