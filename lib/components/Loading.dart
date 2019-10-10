import 'package:flutter/material.dart';
import 'package:flutter_sml/common/Color.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class Loading extends StatelessWidget {
    const Loading({Key key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Container(
            child: new Center(
                child: SpinKitThreeBounce(
                    color: ColorClass.common,
                    size: 30.0,
                ),
            )
        );
    }
}