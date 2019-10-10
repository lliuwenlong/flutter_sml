import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';
import '../../common/HttpUtil.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import '../../common/Color.dart';

class AiCustomerService extends StatefulWidget {
  AiCustomerService({Key key}) : super(key: key);
  _AiCustomerServiceState createState() => _AiCustomerServiceState();
}

class _AiCustomerServiceState extends State<AiCustomerService> {
  	final HttpUtil http = HttpUtil();
	List<dynamic> _chatList = [];
//发送消息
 	_sendMessage (BuildContext context) async {
	    Map response = await this.http.post('/api/v1/faq', data:{
		   'question':_controller.text
	    });
		if(response['code']== 200){
			setState(() {
				this._chatList.add({
					"text": response['data'],
					"customer": false
				});
        this._commentFocus.unfocus();
        int len = this._chatList.length;
        this._scrollController.animateTo(
            context.size.height*len,
            duration: Duration(milliseconds: 1000),
            curve: Curves.ease
        );
        
			});
		}
  	}
 ScrollController _scrollController = new ScrollController();
@override
void didChangeDependencies() {
	super.didChangeDependencies();
  
}
  bool isOpenKeyboard = false;
  bool isDisabled = false;
    FocusNode _commentFocus = FocusNode();

    @override
    void initState() { 
      super.initState();
      KeyboardVisibilityNotification().addNewListener(
            onChange: (bool visible) {
                print(visible);
                if (!visible) {
                    setState(() {
                        this.isOpenKeyboard = false;
                    });
                };
            },
        );
    }
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

  Widget _editInput () {
        return Container(
            padding: EdgeInsets.all(ScreenAdaper.width(30)),
            child: Column(
                children: <Widget>[
                    TextField(
                        focusNode: _commentFocus,
                        autofocus: true,
                        maxLines: 4,
                        controller: _controller,
                        onChanged: (String val) {
                            if (val.isNotEmpty) {
                                setState(() {
                                    this.isDisabled = true;
                                });
                            } else {
                                setState(() {
                                    this.isDisabled = false;
                                });
                            }
                        },
                        decoration: InputDecoration(
                            fillColor: Color(0xFFf5f5f5),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.fromLTRB(
                                ScreenAdaper.width(30),
                                ScreenAdaper.width(25),
                                ScreenAdaper.width(30),
                                ScreenAdaper.width(25)
                            ),
                            hintText: "有什么问题可文字发送至客服",
                            hintStyle: TextStyle(
                                color: ColorClass.subTitleColor,
                                fontSize: ScreenAdaper.fontSize(28)
                            )
                        ),
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(
                            top: ScreenAdaper.height(20)
                        ),
                        child: Container(
                            width: ScreenAdaper.width(160),
                            height: ScreenAdaper.height(75),
                            child: RaisedButton(
                                color: ColorClass.common,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                                ),
                                elevation: 0,
                                disabledColor: Color(0xFF86d4ca),
                                onPressed: this.isDisabled ? (){
                                  setState(() {
                                    String value = _controller.text;
                                    this._chatList.add({"text": value, "customer": true});
                                    _controller.text = '';
                                    int len = this._chatList.length;
                                    this._sendMessage(context);
                                    this._scrollController.animateTo(
                                      context.size.height*len,
                                      duration: Duration(milliseconds: 1000),
                                      curve: Curves.ease
                                    );
                                });
                           
                                } : null,
                                child: Text("发送", style: TextStyle(
                                    fontSize: ScreenAdaper.fontSize(32),
                                    color: Colors.white
                                )),
                            ),
                        ),
                    )
                ],
            ),
        );
    }

   Widget _readInput () {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                            setState(() {
                                this.isOpenKeyboard = true;
                            });
                        },
                        child: Container(
                            height: ScreenAdaper.height(75),
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(
                                left: ScreenAdaper.width(30),
                                right: ScreenAdaper.width(30),
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xFFf5f5f5),
                                borderRadius: BorderRadius.circular(ScreenAdaper.width(10)),
                            ),
                            child: Text("有什么问题可文字发送至客服", style: TextStyle(
                                color: Color(0xFF999999),
                                fontSize: ScreenAdaper.fontSize(28)
                            ))
                        )
                    )
                ),
            ],
        );
    }

	// static String _inputText = '';
    TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
        appBar: AppBarWidget().buildAppBar('AI客服'),
        body: SafeArea(
          bottom: true,
          child: Container(
            width: double.infinity,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(ScreenAdaper.width(30), 0,
                      ScreenAdaper.width(30), ScreenAdaper.height(98)),
                  child: ListView.builder(
                    itemCount: this._chatList.length,
                    itemBuilder: chatContent,
                    controller:_scrollController,
                  ),
                ),
                Positioned(
                    bottom: 0,
                    width: ScreenAdaper.getScreenWidth(),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 1)
                            ]
                        ),
                        padding: EdgeInsets.fromLTRB(
                            ScreenAdaper.width(20),
                            ScreenAdaper.height(10),
                            ScreenAdaper.width(20),
                            ScreenAdaper.height(10)
                        ),
                        width: double.infinity,
                        child: !this.isOpenKeyboard
                            ? this._readInput()
                            : this._editInput()
                    )
                )
              ],
            ),
          ),
        ));
  }
}
