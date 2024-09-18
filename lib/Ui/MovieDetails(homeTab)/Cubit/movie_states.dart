import 'package:movies_app/Data/Response/DetailsResponse.dart';
import 'package:movies_app/Data/Response/SimilarDetailsResponse.dart';

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

class MovieDetailsSimilarLoadingState extends MovieDetailsStates{}
class MovieDetailsSimilarSuccessState extends MovieDetailsStates{
  final SimilarDetailsResponse details;
  MovieDetailsSimilarSuccessState({required this.details});
}
class MovieDetailsSimilarErrorState extends MovieDetailsStates{
  String errorMsg;
  MovieDetailsSimilarErrorState(this.errorMsg);
}
