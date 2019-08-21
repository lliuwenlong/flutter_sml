import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
class BaseList extends StatelessWidget {
    const BaseList({Key key}) : super(key: key);
    Widget _itemWidget () {
        return Container(
            child: Stack(
                children: <Widget>[
                    ClipRRect(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                        child: Image.network(
                            "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                            fit: BoxFit.cover,
                        )
                    ),
                    Positioned(
                        top: ScreenAdaper.width(20),
                        left: ScreenAdaper.width(20),
                        child: Container(
                            padding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(36),
                                ScreenAdaper.height(15),
                                ScreenAdaper.width(36),
                                ScreenAdaper.height(15)
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                            ),
                            child: Text("金丝楠", style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenAdaper.fontSize(30, allowFontScaling: true)
                            )),
                        )
                    )
                ]
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("神木列表", style: TextStyle(
                    color: Colors.black,
                )),
                elevation: 1,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                centerTitle: true,
                brightness: Brightness.light
            ),
            body: Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdaper.width(30), 0, ScreenAdaper.width(30), 0
                ),
                child: GridView.builder(
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: ScreenAdaper.width(10),
                        mainAxisSpacing: ScreenAdaper.width(20),
                        childAspectRatio: 0.8375
                    ),
                    itemBuilder: (BuildContext context, int index) {
                        return this._itemWidget();
                    }
                )
            )
        );
    }
}