import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';

class AppFuncBrowse extends StatefulWidget {
    AppFuncBrowse({Key key}) : super(key: key);
    _AppFuncBrowseState createState() => _AppFuncBrowseState();
}

class _AppFuncBrowseState extends State<AppFuncBrowse> {
    PageController _pageController = PageController();
    int _pageIndex = 0;


    Widget _dotWidget(int index) {
        return Container(
            width: ScreenAdaper.width(12),
            height: ScreenAdaper.width(12),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: (_pageIndex == index) ? Color(0xFF666666) : Color(0xFFd9d9d9))
            );
    }

    @override
    Widget build(BuildContext context) {
        ScreenAdaper.init(context);
        return Scaffold(
            body: Container(
                child: Stack(
                    children: <Widget>[
                        PageView(
                            controller: _pageController,
                            onPageChanged: (pageIndex) {
                                setState(() {
                                    _pageIndex = pageIndex;
                                });
                            },
                            children: <Widget>[
                                Container(
                                    color: Colors.green,
                                    child: Center(
                                        child: Text('Page 3'),
                                    ),
                                ),
                                Container(
                                    color: Colors.red,
                                    child: Center(
                                        child: Text('Page 3'),
                                    ),
                                ),
                                Container(
                                    color: Colors.yellow,
                                    child: Center(
                                        child: Text('Page 3'),
                                    ),
                                )
                            ]
                        ),
                        Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: Container(
                                width: ScreenAdaper.width(90),
                                padding: EdgeInsets.only(
                                    bottom: ScreenAdaper.height(80)
                                ),
                                child: Container(
                                    width: ScreenAdaper.width(68),
                                    child:  Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                            _dotWidget(0),
                                            _dotWidget(1),
                                            _dotWidget(2)
                                        ]
                                    ),
                                ),
                            ),
                        )
                    ]
                ),
            ),
        );
    }
}