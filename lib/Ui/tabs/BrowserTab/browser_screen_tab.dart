
import 'package:flutter/material.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';

class BrowserTabScreen extends StatelessWidget {
  static const String routeName = "browser";
  const BrowserTabScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        title: Text("BrowserScreenTab"),
      ),
    );
  }
}