import 'package:movies_app/Data/Response/DetailsResponse.dart';

import 'package:movies_app/Data/Response/SimilarMoviesResponse.dart';

abstract class MovieDetailsStates{}
class MovieDetailsInitialState extends MovieDetailsStates{}
class MovieDetailsLoadingState extends MovieDetailsStates{}
class MovieDetailsSuccessState extends MovieDetailsStates{
  final DetailsResponse details;

  MovieDetailsSuccessState({required this.details});
}
class MovieDetailsErrorState extends MovieDetailsStates{
  String errorMsg;
  MovieDetailsErrorState(this.errorMsg);
}


class MovieSimilarDetailsLoadingState extends MovieDetailsStates{}
class MovieSimilarDetailsSuccessState extends MovieDetailsStates{
  final SimilarDetailsResponse similarDetails;

  MovieSimilarDetailsSuccessState({required this.similarDetails});
}
class MovieSimilarDetailsErrorState extends MovieDetailsStates{
  String errorMsg;
  MovieSimilarDetailsErrorState(this.errorMsg);
}