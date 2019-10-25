import 'package:flutter/material.dart';
import '../services/ScreenAdaper.dart';
class AppBarWidget  {
    Widget buildAppBar(String text,{double elevation=0}) {
        return  PreferredSize(
          child: AppBar(
              title: Text(text, style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenAdaper.fontSize(30)
              )),
              elevation: elevation,
              iconTheme: IconThemeData(color: Colors.black),
              backgroundColor: Colors.white,
              centerTitle: true,
              brightness: Brightness.light,
          ),
          preferredSize: Size.fromHeight(ScreenAdaper.height(88))
        );
    }
}