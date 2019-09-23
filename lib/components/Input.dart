import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
import '../common/Color.dart';
class Input extends StatefulWidget {
    final String hintText;
    final bool isPwd;
    final bool isShowSuffixIcon;
    final bool showBorder;
    final String errorText;
    final TextInputType type;
    Function onSave;
    Function validate;
    Function onChange;
    TextEditingController controller;
    Input(
        this.hintText,
        {
            Key key,
            this.isPwd = false,
            this.isShowSuffixIcon = false,
            this.showBorder = true,
            this.errorText,
            this.onSave,
            this.validate,
            this.onChange,
            this.controller,
            this.type
        }
    ) : super(key: key);
    _InputState createState() => _InputState(onSave: onSave, controller: controller);
}

class _InputState extends State<Input> {
    static String _inputText = "";
    Function onSave;
    TextEditingController controller;
    TextEditingController input;
    bool isShowIcon = true;
    String _value = "";
    _InputState ({this.onSave, controller}) {
        this.input = controller != null ? controller : TextEditingController.fromValue(
            TextEditingValue(
                text: _inputText
            )
        );
    }

    @override
    void initState() {
        super.initState();
        this._value = input.text;
        input.addListener(() {
            this._onChanged(input.text);
        });
    }

    @override
    void dispose() {
        super.dispose();
        input.notifyListeners();
    }

    _onChanged (value) {
        if (isShowIcon == value.isEmpty) {
            return;
        }
        setState(() {
            isShowIcon = value.isEmpty;
        });
    }

    String getValue() => _value;

    @override
    Widget build(BuildContext context) {
        return Container(
            child: TextFormField(
                obscureText: widget.isPwd,
                controller: input,
                keyboardType: widget.type,
                keyboardAppearance: Brightness.light,
                style: TextStyle(
                    color: ColorClass.titleColor,
                    fontSize: ScreenAdaper.fontSize(30)
                ),
                cursorColor: ColorClass.common,
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
                    errorText: widget.errorText,
                    errorStyle: TextStyle(
                        fontSize: ScreenAdaper.fontSize(30),
                        color: ColorClass.fontRed
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                        borderSide: widget.showBorder ? BorderSide(
                            color: Color(0xFFfb4135),
                            width: 1
                        ) : BorderSide.none
                    ),
                    errorBorder:  UnderlineInputBorder(
                        borderSide: widget.showBorder ? BorderSide(
                            color: Color(0xFFfb4135),
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
                onSaved: widget.onSave,
                validator: widget.validate,
            ),
        );
    }
}