import 'package:flutter/material.dart';
import '../../services/ScreenAdaper.dart';
import '../../components/AppBarWidget.dart';

class AiCustomerService extends StatefulWidget {
  AiCustomerService({Key key}) : super(key: key);

  _AiCustomerServiceState createState() => _AiCustomerServiceState();
}

class _AiCustomerServiceState extends State<AiCustomerService> {
  @override
  Widget build(BuildContext context) {
    ScreenAdaper.init(context);
    return Scaffold(
      appBar: AppBarWidget().buildAppBar('AI客服'),
      body:Container(
        
      )
    );
  }
}