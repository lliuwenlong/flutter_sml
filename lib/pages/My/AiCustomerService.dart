import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
class AiCustomerService extends StatefulWidget {
  AiCustomerService({Key key}) : super(key: key);
  _AiCustomerServiceState createState() => _AiCustomerServiceState();
}

class _AiCustomerServiceState extends State<AiCustomerService> {

  //聊天
  Widget chatContent(BuildContext context, int index) {
    var value = this._chatList[index];
    return Container(
      margin: EdgeInsets.only(top: ScreenAdaper.height(30)),
      
      width: double.infinity,
      child: Stack(
        alignment: value["customer"]
            ? AlignmentDirectional.bottomEnd
            : AlignmentDirectional.topStart,
        children: <Widget>[
          Positioned(
            // right: 0,
            child: Container(
              padding: EdgeInsets.all(ScreenAdaper.width(30)),
              constraints: BoxConstraints(
                maxWidth: ScreenAdaper.width(640),
              ),
              decoration: BoxDecoration(
                  color:
                      value["customer"] ? Color(0xff22b0a1) : Color(0xffffffff),
                  borderRadius: BorderRadius.only(
                      topLeft: value["customer"]
                          ? Radius.circular(15)
                          : Radius.circular(0),
                      topRight: value["customer"]
                          ? Radius.circular(0)
                          : Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              child: Text(
                value["text"],
                style: TextStyle(
                    color: value["customer"]
                        ? Color(0xffffffff)
                        : Color(0xff666666),
                    fontSize: ScreenAdaper.fontSize(28)),
              ),
            ),
          )
        ],
      ),
    );
  }

  List<Map> _chatList = [
    {"text": "HI,你好啊，遇到什么问题可以咨询我哦~", "customer": false},
    {"text": "例如：如何购买神树？", "customer": false},
    {"text": "如何购买神树？", "customer": true},
    {
      "text":
          "在软件首页中，点击“神木基地”，进入到神木基地列表中后，可点击查看基地的神木，选择好神木后，点击进入到神木详情页面，在底部有“购买”按钮，点击“购买”后，进行支付即可。",
      "customer": false
    }
  ];

  @override
  Widget build(BuildContext context) {
  String _inputText = '';
    TextEditingController _controller = new TextEditingController.fromValue(
        TextEditingValue(
            text: _inputText,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset: _inputText.length))));
    
    ScreenAdaper.init(context);
    return Scaffold(
        appBar: AppBarWidget().buildAppBar('AI客服'),
        body: Container(
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              	Container(
					padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), 0,
						ScreenAdaper.width(30), ScreenAdaper.height(98)),
						child: ListView.builder(
							itemCount: this._chatList.length,
							itemBuilder: chatContent,
							physics: ScrollPhysics(), // scrollDirection: Axis.vertical,
							controller: ScrollController(),
						),
             	 ),
              	Positioned(
					bottom: 0,
					width: ScreenAdaper.getScreenWidth(),
					child: Container(
						color: Colors.white,
						alignment: Alignment.center,
						height: ScreenAdaper.height(98),
						padding: EdgeInsets.fromLTRB(
							ScreenAdaper.width(30),
							ScreenAdaper.height(12),
							ScreenAdaper.width(30),
							ScreenAdaper.height(12)),
						child: Container(
						height: ScreenAdaper.height(76),
						alignment: Alignment.center,
						decoration: BoxDecoration(
							color: Color(0xfff5f5f5),
							borderRadius:
								BorderRadius.circular(ScreenAdaper.width(10)),
						),
						child: TextField(
							decoration: InputDecoration(
							hintText: '有什么问题可文字发送至客服',
							hintStyle: TextStyle(
								color: Color(0xff999999),
								fontSize: ScreenAdaper.fontSize(28),
							),
							contentPadding: EdgeInsets.only(
								top: ScreenAdaper.height(4),
								left: ScreenAdaper.width(20)),
							border: InputBorder.none,
							filled: true,
							fillColor: Color(0xfff5f5f5),
							),
							controller: _controller,
							onChanged: (value) {
							setState(() {
								_inputText = value;
							});
							},
							onSubmitted: (value) {
							print(value);
							setState(() {
								this
									._chatList
									.add({"text": value, "customer": true});
							});
							_inputText = '';
							},
						),
						),
					)
				)
            ],
          ),
        ));
  }
}
