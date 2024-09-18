import 'package:flutter/material.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';
import 'package:movies_app/Ui/homeScreen/homeScreenLogic/home_screen_view_model.dart';


class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeScreenViewModel viewModel = HomeScreenViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewModel.selectIndex,
        onTap: (index) {
          setState(() {
            viewModel.selectIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.backgroundColor,
        unselectedItemColor:
        AppColors.greyColor, // Set unselected icon color to white
        selectedItemColor: AppColors.yellow, // Set background color to blue
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'HOME'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'SEARCH'),
          BottomNavigationBarItem(icon: Icon(Icons.movie), label: 'BROWSE'),
          BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark_outlined),
              label: 'WATCHLIST'),
        ],
      ),
      // Use the list and select the tab based on the current index
      body: viewModel.tabs[viewModel.selectIndex],
    );
  }
}