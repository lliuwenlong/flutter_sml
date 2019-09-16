import 'package:flutter/material.dart';
class ViewDialog extends StatefulWidget {
  ViewDialog({Key key, this.img, this.imgs}) : super(key: key);
  final img;
  final imgs;

  @override
  _PageStatus createState() => _PageStatus();
}

class _PageStatus extends State<ViewDialog> {
  var image;
  var index = 1;
  var _scrollController;
  var down = 0.0; //触开始的时候的left
  var half = false; //是否超过一半

  last() {
    if(1 == index) {
      // 说明左边已无图片
    }else {
      setState(() {
        image = widget.imgs[index - 2];
        index = index - 1;
      });
    }
  }

  next() {
    if(widget.imgs.length == index) {

    }else {
      setState(() {
        image = widget.imgs[index];
        index = index + 1;
      });
    }
  }

  // 隐藏或者返回
  delete() {
    Navigator.pop(context);
  }
  
  @override
  void initState() {
    //页面初始化
    super.initState();
    print('测试widget.imgs');
    // print(widget.imgs);
    var nn = 1; // 数字标示默认从第一张开始
    for(int i = 0; i<widget.imgs.length; i++){
      if(widget.imgs[i]['url'] == widget.img) {
        nn = i+1;
        break;
      }
    }
    
    setState(() {
      image = widget.img;
      index = nn;
    });
  }

  // 下一张图片
  nextPage(w) {
    setState(() {
      index = index + 1;
      _scrollController.animateTo(
        (index -1) * w,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  // 上一张图片
  lastPage(w) {
    setState(() {
      index = index - 1;
      _scrollController.animateTo(
        (index - 1) * w,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  moveEnd(e,w,l) {
    var end = e.primaryVelocity;
    if(end > 10 && index > 1) {
      lastPage(w);
    }else if(end < -10 && index < l){
      nextPage(w);
    }else if(half == true){
      if(down > w/2 && index < l) {
        //右边开始滑动超过一半,则下一张
        nextPage(w);
      }else if(down < w/2 && index > 1){
        lastPage(w);
      }else {
        _scrollController.animateTo(
          (index -1) * w,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
      }
    }else {
      _scrollController.animateTo(
        (index -1) * w,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
  }

  // 监听图片的移动判断是否需要切换图片
  imgMove(e,w,l) {
    //down 为起点的距离
    var left = e.position.dx;
    var now = (index -1 ) * w;
    var move = left - down;//移动距离
    if(left - down > w/2 || down - left > w/2) {
      half = true;
    }else {
      half = false;
    }
    _scrollController.jumpTo(now - move);
  }

  // 绘制图片列表
  Widget list(w,l) {

    // 修改滑动到第几张图片
    if(index > 1) {
      _scrollController = ScrollController(
        initialScrollOffset: w * (index - 1)
      );
    }else {
      _scrollController = ScrollController(
        initialScrollOffset: 0,
      );
    }

    // 绘制列表
    List<Widget> array = [];
    widget.imgs.forEach((i) {
      array.add(
        Listener(
          onPointerMove: (e) {
            imgMove(e,w,l);
          },
          onPointerDown: (e) {
            down = e.position.dx;
          },
          child: GestureDetector(
            onTap: (){
              // Navigator.pop(context);
            },
            onHorizontalDragEnd: (e) {moveEnd(e,w,l);},
            child: Container(
              width: w,
              child: i['url'] != null ? Image.network(i['url']) : Image.file(i['file']),
            ),
          ),
        ),
      );
    });
    return ListView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      children: array,
    );
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var length = widget.imgs.length;
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          list(w,length),
          // 数字标示
          Positioned(
            top: 50,
            child: Container(
              alignment: Alignment.center,
              width: w,
              child: Text('$index/$length',style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,fontSize: 16,
                fontWeight: FontWeight.w400,
                shadows: [
                  Shadow(color: Colors.black, offset: Offset(1, 1)),
                ],
              ))
            ),
          ),
          // 删除图标的布局
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              alignment: Alignment.centerLeft,
              width: 20,
              child: GestureDetector(
                onTap: () {delete();},
                child: Icon(Icons.delete,color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}