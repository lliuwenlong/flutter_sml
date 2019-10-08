import 'package:flutter/material.dart';
import 'package:flutter_sml/components/AppBarWidget.dart';
import 'package:flutter_sml/services/ScreenAdaper.dart';


class MerchantAlbum extends StatelessWidget {
    MerchantAlbum({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: PreferredSize(
                child: AppBarWidget().buildAppBar("商家相册"),
                preferredSize: Size.fromHeight(ScreenAdaper.height(110))
            ),
            body: GridView.builder(
                padding: EdgeInsets.all(ScreenAdaper.width(30)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    mainAxisSpacing: ScreenAdaper.width(20),
                    crossAxisSpacing: ScreenAdaper.width(20),
                ),
                itemBuilder: (BuildContext context, int index) {
                    return ClipRRect(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                        child: Image.network(
                            "http://imgcps.jd.com/ling/2349751/6YeR56eL576O5aaG5oqk6IKk6IqC/5LyB6YeH5LiT5Lqr54iG5qy-55u06ZmN/p-5bd8253082acdd181d02fa3b/b6104a8d.jpg",
                            fit: BoxFit.fill
                        )
                    );
                },
                itemCount: 20,
            ),
        );
    }
}