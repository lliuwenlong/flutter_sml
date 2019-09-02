import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../Shop/Purchase.dart';
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
        width: ScreenAdaper.width(345),
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


  //介绍
  Widget _introuce (String name,String text,{String imageUrl=''}) {
    return Container(
      padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), ScreenAdaper.height(30), ScreenAdaper.width(30), 0),
      color: Colors.white,
      margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Text(
                name,
                style: TextStyle(
                  color: Color(0xff333333),
                  fontSize: ScreenAdaper.fontSize(30),
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            SizedBox(height: ScreenAdaper.height(30),),
            Text(
              text,
               style: TextStyle(
                  color: Color(0xff666666),
                  fontSize: ScreenAdaper.fontSize(26)
                ),
            ),
            imageUrl.isNotEmpty?  Container(
              margin: EdgeInsets.only(top: ScreenAdaper.height(30),bottom: ScreenAdaper.height(30)),
              // height: ScreenAdaper.height(214),
              child:AspectRatio(
                aspectRatio:236/107,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                ),        
              ),
            ):Text('')
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
        body: ConstrainedBox(
          constraints: BoxConstraints.expand(),
          child: Stack(
            alignment: Alignment.topLeft,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: ScreenAdaper.height(110)),
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
                                        fit: BoxFit.cover)));
                          },
                          itemCount: bannerList.length,
                          control: new SwiperPagination(
                            builder: FractionPaginationBuilder(
                                color: Colors.white,
                                activeColor: Colors.white,
                                fontSize: ScreenAdaper.fontSize(30),
                                activeFontSize: ScreenAdaper.fontSize(40)),
                            margin: EdgeInsets.only(
                                bottom: ScreenAdaper.height(30),
                                right: ScreenAdaper.width(30)),
                            alignment: Alignment.bottomRight,
                          )
                          // pagination: new SwiperPagination()
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
                      padding: EdgeInsets.fromLTRB(
                          ScreenAdaper.width(30),
                          ScreenAdaper.height(30),
                          ScreenAdaper.width(30),
                          ScreenAdaper.height(30)),
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
                    Container(
                      child: this._introuce(
                        '神木介绍', 
                        '金丝楠是中国特有的珍贵木材。代表物种楠木（学名：Phoebe zhennan S. Lee）：原称“桢楠”。大乔木，高达30余米，树干通直。小枝通常较细，有棱或近于圆柱形，被灰黄色或灰褐色长柔毛或短柔毛。叶革质，椭圆形，长7-11厘米，宽2.5-4厘米，上面光亮无毛或沿中脉下半部有柔毛，下面密被短柔毛，聚伞状圆锥花序十分开展，被毛，每伞形花序有花3-6朵，花中等大，长3-4毫米。果椭圆形，革质、紧贴，两面被短柔毛或外面被微柔毛。花期4-5月，果期9-10月。野生或栽培；野生的多见于海拔1500米以下的阔叶林中。主要产于中国四川、湖北西部、云南、贵州及长江以南省区。据记载，在所有的金丝楠木中，四川的金丝楠材质最佳。属中国国家二级保护植物，木材有香气，纹理直而结构细密，不易变形和开裂，为建筑、高级家具等优良木材。在历史上金丝楠木专用于皇家宫殿、少数寺庙的建筑和家具。金丝楠木中的结晶体明显多于普通楠木，木材表面在阳光下金光闪闪，金丝浮现，且有淡雅幽香。',
                        ),
                    ),
                    Container(
                      child: this._introuce(
                        '产值介绍', 
                        '金丝楠是中国特有的珍贵木材。代表物种楠木（学名：Phoebe zhennan S. Lee）：原称“桢楠”。大乔木，高达30余米，树干通直。小枝通常较细，有棱或近于圆柱形，被灰黄色或灰褐色长柔毛或短柔毛。叶革质，椭圆形，长7-11厘米，宽2.5-4厘米，上面光亮无毛或沿中脉下半部有柔毛，下面密被短柔毛，聚伞状圆锥花序十分开展，被毛，每伞形花序有花3-6朵，花中等大，长3-4毫米。果椭圆形，革质、紧贴，两面被短柔毛或外面被微柔毛。花期4-5月，果期9-10月。'
                      )
                      ,
                    )
                  ],

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
