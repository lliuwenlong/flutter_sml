import 'package:flutter/material.dart';
import 'package:flutter_sml/common/Color.dart';
import '../../services/ScreenAdaper.dart';
class FoodServiceItem extends StatelessWidget {
    bool isShowBorder;
    List listData = [];
    String name;
    String picture;
    String title;
    String price;
    FoodServiceItem(this.name, this.picture, this.title, this.price, {Key key, this.isShowBorder = true});
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
            color: Colors.white,
            child: Container(
                padding: EdgeInsets.only(
                    top: ScreenAdaper.width(30),
                    bottom: ScreenAdaper.width(30)
                ),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: isShowBorder ? BorderSide(
                            color: Color(0XFFd9d9d9),
                            width: 0.5
                        ) : BorderSide.none
                    )
                ),
                child: Row(
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.height(150),
                            height: ScreenAdaper.height(150),
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
                                height: ScreenAdaper.height(150),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Text(this.name, style: TextStyle(
                                            color: Color(0xFF333333),
                                            fontSize: ScreenAdaper.fontSize(28),
                                            fontWeight: FontWeight.w500
                                        )),
                                        Text(this.title, style: TextStyle(
                                            color: Color(0xFF666666),
                                            fontSize: ScreenAdaper.fontSize(24)
                                        ), overflow: TextOverflow.ellipsis, maxLines: 2,),
                                        Text(this.price, style: TextStyle(
                                            color: Color(0xFFfb4135),
                                            fontSize: ScreenAdaper.fontSize(30)
                                        ))
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