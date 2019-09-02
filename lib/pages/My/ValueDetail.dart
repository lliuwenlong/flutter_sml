import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../Shop/Purchase.dart';

class ValueDetail extends StatefulWidget {
  final Map arguments;
  ValueDetail({Key key, this.arguments}) : super(key: key);

  _ValueDetailState createState() =>
      _ValueDetailState(arguments: this.arguments);
}

class _ValueDetailState extends State<ValueDetail> {
  final Map arguments;
  _ValueDetailState({this.arguments});
  List<Map> bannerList = [
    {
      "url":'http://img008.hc360.cn/g1/M01/06/BB/wKhQMFIK3TSEQo1uAAAAAGgBkrE623.jpg'
    },
    {
      "url":'http://sem.g3img.com/g3img/linzhongbao/20150509091853_99214.jpg'
    },
    {
      "url":'http://sem.g3img.com/g3img/linzhongbao/20150509091853_99214.jpg'
    },
    {
      "url":'http://img008.hc360.cn/g1/M01/06/BB/wKhQMFIK3TSEQo1uAAAAAGgBkrE623.jpg'
    },
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
              height: ScreenAdaper.height(214),
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
        appBar: AppBarWidget().buildAppBar('详情'),
        body: ConstrainedBox(
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                    '灵芝',
                                      style: TextStyle(
                                          color: Color(0xff333333),
                                          fontFamily: 'ourceHanSansCN-Bold',
                                          fontSize: ScreenAdaper.fontSize(34),
                                          fontWeight: FontWeight.w700
                                      ),
                                ),
                                Text(
                                  '¥1000.00',
                                  style: TextStyle(
                                          color: Color(0xfffb4135),
                                          fontFamily: 'SourceHanSansCN-Medium',
                                          fontSize: ScreenAdaper.fontSize(28),
                                      ),
                                )
                              ],
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
                              )
                          ),

                        ],
                      ),
                    ),
                    this._introuce(
                      '产品介绍', 
                      '选择保温保湿，通风良好、光线适量、排水通畅、管理方便的灵芝大棚，棚内要求地面清洁，墙壁光洁，耐潮湿。灵芝棚的大小视培养料的多少而定，一般建在树林、房前屋后林阴处，靠近水源的位置最合适。',
                      imageUrl:'http://img008.hc360.cn/g1/M01/06/BB/wKhQMFIK3TSEQo1uAAAAAGgBkrE623.jpg'
                    ),
                    this._introuce(
                      '产值介绍',
                      '灵芝是喜温型真菌，菌丝生长温度以26~28℃为最佳，子实体在24~28℃温度下长势最好，低于18℃子实体不能正常发育。发菌期间，培养室内温度保持22~30℃，空气相对湿度保持50%~60%。每天通风半小时，每隔5~7天菌袋上下翻动1次。当菌丝题发满料袋溶剂三分之二时，移入培养棚内，松开料袋口，用手轻轻一提，留一点缝隙。棚内以散射光为宜避免强光直射。',
                    )
                  ],
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
                  child: RaisedButton(
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
                      print('购买');
                    },
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
