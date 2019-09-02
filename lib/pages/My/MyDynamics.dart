import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_sml/common/Color.dart';
import '../../services/ScreenAdaper.dart';

class MyDynamics extends StatefulWidget {
  MyDynamics({Key key}) : super(key: key);

  _MyDynamicsState createState() => _MyDynamicsState();
}

class _MyDynamicsState extends State<MyDynamics> {
  double top = MediaQueryData.fromWindow(window).padding.top;
  Widget _buildTop() {
    return Container(
      height: ScreenAdaper.height(370) + top,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/dongtai.png"), fit: BoxFit.cover)),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: top),
            child: Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  iconSize: ScreenAdaper.fontSize(40, allowFontScaling: true),
                  color: Color(0xffffffff),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(
                  ScreenAdaper.width(30), 0, ScreenAdaper.width(30), 0),
              width: double.infinity,
              child: Row(children: <Widget>[
                Container(
                    child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Container(
                        child: CircleAvatar(
                          radius: ScreenAdaper.height(70),
                          backgroundImage: NetworkImage(
                              'https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws'),
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: ScreenAdaper.height(12),
                        right: ScreenAdaper.width(0),
                        child: Container(
                            width: ScreenAdaper.width(40),
                            height: ScreenAdaper.width(40),
                            child: Image.asset("images/jia-v.png",
                                fit: BoxFit.cover)))
                  ],
                )),
                SizedBox(width: ScreenAdaper.width(20)),
                Text("猫斯拉",
                    style: TextStyle(
                        fontSize: ScreenAdaper.fontSize(40),
                        color: Colors.white)),
              ])),
          SizedBox(
            height: ScreenAdaper.height(20),
          ),
          Container(
            padding: EdgeInsets.only(
                left: ScreenAdaper.width(120), right: ScreenAdaper.width(120)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                this._listItem('关注', '186', 0),
                this._listItem('粉丝', '1490', 1),
                this._listItem('动态', '12', 2, isTap: false)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _listItem(String text, String theNum, int index, {bool isTap = true}) {
    return Container(
      child: GestureDetector(
        onTap: () {
          if (isTap) {
            Navigator.pushNamed(context, '/followOrFans',
                arguments: {"index": index});
          }
        },
        child: Column(
          children: <Widget>[
            Text(
              theNum,
              style: prefix0.TextStyle(
                  fontSize: ScreenAdaper.fontSize(34),
                  color: Color(0xffffffff)),
            ),
            Text(
              text,
              style: prefix0.TextStyle(
                  fontSize: ScreenAdaper.fontSize(24),
                  color: Color(0xffffffff)),
            )
          ],
        ),
      ),
    );
  }

  Widget _headPortrait(String url,int index) {
    return Container(
		child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: CircleAvatar(
					radius: ScreenAdaper.width(43),
					backgroundImage: NetworkImage('http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg'),
				),
              ),
              SizedBox(width: ScreenAdaper.width(20)),
              Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("张丽",
                        style: TextStyle(
                            color: ColorClass.common,
                            fontSize: ScreenAdaper.fontSize(30),
                            fontWeight: FontWeight.w500)),
                    Text("昨天 12:31",
                        style: TextStyle(
                            color: ColorClass.subTitleColor,
                            fontSize: ScreenAdaper.fontSize(24)))
                  ])
            ],
          ),
          Container(
			  color: Colors.white,
			  width: ScreenAdaper.width(30),
			  child: IconButton(
				icon: Icon(IconData(0xe633, fontFamily: 'iconfont')),
				iconSize: ScreenAdaper.fontSize(22),
				color: Color(0xffaaaaaa),
				onPressed: () {
					print(index);
				},
          	),
		  )
        ]),
	);
  }

  Widget iconFont(int icon, String text, {bool isBorder = false}) {
    return Container(
        margin: EdgeInsets.only(top: ScreenAdaper.height(30)),
        decoration: BoxDecoration(
            border: isBorder
                ? Border(
                    left: BorderSide(
                        color: ColorClass.borderColor,
                        width: ScreenAdaper.width(1)),
                    right: BorderSide(
                        color: ColorClass.borderColor,
                        width: ScreenAdaper.width(1)))
                : null),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Icon(
            IconData(icon, fontFamily: "iconfont"),
            color: ColorClass.iconColor,
            size: ScreenAdaper.fontSize(35),
          ),
          SizedBox(width: ScreenAdaper.width(15)),
          Text(text,
              style: TextStyle(
                  fontSize: ScreenAdaper.fontSize(27),
                  color: ColorClass.iconColor))
        ]));
  }

  Widget _optBar() {
    return Row(children: <Widget>[
      Expanded(
        flex: 1,
        child: this.iconFont(0xe63f, (158).toString()),
      ),
      Expanded(
        flex: 1,
        child: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, "/friendDynamicsComment");
            },
            child: this.iconFont(0xe640, (158).toString(), isBorder: true)),
      ),
      Expanded(
        flex: 1,
        child: this.iconFont(0xe641, (158).toString()),
      )
    ]);
  }

  Widget _itemWidget(double marginNum,int index) {
    return Container(
        padding: EdgeInsets.all( ScreenAdaper.width(30)),
        margin: EdgeInsets.only(top: ScreenAdaper.height(marginNum)),
        color: Colors.white,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              this._headPortrait("123",index),
              Container(
                margin: EdgeInsets.only(top: ScreenAdaper.width(30)),
                child: Text(
                    "品鉴停留在舌尖上的金丝楠、金丝榔、香樟亲身体验用味蕾感受金丝楠、金丝榔、香樟在这样的氛围里喝酒吃肉怎能不快哉？"),
              ),
              SizedBox(height: ScreenAdaper.height(30)),
              Wrap(
                  spacing: ScreenAdaper.width(15),
                  runSpacing: ScreenAdaper.width(15),
                  children: <Widget>[
                    Container(
                        width: ScreenAdaper.width(220),
                        height: ScreenAdaper.width(220),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(ScreenAdaper.width(10)),
                            child: Image.network(
                              "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                              fit: BoxFit.cover,
                            ))),
                    Container(
                        width: ScreenAdaper.width(220),
                        height: ScreenAdaper.width(220),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(ScreenAdaper.width(10)),
                            child: Image.network(
                              "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                              fit: BoxFit.cover,
                            ))),
                    Container(
                        width: ScreenAdaper.width(220),
                        height: ScreenAdaper.width(220),
                        child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(ScreenAdaper.width(10)),
                            child: Image.network(
                              "http://qcloud.dpfile.com/pc/pYPuondR-PaQO3rhSjRl7x1PBMlPubyBLeDC8IcaPQGC0AsVXyL223YOP11TLXmuTZlMcKwJPXLIRuRlkFr_8g.jpg",
                              fit: BoxFit.cover,
                            )))
                  ]),
              this._optBar()
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          this._buildTop(),
		  Container(
			  color: Colors.white,
			  height: ScreenAdaper.height(110),
			  padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
			  alignment: Alignment.centerLeft,
			  child: Text(
				  '我的动态（ 12 ）',
				  style: prefix0.TextStyle(
					  color: Color(0xff999999),
					  fontSize: ScreenAdaper.fontSize(30)
				  ),
			  ),
		  ),
          Expanded(
            child: new MediaQuery.removePadding(
              removeTop: true,
              context: context,
              child: Container(
                width: double.infinity,
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return this._itemWidget(index == 0 ? 0 : 20,index);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
