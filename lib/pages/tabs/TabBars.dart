import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import './FriendDynamics.dart';
import './Home.dart';
import './My.dart';
import './News.dart';
import './Shop.dart';

class TabBars extends StatefulWidget {
    TabBars({Key key}) : super(key: key);
    _TabBarsState createState() => _TabBarsState();
}

class _TabBarsState extends State<TabBars> {
    int _currentIndex = 0;
    List _pages = [
        HomePage(),
        ShopPage(),
        FriendDynamicsPage(),
        NewsPage(),
        MyPage()
    ];
    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            bottomNavigationBar: this._buildTabBars(),
            body: this._pages[this._currentIndex],
        );
    }

    Widget _buildTabBars () {
        return BottomNavigationBar(
            currentIndex: this._currentIndex,
            fixedColor: const Color(0xFF21b9a9),
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(
                        IconData(0xe614, fontFamily: 'iconfont'),
                        size: ScreenAdaper.fontSize(48)
                    ),
                    title: Text("首页")
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        IconData(0xe615, fontFamily: 'iconfont'),
                        size: ScreenAdaper.fontSize(48)
                    ),
                    title: Text("商城")
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        IconData(0xe618, fontFamily: 'iconfont'),
                        size: ScreenAdaper.fontSize(48)
                    ),
                    title: Text("树友圈")
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        IconData(0xe619, fontFamily: 'iconfont'),
                        size: ScreenAdaper.fontSize(48)
                    ),
                    title: Text("消息")
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                        IconData(0xe61c, fontFamily: 'iconfont'),
                        size: ScreenAdaper.fontSize(48)
                    ),
                    title: Text("我的")
                )
                
            ],
            onTap: (int index) {
                setState(() {
                    this._currentIndex = index;
                });
            }
        );
    }
}