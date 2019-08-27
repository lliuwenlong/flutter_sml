import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
class Introduction extends StatefulWidget {
  Introduction({Key key}) : super(key: key);
  _IntroductionState createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
    VideoPlayerController _controller;
    bool _isInit = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.asset('videos/video.mp4');
    _controller.initialize().then((value){
       ///调用setState方法重绘UI
        setState(() {
          ///判断是否初始化
          _isInit = _controller.value.initialized;
        });
    });

  }
  ///视频正在加载的界面
  Widget _buildInitingWidget(){
    return AspectRatio(
      aspectRatio: 16/9,
      child: Stack(
        children: <Widget>[
          VideoPlayer(_controller),
          ///健在进度框
          const Center(child: CircularProgressIndicator()),
        ],
        fit: StackFit.expand,
      ),
    );
  }

  Widget _buildPlayingWidget(){
    return  Container(
            child: Chewie(
              controller: ChewieController(
                videoPlayerController: _controller,
                aspectRatio:16/9,
                placeholder: new Container(
                      color: Colors.grey,
                ),
                materialProgressColors: new ChewieProgressColors(
                  playedColor: Color(0xff22b0a1),
                  handleColor: Color(0xff22b0a1),
                  backgroundColor: Colors.grey,
                  bufferedColor: Colors.lightGreen,
                 ),
              ),
            ),
        );
  }
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
       return Scaffold(
         appBar: AppBarWidget().buildAppBar('公司简介'),
         body: Container(
           color: Colors.white,
           padding: EdgeInsets.only(left: ScreenAdaper.width(30),right: ScreenAdaper.width(30),top: ScreenAdaper.height(23)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text(
                  '${this._isInit}贵州绿建实业有限公司于2018年5月成立,公司注册资金为10000万元，为义龙新区财政出资成立的集城市园林绿化和市政设施规划设计、建设、运营与管理为一体的正科级级别国有独资公司，隶属于义龙新区管理委员会，代表新区管委管理所辖国有资产并进行国有资本运营。',
                  style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: ScreenAdaper.fontSize(26)
                  ),
                ),
              ),
              SizedBox(height: ScreenAdaper.height(18),),
              AspectRatio(
               aspectRatio: 16/9,
               child: _isInit ? _buildPlayingWidget(): _buildInitingWidget()
 
              ),
              SizedBox(height: ScreenAdaper.height(22)),
              Container(
                child: Text(
                  '充值1000元成为神木林守护会员，赠送一棵名贵树种一年，名贵树种周围数十平方左右土地可以免费使用，种植名贵中草药等均归认属对象所有；同时还赠送价值5136元的12张酒店住宿券和12张餐饮优惠券，最后还赠送一张神木林尊享会员超级黑卡，享受神木林系列酒店，神木林系列餐饮、神木林系列体验项目、神木林系列文创产品、旅游折上折优惠。',
                  style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: ScreenAdaper.fontSize(26)
                  ),
                ),
              ),
              SizedBox(height: ScreenAdaper.height(50)),
              Container(
                width: double.infinity,
                child: Text(
                  '神木林守护会员办理咨询电话：0859-3567373',
                  style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: ScreenAdaper.fontSize(26)
                  ),
                ),
              ),
              SizedBox(height: ScreenAdaper.height(10)),
              Container(
                width: double.infinity,
                child: Text(
                  '鲁屯古镇LED显示屏招租热线：18143508884',
                  style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: ScreenAdaper.fontSize(26)
                  ),
                ),
              ),
                SizedBox(height: ScreenAdaper.height(10)),
              Container(
                width: double.infinity,
                child: Text(
                  '鲁屯神木驿站预定电话韦掌柜：15339541555',
                  style: TextStyle(
                    color: Color(0xff666666),
                    fontSize: ScreenAdaper.fontSize(26),
                  ),
                ),
              )
            ],
          ),
         ),
       );
    
  }
}



