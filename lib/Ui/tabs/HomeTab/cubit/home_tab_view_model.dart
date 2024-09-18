
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Data/Response/TopRatedOrPopularResponse.dart';
import 'package:movies_app/Data/api_manager.dart';
import 'package:movies_app/Ui/tabs/HomeTab/cubit/home_tab_states.dart';

import '../../../../Data/Response/upComingResponse.dart';


class HomeTabViewModel extends Cubit<homeTabStates> {
  HomeTabViewModel() : super(HomeTabInitialState());
  List<topRatedOrPopular>? popularList;
  List<topRatedOrPopular>? topRatedList;
  List<upComing>? upComingList;
  void getAllTopRated() async {
    try {
      emit(HomeTopRatedTabLoadinglState());
      var response = await ApiManager.getAllTopRated();
      if (response.status_message == "fail") {
        emit(HomeTopRatedTabErrorState(errorMessage: response.message!));
      } else {
        topRatedList = response.results ?? [];
        emit(HomeTobRatedTabSuccessState(topRatedResponse: response));
      }
    } catch (e) {
      emit(HomeTopRatedTabErrorState(errorMessage: e.toString()));
    }
  }

  void getAllPopular() async {
    try {
      emit(HomePopularTabLoadingState());
      var response = await ApiManager.getAllPopular();
      if (response.status_message == "fail") {
        emit(HomePopularTabErrorState(errorMessage: response.message!));
      } else {
        popularList = response.results ?? [];
        emit(HomePopularTabSuccessState(popularResponse: response));
      }
    } catch (e) {
      emit(HomePopularTabErrorState(errorMessage: e.toString()));
    }
  }

  void getAllUpComing() async {
    try {
      emit(HomeUpComingTabLoadingState());
      var response = await ApiManager.getAllUpComing();
      if (response.status_message == "fail") {
        emit(HomeUpComingTabErrorState(errorMessage: response.message!));
      } else {
        upComingList = response.results ?? [];
        emit(HomeUpComingTabSuccessState(upComingResponse: response));
      }
    } catch (e) {
      emit(HomeUpComingTabErrorState(errorMessage: e.toString()));
    }
  }
}