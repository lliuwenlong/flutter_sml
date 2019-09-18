import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../Shop/Purchase.dart';

class ProductDetail extends StatefulWidget {
  final Map arguments;
  ProductDetail({Key key, this.arguments}) : super(key: key);

  _ProductDetailState createState() => _ProductDetailState(arguments: this.arguments);
}

class _ProductDetailState extends State<ProductDetail> {
  final Map arguments;
  String woodSn;
  _ProductDetailState({this.arguments});
void didChangeDependencies() {
       super.didChangeDependencies();
       setState(() {
         this.woodSn = arguments['woodSn'];
       });
    }
  
  List<Map> bannerList = [
    {
      "url":
          'http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1411/14/c2/40920783_40920783_1415949861822_mthumb.jpg'
    },
    {"url": 'http://img.juimg.com/tuku/yulantu/110126/292-11012613321981.jpg'},
    {
      "url":
          'http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1411/14/c2/40920783_40920783_1415949861822_mthumb.jpg'
    },
    {"url": 'http://img.juimg.com/tuku/yulantu/110126/292-11012613321981.jpg'}
  ];

  //树木信息
  Widget _treeInfo(String infoName, String infoData) {
    return Container(
        width: (ScreenAdaper.getScreenWidth()-ScreenAdaper.width(60))/2,
        margin: EdgeInsets.only(bottom: ScreenAdaper.height(20)),
        child: Row(
          children: <Widget>[
            Text('$infoName：',
                style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: ScreenAdaper.fontSize(24))),
            Text(infoData,
                style: TextStyle(
                    color: Color(0xff999999),
                    fontSize: ScreenAdaper.fontSize(24)))
          ],
        ));
  }
  //神木数据
  Widget _treeData(int icon, String data, String dataType) {
    return Container(
      width: ScreenAdaper.width(138),
      child: Column(
        children: <Widget>[
          Icon(
            IconData(icon, fontFamily: 'iconfont'),
            size: ScreenAdaper.fontSize(50, allowFontScaling: true),
            color: Color(0xff22b0a1),
          ),
          SizedBox(height: ScreenAdaper.height(18)),
          Text(
            data,
            style: TextStyle(
                fontFamily: "SourceHanSansCN-Regular",
                fontSize: ScreenAdaper.fontSize(22),
                color: Color(0xff333333)),
          ),
          SizedBox(height: ScreenAdaper.height(12)),
          Text(
            dataType,
            style: TextStyle(
                fontFamily: "SourceHanSansCN-Regular",
                fontSize: ScreenAdaper.fontSize(20),
                color: Color(0xff999999)),
          )
        ],
      ),
    );
  }
  //记录
  Widget _treeRecord (String recordName,String text,String routeName,{String time='',String oldName='',String newName='',bool isShow=true}) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, routeName,arguments: {
          'woodSn':this.woodSn
        });
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
        padding: EdgeInsets.all(ScreenAdaper.width(30)),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: ScreenAdaper.height(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: ScreenAdaper.width(6),
                        height: ScreenAdaper.height(28),
                        decoration: BoxDecoration(
                          color: Color(0xff22b0a1),
                          borderRadius: BorderRadius.all(Radius.circular(2))
                        ),
                      ),
                      SizedBox(width: ScreenAdaper.width(16),),
                      Text(
                        recordName,
                        style: TextStyle(
                          fontFamily: "SourceHanSansCN-Medium",
	                        fontSize: ScreenAdaper.fontSize(30),
                          color: Color(0xff333333),
                          fontWeight: FontWeight.w500
                        ),
                      )
                    ],
                  ),
                  Icon(
                    IconData(0xe61e,fontFamily: 'iconfont'),
                    size: ScreenAdaper.fontSize(26,allowFontScaling: true),
                    color: Color(0xffaaaaaa),
                  )
                ],
            ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: ScreenAdaper.height(14)),
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: "SourceHanSansCN-Regular",
	                fontSize: ScreenAdaper.fontSize(28),
                  color: Color(0xff666666)
                ),
              ),
            ),
           isShow?Container(
              width: double.infinity,
              child:time.isNotEmpty ? Text(
                time,
                style: TextStyle(
                    fontFamily: "SourceHanSansCN-Regular",
                    fontSize: ScreenAdaper.fontSize(24),
                    color: Color(0xff999999)
                ),
              ):Row(
                children: <Widget>[
                  Text(
                    '金丝楠持有人由',
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: ScreenAdaper.fontSize(24)
                    ),
                  ),
                  Text(
                    oldName,
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: ScreenAdaper.fontSize(24),
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                      '更改为',
                      style: TextStyle(
                        color: Color(0xff666666),
                        fontSize: ScreenAdaper.fontSize(24)
                      ),

                  ),
                  Text(
                    newName,
                    style: TextStyle(
                      color: Color(0xff666666),
                      fontSize: ScreenAdaper.fontSize(24),
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ):Container(),
          ],
        ),
      ),
    );
  }
 //增值列表
  Widget _listItem (String name,String date,String state,String output) {
    return Container(
      padding: EdgeInsets.only(top: ScreenAdaper.height(30),right: ScreenAdaper.height(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  color: Color(0xff666666),
                  fontFamily: "SourceHanSansCN-Medium",
	                fontSize: ScreenAdaper.fontSize(28),
                ),
              ),
              Text(
                '购买日期  $date',
                style: TextStyle(
                  color: Color(0xff999999),
                  fontFamily: "SourceHanSansCN-Regular",
	                fontSize: ScreenAdaper.fontSize(24),
                ),
              )
            ],
          ),
          SizedBox(
            height: ScreenAdaper.height(20),
          ),
          Text(
            '成长状态：$state',
            style: TextStyle(
                color: Color(0xff666666),
                fontFamily: "SourceHanSansCN-Regular",
	              fontSize: ScreenAdaper.fontSize(24),
            ),
          ),
          SizedBox(
            height: ScreenAdaper.height(20),
          ),
          Text(
            '产值：$output',
            style: TextStyle(
                color: Color(0xff666666),
                fontFamily: "SourceHanSansCN-Regular",
	              fontSize: ScreenAdaper.fontSize(24),
            ),
          ),
          SizedBox(
            height: ScreenAdaper.height(30),
          ),
        ],
      ),
    );
  }
  
  
  BuildContext _selfContext;
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
  
  
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    this._selfContext = context;
    return Scaffold(
        appBar: AppBarWidget().buildAppBar('神木详情'),
        body: SafeArea(
          bottom: true,
          child: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: ScreenAdaper.height(132)),
                child: ListView(
                  children: <Widget>[
                    Container(
                        child: AspectRatio(
                      aspectRatio: 5 / 2,
                      child: Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                height: ScreenAdaper.height(300),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            bannerList[index]['url']),
                                        fit: BoxFit.cover
									)
								)
							);
                          },
                          itemCount: bannerList.length,
                          control: new SwiperPagination(
                            builder: FractionPaginationBuilder(
                                color: Colors.white,
                                activeColor: Colors.white,
                                fontSize: ScreenAdaper.fontSize(30),
                                activeFontSize: ScreenAdaper.fontSize(40),
                            ),
                            margin: EdgeInsets.only(
                                bottom: ScreenAdaper.height(30),
                                right: ScreenAdaper.width(30)),
                            alignment: Alignment.bottomRight,
                          ),
                          ),
                    )),
                    Container(
                      color: Colors.white,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(15),
                            child: Text(
                              '金丝楠',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontFamily: 'ourceHanSansCN-Bold',
                                  fontSize: ScreenAdaper.fontSize(34),
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.fromLTRB(
                                  ScreenAdaper.width(30),
                                  0,
                                  ScreenAdaper.width(30),
                                  ScreenAdaper.width(14)),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                spacing: 0,
                                children: <Widget>[
                                  this._treeInfo('树龄', '1年生'),
                                  this._treeInfo('枝条数', '3'),
                                  this._treeInfo('树维', '280cm'),
                                  this._treeInfo('树高', '800cm')
                                ],
                              )),
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                      padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30),
                          ScreenAdaper.height(30), ScreenAdaper.width(30), ScreenAdaper.height(30)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(
                                bottom: ScreenAdaper.height(40)),
                            child: Text(
                              '神木数据',
                              style: TextStyle(
                                  color: Color(0xff333333),
                                  fontSize: ScreenAdaper.fontSize(30),
                                  fontFamily: 'SourceHanSansCN-Medium',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            child: Wrap(
                              runSpacing: ScreenAdaper.width(40),
                              children: <Widget>[
                                this._treeData(0xe625, '31 μg/m3', 'PM2.5'),
                                this._treeData(0xe624, '35 μg/m3', 'PM10'),
                                this._treeData(0xe628, '西南风', '风向'),
                                this._treeData(0xe62e, '2.6 m/s', '风速'),
                                this._treeData(0xe626, '53.7%', '空气湿度'),
                                this._treeData(0xe62b, '32.8 °C', '空气温度'),
                                this._treeData(0xe62a, '10000 ppm', '二氧化碳浓度'),
                                this._treeData(0xe629, '49421 Lux', '光照度'),
                                this._treeData(0xe630, '851.3 hPa', '大气压力'),
                                this._treeData(0xe631, '0%', '土壤湿度'),
                                this._treeData(0xe62c, '55 us/cm', '土壤电导率'),
                                this._treeData(0xe62f, '27 ppm', '土壤盐分'),
                                this._treeData(0xe632, '26.1 °C', '土壤温度'),
                                this._treeData(0xe62d, '4.8', '干式PH值'),
                                this._treeData(0xe627, '0 mm', '降雨量')
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
					this._treeRecord('成长记录', '开花','/growthRecord',time: '2019-08-06  12:30:06'),
					this._treeRecord('转让记录', '张三','/transferRecord',oldName: '李四',newName: '张三'),
					this._treeRecord('产值记录', '百合花总产量达150株','/outputRecord',isShow:false),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                      padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), ScreenAdaper.height(30), ScreenAdaper.width(30), 0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: ScreenAdaper.width(6),
                                height: ScreenAdaper.height(28),
                                decoration: BoxDecoration(
                                    color: Color(0xff22b0a1),
                                    borderRadius: BorderRadius.all(Radius.circular(2))
                                ),
                            ),
                            SizedBox(width: ScreenAdaper.width(16),),
                            Text(
                              '增值列表',
                              style: TextStyle(
                                fontFamily: "SourceHanSansCN-Medium",
                                fontSize: ScreenAdaper.fontSize(30),
                                color: Color(0xff333333),
                                fontWeight: FontWeight.w500
                              ),
                            )
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              this._listItem("百合花", '2019-08-06  12:30:06', '发芽', '发芽'),
                              Container(
                                color: Color(0xffd5d5d5),
                                height: ScreenAdaper.height(1),
                                width: double.infinity,
                              ),
                              this._listItem("中草药", '2019-08-06  12:30:06', '结果', '15斤'),

                           ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: Container(
                  width: ScreenAdaper.getScreenWidth(),
                  height: ScreenAdaper.height(110),
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          height: ScreenAdaper.height(110),
                          alignment: Alignment.center,
                          width: ScreenAdaper.width(168),
                          decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffd5d5d5),
                                  spreadRadius: 0.5,
                                ),
                              ]),
                          child: Text(
                            '转让',
                            style: TextStyle(
                              color: Color(0xff22b0a1),
                              fontSize: ScreenAdaper.fontSize(34),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/transfer',arguments: {
                            'woodSn':this.woodSn
                          });
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          height: ScreenAdaper.height(110),
                          alignment: Alignment.center,
                          width: ScreenAdaper.width(232),
                          decoration: BoxDecoration(
                              color: Color(0xffffffff),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xffd5d5d5),
                                  spreadRadius: 0.5,
                                ),
                              ]),
                          child: Text(
                            '增值服务',
                            style: TextStyle(
                              color: Color(0xff22b0a1),
                              fontSize: ScreenAdaper.fontSize(34),
                            ),
                          ),
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/valueAddedServices');
                        },
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          child: Container(
                            height: ScreenAdaper.height(110),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Color(0xff22b0a1),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xff22b0a1),
                                  spreadRadius: 0.5,
                                ),
                              ]),
                            child: Text(
                              '续费',
                              style: TextStyle(
                                color: Color(0xffffffff),
                                fontSize: ScreenAdaper.fontSize(40),
                                fontFamily: 'SourceHanSansCN-Regular',
                              ),
                            ),
                          ),
                          onTap: () {
                            // print('续费');
                            this._purchase();
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        )
    );
  }
}
