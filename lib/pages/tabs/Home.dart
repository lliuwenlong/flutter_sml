import 'package:flutter/material.dart';
import '../Home/Swiper.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/home/ArticleModel.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
    HomePage({Key key}) : super(key: key);
    _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    HttpUtil http = HttpUtil();
    int _page = 1;
    List<Data> articleList = [];
    RefreshController _refreshController = RefreshController(initialRefresh: false);
    _onTap (String router, int type) {
        type == null
            ? Navigator.pushNamed(context, router)
            : Navigator.pushNamed(context, router, arguments: {
                "type": type
            });
    }

    @override
    void initState () {
        super.initState();
        this.getArticleData();
    }

    getArticleData({bool isInit = false}) async {
        Map response = await http.get("/api/v1/article/articles/article", data: {
            "pageSize": 10,
            "pageNO": this._page
        });
        if (response["code"] == 200) {
            final ArticleModel articleModel = new ArticleModel.fromJson(response);
            if (isInit) {
                setState(() {
                    articleList = articleModel.data;
                });
                return response;
            } else {
                setState(() {
                    articleList.addAll(articleModel.data);
                });
                return response;
            }
        }
        return response;
    }

    void _onLoading() async{
        setState(() {
            this._page++;
        });
        var response = await getArticleData();
        if (response["data"].length == 0) {
            _refreshController.loadNoData();
        } else {
            _refreshController.loadComplete();
        }
    }

    void _onRefresh() async{
        setState(() {
            this._page = 1;
        });
        final Map res = await getArticleData(isInit: true);
        _refreshController.refreshCompleted();
        if (_refreshController.footerStatus == LoadStatus.noMore) {
            _refreshController.loadComplete();
        }
    }

    Widget _menuWidget () {
        return Container(
            padding: EdgeInsets.fromLTRB(0, ScreenAdaper.height(30), 0, ScreenAdaper.height(40)),
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: Column(
                children: <Widget>[
                    Row(
                        children: <Widget>[
                            this._menuItem("images/shenmujidi.png", "神木基地",  80, 90, "/base"),
                            this._menuItem("images/shenmukaquan.png", "神木卡券",  77, 88, "/coupon"),
                            this._menuItem("images/shenmuchuxing.png", "神木出行", 94, 99, "/trip"),
                            this._menuItem("images/shenmucanyin.png", "神木餐饮", 87, 93, "/restaurant", type: 1)
                        ],
                    ),
                    SizedBox(height: ScreenAdaper.height(40)),
                    Row(
                        children: <Widget>[
                            this._menuItem("images/shenmuzhusu.png", "神木住宿", 98, 83, "/accommodation"),
                            this._menuItem("images/shenmugouwu.png", "神木购物", 65, 92,  "/restaurant", type: 2),
                            this._menuItem("images/shenmuyule.png", "神木娱乐", 62, 97, "/entertainment"),
                            this._menuItem("images/zhoubianyou.png", "周边游", 100, 85, "/restaurant", type: 3)
                        ],
                    )
                ],
            ),
        );
    }

    Widget _menuItem (String url, String text,  double width, double height, String router, {int type}) {
        return Expanded(
            child: Container(
                child: GestureDetector(
                    onTap: () {
                        this._onTap(router, type);
                    },
                    child: Column(
                        children: <Widget>[
                            Container(
                                height: ScreenAdaper.width(100),
                                child: Container(
                                    width: ScreenAdaper.width(width),
                                    height: ScreenAdaper.width(height),
                                    child: Image.asset(
                                        url,
                                        fit: BoxFit.cover
                                    )
                                )
                            ),
                            SizedBox(height: ScreenAdaper.height(20)),
                            Text(text, style: TextStyle(
                                color: Color(0xFF666666),
                                fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true)
                            ))
                        ],
                    )
                ),
                alignment: Alignment.topCenter,
            ),
            flex: 1,
        );
    }

    Widget _announcement () {
        return Container(
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                ScreenAdaper.height(40),
                ScreenAdaper.width(30),
                ScreenAdaper.width(30)
            ),
            margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: Column(
                children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            Text("活动公告", style: TextStyle(
                                fontSize: ScreenAdaper.fontSize(30, allowFontScaling: true),
                                color: Color.fromRGBO(51, 51, 51, 1)
                            )),
                            Row(
                                children: <Widget>[
                                    Center(
                                        child: Text("更多", style: TextStyle(
                                            fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true),
                                            color: Color.fromRGBO(153, 153, 153, 1)
                                        ))
                                    ),
                                    Center(
                                        child: Icon(
                                            IconData(0xe61e, fontFamily: 'iconfont'),
                                            color: Color.fromRGBO(170,170,170, 1),
                                            size: ScreenAdaper.fontSize(24),
                                        )
                                    )
                                ],
                            )
                        ],
                    ),
                    SizedBox(height: ScreenAdaper.height(20)),
                    AspectRatio(
                        aspectRatio: 690 / 236,
                        child: Stack(
                            children: <Widget>[
                                Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5.0),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                              "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws"
                                            ),
                                            fit: BoxFit.cover
                                        )
                                    )
                                ),
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5.0),
                                            color: Color.fromRGBO(0, 0, 0, 0.5)
                                        )
                                    ),
                                ),
                                Positioned(
                                    bottom: ScreenAdaper.height(28),
                                    left: ScreenAdaper.width(30),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text(
                                                "【如何成为什么尊享会员？】",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: ScreenAdaper.fontSize(28, allowFontScaling: true)
                                                )
                                            ),
                                            SizedBox(height: ScreenAdaper.height(20)),
                                            Text(
                                                "时间：2019年7月1日——2019年8月20日",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: ScreenAdaper.fontSize(22)
                                                )
                                            )
                                        ],
                                    ),
                                )
                            ],
                        )
                    ),
                    SizedBox(height: ScreenAdaper.height(20)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                            Text("查看详情", style: TextStyle(
                                color: Color.fromRGBO(153,153,153, 1),
                                fontSize: ScreenAdaper.fontSize(24, allowFontScaling: true)
                            )),
                            Icon(
                                IconData(0xe61e, fontFamily: 'iconfont'),
                                color: Color.fromRGBO(170,170,170, 1),
                                size: ScreenAdaper.fontSize(24, allowFontScaling: true),
                            )
                        ],
                    )
                ],
            ),
        );
    }

    Widget _getNivoList () {
        var list = this.articleList.map((value) {
            int lastId = this.articleList[this.articleList.length - 1].articleId;
            return GestureDetector(
                onTap: () {
                    Navigator.pushNamed(context, "/newsDetail",
                        arguments: {
                            "appTabName": "新闻详情",
                            "id": value.articleId,
                            "type": "article"
                        });
                },
                child: Container(
                    padding : EdgeInsets.fromLTRB(
                        0, ScreenAdaper.height(30), 0, ScreenAdaper.height(30)
                    ),
                    decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(
                            color: lastId == value.articleId ? Colors.white :  Color(0XFFd9d9d9),
                            width: ScreenAdaper.width(lastId == value.articleId ? 0 : 1)
                        ))
                    ),
                    child: Row(
                        children: <Widget>[
                            Container(
                                height: ScreenAdaper.width(150),
                                width: ScreenAdaper.width(150),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(3),
                                    child: Image.network(
                                        "https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws",
                                        fit: BoxFit.cover
                                    )
                                ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container(
                                    height: ScreenAdaper.width(150),
                                    margin: EdgeInsets.only(left: ScreenAdaper.width(30)),
                                    child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                            Text(value.articleTitle, style: TextStyle(
                                                fontSize: ScreenAdaper.fontSize(28),
                                                color: Color(0xFF333333)
                                            )),
                                            SizedBox(height: ScreenAdaper.height(15)),
                                            Text(
                                                value.articleSummary,
                                                style: TextStyle(
                                                    fontSize: ScreenAdaper.fontSize(24),
                                                    color: Color(0xFF666666),
                                                    height: 1.3
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                            )
                                        ]
                                    )
                                )
                            )
                        ]
                    )
                )
            );
        });
        return Column(
            children: list.toList()
        );
    }

    Widget _nivoList () {
        return Container(
            margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
            padding: EdgeInsets.fromLTRB(
                ScreenAdaper.width(30),
                ScreenAdaper.height(40),
                ScreenAdaper.width(30),
                ScreenAdaper.height(40)
            ),
            decoration: BoxDecoration(
                color: Colors.white
            ),
            child: Column(
                children: <Widget>[
                    Row(
                        children: <Widget>[
                            Text("精选文章", style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: ScreenAdaper.fontSize(30)
                            ))
                        ],
                    ),
                    this._getNivoList()
                ],
            )
        );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            appBar: PreferredSize(
                child: AppBarWidget().buildAppBar("神木林"),
                preferredSize: Size.fromHeight(ScreenAdaper.height(88))
            ),
            body: SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: true,
                header: WaterDropHeader(),
                footer: ClassicFooter(
                    loadStyle: LoadStyle.ShowWhenLoading,
                    idleText: "上拉加载",
                    failedText: "加载失败！点击重试！",
                    canLoadingText: "加载更多",
                    noDataText: "没有更多数据",
                    loadingText: "加载中"
                ),
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: ListView(
                    physics: ClampingScrollPhysics(),
                    children: <Widget>[
                        SwiperComponent(),
                        this._menuWidget(),
                        this._announcement(),
                        this._nivoList()
                    ]
                )
            )
        );
    }
}