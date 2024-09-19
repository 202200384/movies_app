
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Ui/homeScreen/homeScreenLogic/home_states.dart';
import 'package:movies_app/Ui/tabs/BrowserTab/Widget/browser_tab_screen.dart';

import 'package:movies_app/Ui/tabs/HomeTab/Widgets/homeTab.dart';

import 'package:movies_app/Ui/tabs/SearchTab/search_screen_tab.dart';
import 'package:movies_app/Ui/tabs/WatchTab/watch_list_Tab.dart';



class HomeScreenViewModel extends Cubit<HomeScreenStates> {
  HomeScreenViewModel() : super(HomeInitialState());
  int selectIndex = 0;

  // Define the list of tabs here
  final List<Widget> tabs = [
    HomeTab(),
    SearchScreenTab(),
    BrowserTabScreen(),
    WatchlistTab()
  ];
  void changeSelectedIndex(int newIndex) {
    emit(HomeInitialState());
    selectIndex = newIndex;
    emit(ChangeSelectedIndexState());
  }
}