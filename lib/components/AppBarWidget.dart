import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
class AppBarWidget  {
    Widget buildAppBar(String text,{double elevation=1.0}) {
        return AppBar(
            title: Text(text, style: TextStyle(
                color: Colors.black,
                fontSize: ScreenAdaper.fontSize(34)
            )),
            elevation: elevation,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            centerTitle: true,
            brightness: Brightness.light
        );
    }
}