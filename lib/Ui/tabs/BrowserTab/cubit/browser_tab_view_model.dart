import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Data/Response/BrowserResponse.dart';
import 'package:movies_app/Data/Response/BrowserDiscoveryResponse.dart';
import 'package:movies_app/Data/api_manager.dart';
import 'package:movies_app/Ui/tabs/BrowserTab/cubit/browser_tab_states.dart';

class BrowserTabViewModel extends Cubit<BrowserTabStates> {
  List<Browser>? _cachedGenres;
  List<Results>? _cachedDiscoveryMovies;


  List<Browser>? get cachedGenres => _cachedGenres;
  List<Results>? get cachedDiscoveryMovies => _cachedDiscoveryMovies;

  BrowserTabViewModel() : super(BrowserTabInitialState());

  Future<void> getAllMovieList() async {
    if (_cachedGenres != null && _cachedGenres!.isNotEmpty) {
      emit(BrowserTabSuccessState(browserResponse: BrowserResponse(genres: _cachedGenres)));
      return;
    }
    try {
      emit(BrowserTabLoadinglState());
      var response = await ApiManager.getAllMovieList();
      if (response.status_message == "fail") {
        emit(BrowserTabErrorState(errorMessage: response.message!));
      } else {
        _cachedGenres = response.genres ?? [];
        emit(BrowserTabSuccessState(browserResponse: response));
      }
    } catch (e) {
      emit(BrowserTabErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getAllDiscoveryMovieList(String genreId) async {
    if (_cachedDiscoveryMovies != null && _cachedDiscoveryMovies!.isNotEmpty) {
      emit(BrowserDiscoveryTabSuccessState(browserDiscoveryResponse: BrowserDiscoveryResponse(results: _cachedDiscoveryMovies)));
      return;
    }
    try {
      emit(BrowserDiscoveryTabLoadinglState());
      var response = await ApiManager.getAllDiscoveryMovieList(genreId);
      if (response.status_message == "fail") {
        emit(BrowserDiscoveryTabErrorState(errorMessage: response.status_message ?? 'Unknown error'));
      } else {
        _cachedDiscoveryMovies = response.results ?? [];
        emit(BrowserDiscoveryTabSuccessState(browserDiscoveryResponse: response));
      }
    } catch (e) {
      emit(BrowserDiscoveryTabErrorState(errorMessage: e.toString()));
    }
  }
}