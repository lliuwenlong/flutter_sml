import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import '../common/Color.dart';
class Input extends StatefulWidget {
    final String hintText;
    final bool isPwd;
    final bool isShowSuffixIcon;
    final bool showBorder;
    Input(
        this.hintText,
        {
            Key key,
            this.isPwd = false,
            this.isShowSuffixIcon = false,
            this.showBorder = true,
        }
    ) : super(key: key);
    _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
    static String _inputText = "";
    TextEditingController input = TextEditingController.fromValue(
        TextEditingValue(
            text: _inputText
        )
    );
    bool isShowIcon = true;
    @override
    void initState() {
        super.initState();
    }
    @override
    Widget build(BuildContext context) {
        return Container(
            child: TextField(
                obscureText: widget.isPwd,
                controller: input,
                style: TextStyle(
                    color: ColorClass.titleColor,
                    fontSize: ScreenAdaper.fontSize(30)
                ),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15.0),
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                        color: Color(0XFFaaaaaa)
                    ),
                    suffixIcon: isShowIcon || !widget.isShowSuffixIcon ? null : IconButton(
                        onPressed: (){
                            setState(() {
                                input.text = "";
                                isShowIcon = true;
                            });
                        },
                        splashColor: Color.fromRGBO(0, 0, 0, 0),
                        icon: Icon(
                            IconData(0Xe620,  fontFamily: "iconfont"),
                            color: Color(0XFFd9d9d9),
                            size: ScreenAdaper.fontSize(30)
                        )
                    ),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: widget.showBorder ? BorderSide(
                            color: Color(0XFFd9d9d9),
                            width: 1
                        ) : BorderSide.none
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: widget.showBorder ? BorderSide(
                            color: Color(0XFFd9d9d9),
                            width: 1
                        ) : BorderSide.none
                    ),
                    border: UnderlineInputBorder(
                        borderSide: widget.showBorder ? BorderSide(
                            color: Color(0XFFd9d9d9),
                            width: 1
                        ) : BorderSide.none
                    )
                ),
                onChanged: (value) {
                    if (isShowIcon == value.isEmpty) {
                        return;
                    }
                    setState(() {
                        isShowIcon = value.isEmpty;
                    });
                }
            ),
        );
    }
}