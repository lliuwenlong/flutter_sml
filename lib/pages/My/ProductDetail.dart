import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../pages/My/ProductBuy.dart';
import '../../common/HttpUtil.dart';
import '../../model/api/my/OutputRecordData.dart';
import '../../model/api/my/GrowthRecordData.dart';
import '../../model/api/my/TransferRecordData.dart';
import '../../model/api/my/ValueData.dart';
import '../../model/store/user/User.dart';
import '../../model/api/my/BannerData.dart';
class ProductDetail extends StatefulWidget {
  final Map arguments;
  ProductDetail({Key key, this.arguments}) : super(key: key);

  _ProductDetailState createState() =>
      _ProductDetailState(arguments: this.arguments);
}

class _ProductDetailState extends State<ProductDetail> {
  final Map arguments;
  String woodSn;
  final HttpUtil http = HttpUtil();
  User _userModel;
  _ProductDetailState({this.arguments});
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userModel = Provider.of<User>(context);
    setState(() {
      this.woodSn = arguments['woodSn'];
    });
      _getDetail();
      _getOutPutRecord();
      _getGrowthRecord();
      _getTransferRecord();
      _getValueRecored();
      _getBanner();

  }

  

  //树木信息
  Widget _treeInfo(String infoName, String infoData) {
    return Container(
        width: (ScreenAdaper.getScreenWidth() - ScreenAdaper.width(60)) / 2,
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
  Widget _treeRecord(String recordName, String text, String routeName,double bottom,
      {String time = '',
      String oldName = '',
      String newName = '',
      bool isShow = true}) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName,
            arguments: {'woodSn': this.woodSn});
      },
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
        padding: EdgeInsets.all(ScreenAdaper.width(30)),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(bottom: ScreenAdaper.height(bottom)),
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
                            borderRadius: BorderRadius.all(Radius.circular(2))),
                      ),
                      SizedBox(
                        width: ScreenAdaper.width(16),
                      ),
                      Text(
                        recordName,
                        style: TextStyle(
                            fontFamily: "SourceHanSansCN-Medium",
                            fontSize: ScreenAdaper.fontSize(30),
                            color: Color(0xff333333),
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  Icon(
                    IconData(0xe61e, fontFamily: 'iconfont'),
                    size: ScreenAdaper.fontSize(26, allowFontScaling: true),
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
                    color: Color(0xff666666)),
              ),
            ),
            isShow
                ? Container(
                    width: double.infinity,
                    child: time.isNotEmpty
                        ? Text(
                            time,
                            style: TextStyle(
                                fontFamily: "SourceHanSansCN-Regular",
                                fontSize: ScreenAdaper.fontSize(24),
                                color: Color(0xff999999)),
                          )
                        : Row(
                            children: <Widget>[
                              Text(
                                '金丝楠持有人由',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: ScreenAdaper.fontSize(24)),
                              ),
                              Text(
                                oldName,
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: ScreenAdaper.fontSize(24),
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                '更改为',
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: ScreenAdaper.fontSize(24)),
                              ),
                              Text(
                                newName,
                                style: TextStyle(
                                    color: Color(0xff666666),
                                    fontSize: ScreenAdaper.fontSize(24),
                                    fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  //增值列表
  Widget _listItem(String name, String date, String state, String output) {
    return Container(
      padding: EdgeInsets.only(
          top: ScreenAdaper.height(30), right: ScreenAdaper.height(30)),
        decoration: BoxDecoration(
            border: Border(bottom:BorderSide(
                width: 1,
                color: Color(0xffd9d9d9)
            ))
            
        ),
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

  List outPutList = []; //产值记录
  List growthList = []; //成长记录
  List transferList = []; //转让记录
  List valueList = [];
  var detailData;
  List bannerList = [];
  _getOutPutRecord() async {
    Map resOutPut = await this.http.get('/api/v1/user/wood/prod',
        data: {'pageNO': 1, 'pageSize': 1, 'woodSn': arguments['woodSn']});

    if (resOutPut['code'] == 200) {
      OutputRecordDataModel res = OutputRecordDataModel.fromJson(resOutPut);
      setState(() {
        this.outPutList = res.data.list;
      });
    }
  }
  _getGrowthRecord() async {
    Map resGrowth = await this.http.get('/api/v1/user/wood/grow',
        data: {'pageNO': 1, 'pageSize': 1, 'woodSn': arguments['woodSn']});
    if (resGrowth['code'] == 200) {
      GrowthRecordDataModel res = GrowthRecordDataModel.fromJson(resGrowth);
      setState(() {
        this.growthList = res.data.list;
      });
    }
  }
  _getTransferRecord() async {
    Map resTransfer = await this.http.get('/api/v1/user/wood/transfer',
        data: {'pageNO': 1, 'pageSize': 1, 'woodSn': arguments['woodSn']});
    if (resTransfer['code'] == 200) {
      TransferRecordDataModel res =
          TransferRecordDataModel.fromJson(resTransfer);
      setState(() {
        this.transferList = res.data.list;
      });
    }
  }
  _getValueRecored () async {
		Map resValue = await this.http.get('/api/v1/user/wood/vp',
        data: {'woodSn': arguments['woodSn']});
		if (resValue['code'] == 200) {
			ValueDataModel res = ValueDataModel.fromJson(resValue);
			setState(() {
				this.valueList = res.data;
			});
		}
	}
  _getDetail () async {
        Map resDetail = await this.http.get('/api/v1/user/wood/one', data: {
            'woodSn':arguments['woodSn']
        });
        if(resDetail['code'] == 200){
            setState(() {
                this.detailData = resDetail['data'];
            });
        }
 }
  _getBanner () async {
    Map resBanner = await this.http.get('/api/v1/banner/tree',data: {
      'vpId':arguments['woodId']
    });
    if (resBanner['code'] == 200) {
        setState(() {
          this.bannerList = resBanner['data'];
        });
    }
  }
  BuildContext _selfContext;
  _productBuy() {
    showModalBottomSheet(
        context: this._selfContext,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ScreenAdaper.width(10)),
            topRight: Radius.circular(ScreenAdaper.width(10)),
        )),
        builder: (BuildContext context) {
            return ProductBuy(
                userId:this._userModel.userId,
                price: double.parse(detailData['price']),
                woodSn: arguments['woodSn'],
            );
        });
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
                  padding: EdgeInsets.only(bottom: ScreenAdaper.height(110)),
                  child: ListView(
                    children: <Widget>[
                      
                    detailData!=null?  Container(
                          child: AspectRatio(
                        aspectRatio: 5 / 2,
                        child: this.bannerList.length != 0 ? Swiper(
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                                height: ScreenAdaper.height(300),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                           this.bannerList[index]['imageUrl']
                                        ),
                                        fit: BoxFit.cover)));
                          },
                          itemCount:this.bannerList.length,
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
                        ) : Container(),
                      )):Container(),
                    
                   detailData!=null?   Container(
                        color: Colors.white,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              child: Text(
                                detailData['name'],
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
                                    this._treeInfo('树龄','${ detailData['treeLife']}'),
                                    this._treeInfo('枝条数','${detailData['branch']}' ),
                                    this._treeInfo('树维', detailData['cricle']),
                                    this._treeInfo('树高', detailData['height'])
                                  ],
                                )),
                          ],
                        ),
                      ):Container(),
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
                      this.growthList.length > 0
                          ? this._treeRecord('成长记录', this.growthList[0].content,
                              '/growthRecord',30,
                              time: this.growthList[0].createTime)
                          : SizedBox(height: 0,),
                      this.transferList.length > 0
                          ? this._treeRecord('转让记录', this.transferList[0].reciever, '/transferRecord',30,
                              oldName: this.transferList[0].sender, newName: this.transferList[0].reciever)
                          : SizedBox(height: 0,),
                      this.outPutList.length > 0
                          ? this._treeRecord('产值记录', this.outPutList[0].content,
                              '/outputRecord',30,
                              isShow: false)
                          : SizedBox(height: 0,),
                    this.valueList.length > 0 ? Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(top: ScreenAdaper.height(20)),
                        padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30),
                            ScreenAdaper.height(30), ScreenAdaper.width(30), 0),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: ScreenAdaper.width(6),
                                  height: ScreenAdaper.height(28),
                                  decoration: BoxDecoration(
                                      color: Color(0xff22b0a1),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(2))),
                                ),
                                SizedBox(
                                  width: ScreenAdaper.width(16),
                                ),
                                Text(
                                  '增值列表',
                                  style: TextStyle(
                                      fontFamily: "SourceHanSansCN-Medium",
                                      fontSize: ScreenAdaper.fontSize(30),
                                      color: Color(0xff333333),
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                            ...this.valueList.map((val){
                                return this._listItem(val.name, val.buyTime, '','');
                            }).toList()
                            
                            
                        	],
                        ),
                      ) : SizedBox(height: 0)
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
                            Navigator.pushNamed(context, '/transfer',
                                arguments: {'woodSn': this.woodSn});
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
                            Navigator.pushNamed(context, '/valueAddedServices',arguments: {
								'woodSn': arguments['woodSn'],
                                "woodId": arguments['woodId']
							});
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
                              this._productBuy();
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
        ));
  }
}
