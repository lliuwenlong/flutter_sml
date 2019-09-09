import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../Shop/Purchase.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/shop/ShopModel.dart';
class ShopPage extends StatefulWidget {
    ShopPage({Key key}) : super(key: key);
    _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
	BuildContext _selfContext;
    int _page = 1;
    bool isLoading = false;
    List<Data> shopList = [];
    @override
    initState() {
        super.initState();
        this._getData();
    }
    _getData () async {
        Map<String, dynamic> response = await HttpUtil().post(
            "/api/v1/wood/shop/",
            data: {
                "pageNO": 1,
                "pageSize": 10
            }
        );
        if (response["code"] == 200) {
            final ShopModel shopModel =  new ShopModel.fromJson(response);
            setState(() {
                this.shopList = shopModel.data;
            });
        } else {

        }
        
    }

    _purchase () {
		showModalBottomSheet(
			context: this._selfContext,
			shape:  RoundedRectangleBorder(
				borderRadius: BorderRadius.only(
					topLeft: Radius.circular(ScreenAdaper.width(10)),
					topRight: Radius.circular(ScreenAdaper.width(10)),
				)
			),
			builder: (BuildContext context) {
				return Purchase();
			}
		);
	}

    Widget _commodityItem () {
        return Container(
            width: (ScreenAdaper.getScreenWidth() - 40 ) / 2,
            padding: EdgeInsets.only(bottom: ScreenAdaper.height(20)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5)
            ),
            child: Column(
                children: <Widget>[
                    Stack(
                        children: <Widget>[
                            GestureDetector(
                                onTap: () {
                                    Navigator.pushNamed(context, "/shenmuDetails");
                                },
                                child: AspectRatio(
                                    aspectRatio: 335 / 400,
                                    child: Container(
                                        width: double.infinity,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                                            child: Image.network(
                                                "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                                                fit: BoxFit.cover,
                                            )
                                        ),
                                    )
                                )
                            ),
                            Positioned(
                                top: ScreenAdaper.width(20),
                                left: ScreenAdaper.width(20),
                                child: Container(
                                    padding: EdgeInsets.fromLTRB(
                                        ScreenAdaper.width(36),
                                        ScreenAdaper.height(16),
                                        ScreenAdaper.width(36),
                                        ScreenAdaper.height(16)
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(0, 0, 0, 0.5),
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text("金丝榔", style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ScreenAdaper.fontSize(30)
                                    )),
                                ),
                            )
                        ],
                    ),
                    SizedBox(height: ScreenAdaper.height(20)),
                    Padding(
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdaper.width(20), 0, ScreenAdaper.width(20), 0
                        ),
                        child: Row(
                            children: <Widget>[
                                Icon(
                                    IconData(0xe61d, fontFamily: 'iconfont'),
                                    color: Color(0xFF22b0a1),
                                    size: ScreenAdaper.fontSize(30)
                                ),
                                SizedBox(width: ScreenAdaper.width(20)),
                                Text("神木基地名称", style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true),
                                    color: Color(0xFF666666)
                                ))
                            ],
                        )
                    ),
                    SizedBox(height: ScreenAdaper.height(15)),
                    Padding(
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdaper.width(20), 0, ScreenAdaper.width(20), 0
                        ),
                        child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                                Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text("¥1000.00", style: TextStyle(
                                        color: Color(0xFFfb4135),
                                        fontSize: ScreenAdaper.fontSize(26)
                                    )),
                                ),
                                Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                        alignment: Alignment.centerRight,
                                        child: MaterialButton(
                                            padding: EdgeInsets.all(0),
                                            height: ScreenAdaper.height(50),
                                            minWidth: ScreenAdaper.width(141),
                                            onPressed: () {
												this._purchase();
											},
                                            color: Color(0xFF22b0a1),
                                            splashColor: Color.fromRGBO(0, 0, 0, 0),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(ScreenAdaper.width(10)))
                                            ),
                                            child: Text("立即购买", style: TextStyle(
                                                fontSize: ScreenAdaper.fontSize(20),
                                                color: Color(0xFFffffff)
                                            )),
                                        ),
                                    ),
                                )
                            ],
                        ),
                    )
                ],
            ),
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
		this._selfContext = context;
        return Scaffold(
            appBar: PreferredSize(
                child: AppBarWidget().buildAppBar("商城"),
                preferredSize: Size.fromHeight(ScreenAdaper.height(110))
            ),
            body: SingleChildScrollView(
                child: Container(
                    padding: EdgeInsets.all(15),
                    child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: this.shopList.map((Data val) {
                            return this._commodityItem();
                        }).toList(),
                    )
                )
            )
        );
    }
}