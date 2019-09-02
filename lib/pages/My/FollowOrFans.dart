import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../common/Color.dart';

class FollowOrFans extends StatefulWidget {
  final Map arguments;
  FollowOrFans({Key key, this.arguments}) : super(key: key);

  _FollowOrFansState createState() =>
      _FollowOrFansState(arguments: this.arguments);
}

class _FollowOrFansState extends State<FollowOrFans> with SingleTickerProviderStateMixin {
  final List<Map> _tabList = [
    {"id": 1, "name": "我的关注"},
    {"id": 2, "name": "我的粉丝"},
  ];
  final Map arguments;
  int _currentIndex;
  _FollowOrFansState({this.arguments});
  TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = (this.arguments.isNotEmpty)?this.arguments['index']:0;
    _tabController = new TabController(vsync: this, length: 2,initialIndex: _currentIndex);
  }


  Widget _listItem(String imageUrl,String nickName,String text){
    return  Container(
      padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30)),
      height: ScreenAdaper.height(126),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: ScreenAdaper.height(43),
                  backgroundImage: NetworkImage(imageUrl),
                ),
                SizedBox(width: ScreenAdaper.width(30)),
                Text(
                  nickName,
                  style: TextStyle(
                    color: Color(0xff333333),
                    fontSize: ScreenAdaper.fontSize(34)
                  ),
                )
              ],
            ),

            GestureDetector(
              onTap: (){},
              child: Container(
                width: ScreenAdaper.width(160),
                height: ScreenAdaper.height(60),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xff22b0a1),
                    width: ScreenAdaper.width(2)
                  ),
                  borderRadius: BorderRadius.circular(ScreenAdaper.width(10))
                ),
                child: Text(
                  text,
                  style: TextStyle(
                    color: Color(0xff22b0a1),
                    fontSize: ScreenAdaper.fontSize(30)
                  ),
                ),
              ),
            )

        ],
      ),
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          iconTheme:IconThemeData(color: Colors.black),
          title: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorWeight: ScreenAdaper.height(6),
                  indicatorColor: Color(0XFF22b0a1),
                  controller: this._tabController,
                  isScrollable: true,
                  unselectedLabelColor: ColorClass.fontColor,
                  unselectedLabelStyle: TextStyle(
                      fontSize: ScreenAdaper.fontSize(30),
                      fontWeight: FontWeight.w500),
                  labelColor: ColorClass.titleColor,
                  labelStyle: TextStyle(
                      fontSize: ScreenAdaper.fontSize(34),
                      fontWeight: FontWeight.w600),
                  tabs: this._tabList.map((val) {
                    return Tab(child: Text(val['name']));
                  }).toList(),
                ),
              )
            ],
          ),
          backgroundColor: Colors.white,
          brightness: Brightness.light,
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
              color: Colors.white,
              child: ListView(
              children: <Widget>[
                this._listItem('https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws', '梅西123', '取消关注'),
                this._listItem('http://pic30.nipic.com/20130619/9885883_210838271000_2.jpg', '小胖胖家的', '取消关注'),
                this._listItem('http://pic21.nipic.com/20120522/9961772_184043382124_2.jpg', '玻璃心', '取消关注'),
                this._listItem('http://pic41.nipic.com/20140524/9643307_104442624152_2.jpg', '秋天的蜂', '取消关注')
              ],
            ),
            ),
            Container(
              padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
              color: Colors.white,
              child: ListView(
              children: <Widget>[
                this._listItem('https://dpic.tiankong.com/pa/7s/QJ8189390931.jpg?x-oss-process=style/670ws', 'Amy 丽', '关注'),
                this._listItem('http://pic41.nipic.com/20140524/9643307_104442624152_2.jpg', 'Amy 丽', '关注'),
              ],
            ),
            )
          ],
        ));
  }
}
