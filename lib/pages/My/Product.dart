import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/Label.dart';
import '../../common/Color.dart';
class Product extends StatefulWidget {
  final Map arguments;
    Product({Key key,this.arguments}) : super(key: key);

    _ProductState createState() => _ProductState(arguments:this.arguments);
}

class _ProductState extends State<Product> with SingleTickerProviderStateMixin{
  final Map arguments;
  int _currentIndex;
  _ProductState({this.arguments});
    TabController _tabController;
    void initState () {
        super.initState();
        _currentIndex =arguments==null?0:arguments.isNotEmpty? arguments['index']:0;
        _tabController = new TabController(
            vsync: this,
            length: 2,
            initialIndex: _currentIndex
        );
    }
    Widget _item ({bool isTransfer = true}) {
        return GestureDetector(
          onTap: (){
            if(this._currentIndex==1 || !isTransfer){
              return;
            }
            Navigator.pushNamed(context, '/productDetail',arguments: {
              "id":1
            });
          },
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
                Container(
                    width: ScreenAdaper.width(335),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                        color: Colors.white
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            Stack(
                                children: <Widget>[
                                    AspectRatio(
                                        aspectRatio: 336 / 420,
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(ScreenAdaper.width(10)),
                                                topRight: Radius.circular(ScreenAdaper.width(10))
                                            ),
                                            child: Image.network(
                                                "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                                                fit: BoxFit.cover,
                                            ),
                                        ),
                                    ),
                                    Positioned(
                                        top: ScreenAdaper.width(20),
                                        left: ScreenAdaper.width(20),
                                        child: Label("金丝楠"),
                                    )
                                ],
                            ),
                            Padding(
                                padding: EdgeInsets.fromLTRB(
                                    ScreenAdaper.width(20),
                                    ScreenAdaper.width(20),
                                    ScreenAdaper.width(20),
                                    ScreenAdaper.width(30),
                                ),
                                child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Row(
                                            children: <Widget>[
                                                Icon(
                                                    IconData(0xe61d, fontFamily: 'iconfont'), color: Color(0xFF22b0a1),
                                                    size: ScreenAdaper.fontSize(30),
                                                ),
                                                SizedBox(width: ScreenAdaper.width(20)),
                                                Expanded(
                                                    flex: 1,
                                                    child: Text(
                                                        "生态园林 . 学子林",
                                                        overflow: TextOverflow.ellipsis,
                                                        style: TextStyle(
                                                            color: ColorClass.fontColor,
                                                            fontSize: ScreenAdaper.fontSize(24)
                                                        )
                                                    ),
                                                )
                                            ]
                                        ),
                                        SizedBox(height: ScreenAdaper.height(15)),
                                        Text("编号：001", style: TextStyle(
                                            color: ColorClass.subTitleColor,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        )),
                                        SizedBox(height: ScreenAdaper.height(10)),
                                        Text("有效期：300天", style: TextStyle(
                                            color: ColorClass.subTitleColor,
                                            fontSize: ScreenAdaper.fontSize(24)
                                        ))
                                    ],
                                    
                                )
                            )
                        ]
                    )
                ),
                Positioned(
                    top: 0,
                    bottom: 0,
                    width: ScreenAdaper.width(335),
                    child: Offstage(
                        offstage: isTransfer,
                        child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                color: Color.fromRGBO(
                                    0, 0, 0, 0.7
                                )
                            )
                        )
                    ),
                ),
                Offstage(
                    offstage: isTransfer,
                    child: Container(
                        width: ScreenAdaper.width(217),
                        height: ScreenAdaper.height(160),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/itransfer.png"),
                                fit: BoxFit.fitWidth
                            )
                        ),
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(124)
                        ),
                    ),
                )
            ]
        ),
        );
    }
void onTap(value){
  this._currentIndex = value;
}
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: AppBar(
                title: Text("我的神木", style: TextStyle(
                    color: Colors.black,
                    fontSize: ScreenAdaper.fontSize(32)
                )),
                elevation: 1,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Colors.white,
                centerTitle: true,
                brightness: Brightness.light,
                actions: [
                    GestureDetector(
                        onTap: () {
                            Navigator.pushNamed(context, "/purchaseRecord");
                        },
                        child: Container(
                            margin: EdgeInsets.only(right: ScreenAdaper.width(30)),
                            alignment: Alignment.center,
                            child: Text("购买记录", style: TextStyle(
                                color: ColorClass.fontColor,
                                fontSize: ScreenAdaper.fontSize(32)
                            ), textAlign: TextAlign.center)
                        )
                    )
                ],
                bottom: TabBar(
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: ScreenAdaper.height(6),
                    indicatorColor: Color(0XFF22b0a1),
                    controller: this._tabController,
                    onTap: (value){
                      this._currentIndex = value;
                    },
                    tabs: <Widget>[
                        Tab(child: Text("认购中", style: TextStyle(
                            color: Colors.black, fontSize: ScreenAdaper.fontSize(34)
                        ))),
                        Tab(child: Text("已转让", style: TextStyle(
                            color: Color(0XFF666666),
                            fontSize: ScreenAdaper.fontSize(34)
                        )))
                    ]
                ),
            ),
            body: Container(
                padding: EdgeInsets.fromLTRB(
                    ScreenAdaper.width(30),
                    ScreenAdaper.height(20),
                    ScreenAdaper.width(30),
                    ScreenAdaper.height(20)
                ),
                child: TabBarView(
                    controller: this._tabController,
                    children: <Widget>[
                        ListView(
                          children: <Widget>[
                            Wrap(
                            spacing: ScreenAdaper.width(10),
                            runSpacing: ScreenAdaper.width(10),
                            children: <Widget>[
                                this._item(),
                                this._item(),
                                this._item(),
                                this._item()
                            ]
                        )
                          ],
                        ),
                        ListView(
                          children: <Widget>[
                            Wrap(
                            spacing: ScreenAdaper.width(10),
                            runSpacing: ScreenAdaper.width(10),
                            children: <Widget>[
                                this._item(isTransfer: false),
                                this._item(isTransfer: false),
                                this._item(isTransfer: false),
                                this._item(isTransfer: false)
                            ]
                        )
                          ],
                        )
                    ]
                )
            )
        );
    }
}