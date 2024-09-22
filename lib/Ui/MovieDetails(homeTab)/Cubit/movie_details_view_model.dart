import 'dart:convert';
import 'dart:ffi';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Data/Response/DetailsResponse.dart';
import 'package:movies_app/Data/api_manager.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/Cubit/movie_states.dart';


class MovieDetailsViewModel extends Cubit<MovieDetailsStates> {

  MovieDetailsViewModel() : super(MovieDetailsInitialState());

  Future<void> getAllDetails(int movieId) async {
    emit(MovieDetailsLoadingState());
    try {
      final movieDetails = await ApiManager.getAllDetails(movieId);
      emit(MovieDetailsSuccessState(details: movieDetails));
    } catch (e) {
      emit(MovieDetailsErrorState("An error occurred: $e"));
    }
  }

  Future<void> getAllSimilarDetails(int movieId) async {
    emit(MovieSimilarDetailsLoadingState());
    try {
      final similarDetails = await ApiManager.getAllSimilarDetails(movieId);
      emit(MovieSimilarDetailsSuccessState(similarDetails: similarDetails));
    } catch (e) {
      emit(MovieSimilarDetailsErrorState("An error occurred: $e"));
    }
  }
}