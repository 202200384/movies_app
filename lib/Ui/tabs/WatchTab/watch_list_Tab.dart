import 'package:flutter/material.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';


class WatchlistTab extends StatelessWidget {
  static const String routeName = "watch_list";
  const WatchlistTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
    );
  }
}