
import 'package:movies_app/Data/Response/TopRatedOrPopularResponse.dart';

import '../../../../Data/Response/upComingResponse.dart';


abstract class homeTabStates {}

class HomeTabInitialState extends homeTabStates {}

class HomeTopRatedTabLoadinglState extends homeTabStates {}

class HomeTopRatedTabErrorState extends homeTabStates {
  String errorMessage;
  HomeTopRatedTabErrorState({required this.errorMessage});
}

class HomeTobRatedTabSuccessState extends homeTabStates {
  TopRatedOrPopularResponse topRatedResponse;
  HomeTobRatedTabSuccessState({required this.topRatedResponse});
}

class HomePopularTabLoadingState extends homeTabStates {}

class HomePopularTabErrorState extends homeTabStates {
  String errorMessage;
  HomePopularTabErrorState({required this.errorMessage});
}

class HomePopularTabSuccessState extends homeTabStates {
  TopRatedOrPopularResponse popularResponse;
  HomePopularTabSuccessState({required this.popularResponse});
}

class HomeUpComingTabLoadingState extends homeTabStates {}

class HomeUpComingTabErrorState extends homeTabStates {
  String errorMessage;
  HomeUpComingTabErrorState({required this.errorMessage});
}

class HomeUpComingTabSuccessState extends homeTabStates {
  UpComingResponse upComingResponse;
  HomeUpComingTabSuccessState({required this.upComingResponse});
}