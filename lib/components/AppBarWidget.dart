import 'package:flutter/material.dart';
class AppBarWidget  {
    Widget buildAppBar(String text) {
        return AppBar(
            title: Text(text, style: TextStyle(
                color: Colors.black,
            )),
            elevation: 1,
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            centerTitle: true,
            brightness: Brightness.light
        );
    }
}