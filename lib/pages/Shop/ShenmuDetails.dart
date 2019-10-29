import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../model/api/shop/WoodApiModel.dart';
import '../../model/store/shop/Shop.dart';
import '../Shop/Purchase.dart';
import '../../common/HttpUtil.dart';
import '../../components/LoadingSm.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import '../../common/Config.dart';

class ShenmuDetails extends StatefulWidget {
    final Map arguments;
    ShenmuDetails({Key key, this.arguments}) : super(key: key);
    _ShenmuDetailsState createState() => _ShenmuDetailsState(arguments: this.arguments);
}

class _ShenmuDetailsState extends State<ShenmuDetails> {
    final Map arguments;
    _ShenmuDetailsState({this.arguments});
    List<Map> bannerList = [
        {
        "url": 'http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1411/14/c2/40920783_40920783_1415949861822_mthumb.jpg'
        },
        {"url": 'http://img.juimg.com/tuku/yulantu/110126/292-11012613321981.jpg'},
        {
        "url":
            'http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1411/14/c2/40920783_40920783_1415949861822_mthumb.jpg'
        },
        {"url": 'http://img.juimg.com/tuku/yulantu/110126/292-11012613321981.jpg'}
    ];
    Data data;
    bool isLoading = true;
    @override
    void initState() {
        super.initState();
        this._getData();
    }
    void _getData () async {
        final respones = await HttpUtil().get("/api/v1/wood/${arguments["id"]}");
        if (respones["code"] == 200) {
            final WoodApiModel res = new WoodApiModel.fromJson(respones);
            setState(() {
                this.data = res.data;
                this.isLoading = false;
            });
        }
    }

    BuildContext _selfContext;

    _purchase () {
        Provider.of<ShopModel>(context).setShopNum(1);
        showModalBottomSheet(
          context: this._selfContext,
          shape:  RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(ScreenAdaper.width(10)),
              topRight: Radius.circular(ScreenAdaper.width(10)),
            )
          ),
          builder: (BuildContext context) {
            return Purchase(
                id: this.data.woodId,
                price: double.parse(this.data.price),
                baseid: widget.arguments["baseid"],
                type: widget.arguments["type"])
            ;
          }
        );
	}

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        this._selfContext = context;
        return Scaffold(
            appBar: AppBarWidget().buildAppBar('神木详情'),
            body: ConstrainedBox(
            constraints: BoxConstraints.expand(),
            child: isLoading ? Loading() : Stack(
                alignment: Alignment.topLeft,
                children: <Widget>[
                Container(
                    child: InAppWebView(
                        initialUrl: "${Config.WEB_URL}/app/#/shopTreeDetail?sid=${arguments['id']}",
                    ),
                ),
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    height: ScreenAdaper.height(110),
                    child:Container(
                    width: double.infinity,
                    color: Colors.white,
                    height: ScreenAdaper.height(88),
                    padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30),top:ScreenAdaper.height(14),bottom: ScreenAdaper.height(14)),
                    child:  RaisedButton(
                        child: Text(
                            '购买',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenAdaper.fontSize(40)
                            )
                        ),
                        disabledColor: Color(0XFF86d4ca),
                        splashColor: Color.fromARGB(0, 0, 0, 0),
                        highlightColor: Color(0xff009a8a),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(5))
                        ),
                        color: Color(0XFF22b0a1),
                        onPressed: (){
                            this._purchase();
                        },
                    ),
                    ),
                )
                ],
            ),
            ));
    }
}
