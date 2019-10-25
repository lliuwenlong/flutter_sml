import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import '../common/Color.dart';
class CommonListItem extends StatelessWidget {
    final String url;
    final String name;
    final String label;
    final String city;
    final double price;
    final String distance;
    CommonListItem(
        this.url,
        this.name,
        this.label,
        this.city,
        this.price,
        this.distance, {Key key}
    ) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: Container(
                padding: EdgeInsets.all(ScreenAdaper.width(30)),
                decoration: BoxDecoration(
                    color: Colors.white,
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(190),
                            height: ScreenAdaper.width(190),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3)
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Image.network(
                                    this.url,
                                    fit: BoxFit.cover,
                                ),
                            ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                height: ScreenAdaper.width(170),
                                margin: EdgeInsets.only(left: ScreenAdaper.width(30)),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                        Stack(
                                            children: <Widget>[
                                                Text(this.name, style: TextStyle(
                                                    color: ColorClass.titleColor,
                                                    fontSize: ScreenAdaper.fontSize(30),
                                                    fontWeight: FontWeight.w600
                                                )),
                                                Align(
                                                    alignment: Alignment.centerRight,
                                                    child: Text("${this.distance}", style: TextStyle(
                                                        color: ColorClass.fontColor,
                                                        fontSize: ScreenAdaper.fontSize(24)
                                                    )),
                                                )
                                            ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                            children: <Widget>[
                                                Text("¥${this.price} ", style: TextStyle(
                                                    color: Color(0XFFfb4135),
                                                    fontSize: ScreenAdaper.fontSize(28)
                                                )),
                                                Text("/人", style: TextStyle(
                                                    color: ColorClass.subTitleColor,
                                                    fontSize: ScreenAdaper.fontSize(28)
                                                ))
                                            ],
                                        ),
                                        Text(this.label, style: TextStyle(
                                            color: ColorClass.common,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        )),
                                        Text(this.city, style: TextStyle(
                                            color: ColorClass.fontColor,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        ), overflow: TextOverflow.ellipsis)
                                    ],
                                ),
                            ),
                        )
                    ],
                )
            ),
        );
    }
}