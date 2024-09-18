import 'package:flutter/material.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';


class SearchScreenTab extends StatelessWidget {
  static const String routeName = "search";
  const SearchScreenTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      appBar: AppBar(
        title: Text("searchScreenTab"),
      ),
    );
  }
}