import 'package:flutter/material.dart';
import 'package:flutter_sml/components/AppBarWidget.dart';
import 'package:flutter_sml/services/ScreenAdaper.dart';

class MerchantAlbum extends StatefulWidget {
  final arguments;
  MerchantAlbum({Key key,this.arguments}) : super(key: key);

  _MerchantAlbumState createState() => _MerchantAlbumState(arguments:arguments);
}

class _MerchantAlbumState extends State<MerchantAlbum> {
  final arguments;
  _MerchantAlbumState({this.arguments});
  List list = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    this.list = arguments['imgList'];
  }
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
                           this.list[index],
                            fit: BoxFit.fill
                        )
                    );
                },
                itemCount: this.list.length,
            ),
        );
    }
}



