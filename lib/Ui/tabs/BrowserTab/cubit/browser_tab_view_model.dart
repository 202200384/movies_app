import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Data/Response/BrowserResponse.dart';
import 'package:movies_app/Data/Response/BrowserDiscoveryResponse.dart'; // تم إضافته
import 'package:movies_app/Data/api_manager.dart';
import 'package:movies_app/Ui/tabs/BrowserTab/cubit/browser_tab_states.dart';


class BrowserTabViewModel extends Cubit<BrowserTabStates> {
  BrowserTabViewModel() : super(BrowserTabInitialState());
  List<Browser>? browserList;
  List<Results>? discoveryMoviesList;


  void getAllMovieList() async {
    if(browserList !=null && browserList!.isNotEmpty){
      emit(BrowserTabSuccessState(browserResponse: BrowserResponse(genres: browserList)));
      return;
    }
    try {
      emit(BrowserTabLoadinglState());
      var response = await ApiManager.getAllMovieList();
      if (response.status_message == "fail") {
        emit(BrowserTabErrorState(errorMessage: response.message!));
      } else {
        browserList = response.genres ?? [];
        emit(BrowserTabSuccessState(browserResponse: response));
      }
    } catch (e) {
      emit(BrowserTabErrorState(errorMessage: e.toString()));
    }
  }


  void getAllDiscoveryMovieList(String genderId) async {
    if(discoveryMoviesList != null && discoveryMoviesList!.isNotEmpty){
      emit(BrowserDiscoveryTabSuccessState(
          browserDiscoveryResponse:BrowserDiscoveryResponse(results: discoveryMoviesList)));
      return;
    }
    try {
      emit(BrowserDiscoveryTabLoadinglState());
      var response = await ApiManager.getAllDiscoveryMovieList( genderId);
      if (response.status_message == "fail") {
        emit(BrowserDiscoveryTabErrorState(errorMessage: response.status_message ?? 'Unknown error'));
      } else {
        discoveryMoviesList = response.results ?? [];
        emit(BrowserDiscoveryTabSuccessState(browserDiscoveryResponse: response));
      }
    } catch (e) {
      emit(BrowserDiscoveryTabErrorState(errorMessage: e.toString()));
    }
  }
}