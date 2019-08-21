import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';
class Accommodation extends StatefulWidget {
    Accommodation({Key key}) : super(key: key);
    _AccommodationState createState() => _AccommodationState();
}

class _AccommodationState extends State<Accommodation> {
    Widget _label () {
        return Container(
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(10),
                ScreenAdaper.height(5),
                ScreenAdaper.width(10),
                ScreenAdaper.height(5)
            ),
            decoration: BoxDecoration(
                border: Border.all(color: Color(0XFFdac4a3), width: 1.0),
                color: Color(0XFFf8f5e8)
            ),
            child: Text("10元优惠券", style: TextStyle(
                color: ColorClass.fontRed,
                fontSize: ScreenAdaper.fontSize(24)
            )),
        );
    }
    Widget _listItem (String name, String type, double price, String city) {
        return Container(
            margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: Container(
                padding: EdgeInsets.all(ScreenAdaper.width(30)),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                        Container(
                            width: ScreenAdaper.width(190),
                            height: ScreenAdaper.height(238),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(3)
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Image.network(
                                    "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                                    fit: BoxFit.cover,
                                ),
                            ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                                margin: EdgeInsets.only(left: ScreenAdaper.width(30)),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                                Text(name, style: TextStyle(
                                                    color: ColorClass.titleColor,
                                                    fontSize: ScreenAdaper.fontSize(30)
                                                )),
                                                SizedBox(width: ScreenAdaper.width(10)),
                                                Text(type, style: TextStyle(
                                                    color: ColorClass.titleColor,
                                                    fontSize: ScreenAdaper.fontSize(24)
                                                )),
                                                Expanded(
                                                    flex: 1,
                                                    child: Container(
                                                        alignment: Alignment.bottomRight,
                                                        child: Text("<500米", style: TextStyle(
                                                            color: ColorClass.fontColor,
                                                            fontSize: ScreenAdaper.fontSize(24)
                                                        )
                                                    ),
                                                ))
                                            ]
                                        ),
                                        SizedBox(height: ScreenAdaper.height(30)),
                                        Text(city, style: TextStyle(
                                            color: ColorClass.fontColor,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        ), overflow: TextOverflow.ellipsis),
                                        SizedBox(height: ScreenAdaper.height(20)),
                                        Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: <Widget>[
                                                Text("¥", style: TextStyle(
                                                    color: ColorClass.fontRed,
                                                    fontSize: ScreenAdaper.fontSize(26)
                                                )),
                                                Text(price.toString(), style: TextStyle(
                                                    color: ColorClass.fontRed,
                                                    fontSize: ScreenAdaper.fontSize(44)
                                                )),
                                                Text("起", style: TextStyle(
                                                    color: ColorClass.subTitleColor,
                                                    fontSize: ScreenAdaper.fontSize(24)
                                                ))
                                            ]
                                        ),
                                        SizedBox(height: ScreenAdaper.height(25)),
                                        Wrap(
                                            spacing: ScreenAdaper.width(10),
                                            runSpacing: ScreenAdaper.height(10),
                                            children: <Widget>[
                                                this._label(),
                                                this._label()
                                            ]
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
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Container(
            child: Scaffold(
                appBar: AppBar(
                    title: Text("神木住宿", style: TextStyle(
                        color: Colors.black,
                    )),
                    elevation: 1,
                    iconTheme: IconThemeData(color: Colors.black),
                    backgroundColor: Colors.white,
                    centerTitle: true,
                    brightness: Brightness.light,
                ),
                body: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                        return this._listItem(
                            "边屯酒家",
                            "豪华型",
                            188,
                            "贵州省黔西南布依族苗族自治州兴义市鲁"
                        );
                    },
                    itemCount: 10,
                )
            )
        );
    }
}