import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/Cubit/movie_details_view_model.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/Cubit/movie_states.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;

  MovieDetailsScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsViewModel()..getAllDetails(movieId),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Movie Details'),
        ),
        body: BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
          builder: (context, state) {
            if (state is MovieDetailsLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MovieDetailsSuccessState) {
              final movie = state.details;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        movie.title!,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(movie.overview!),
                    ),

                  ],
                ),
              );
            } else if (state is MovieDetailsErrorState) {
              return Center(child: Text(state.errorMsg));
            } else {
              return Center(child: Text('found  unexpected error'));
            }
          },
        ),
      ),
    );
  }
}