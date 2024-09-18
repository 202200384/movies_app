import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Data/Response/DetailsResponse.dart';
import 'package:movies_app/Data/api_manager.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/Cubit/movie_states.dart';


class MovieDetailsViewModel extends Cubit<MovieDetailsStates> {
  MovieDetailsViewModel() : super(MovieDetailsInitialState());

  void getAllDetails(int movieId) async {
    emit(MovieDetailsLoadingState());
    try {
      final movieDetails = await ApiManager.getAllDetails(movieId);
      emit(MovieDetailsSuccessState(details: movieDetails));
    } catch (e) {
      emit(MovieDetailsErrorState("An error occurred: $e"));
    }
  }

  void getAllSimilarDetails(int movieId) async {
    emit(MovieDetailsLoadingState());
    try {
      final similarDetails = await ApiManager.getAllSimilarDetails(movieId);
      emit(MovieDetailsSimilarSuccessState(details: similarDetails));
    } catch (e) {
      emit(MovieDetailsErrorState("An error occurred: $e"));
    }
  }
}