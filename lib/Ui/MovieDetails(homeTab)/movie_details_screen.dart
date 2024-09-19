import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/Cubit/movie_details_view_model.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/Cubit/movie_states.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';

class MovieDetailsScreen extends StatelessWidget {
  static const String routeName = 'movie_details';
  final int movieId;
  MovieDetailsScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MovieDetailsViewModel()
        ..getAllDetails(movieId)
        ..getAllSimilarDetails(movieId),
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.white),
            ),
            title: BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
              builder: (context, state) {
                if (state is MovieDetailsLoadingState || state is MovieDetailsSuccessState) {
                  final movieTitle = state is MovieDetailsSuccessState ? state.details.title : "Loading...";
                  return Row(
                    children: [
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          movieTitle ?? "No Title Available",
                          style: TextStyle(color: Colors.white, fontSize: 18.sp),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Container(); // Empty container if title is not available
                }
              },
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
                  builder: (context, state) {
                    if (state is MovieDetailsLoadingState) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is MovieDetailsSuccessState) {
                      final movie = state.details;
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Image.network(
                                  movie.posterPath != null
                                      ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                                      : 'https://via.placeholder.com/500x250?text=No+Image',
                                  width: double.infinity,
                                  height: 250.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(child: Text('Image failed to load'));
                                  },
                                ),
                                Positioned(
                                  left: 176.w,
                                  bottom: 78.h,
                                  child: CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      icon: Icon(Icons.play_arrow, size: 30),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title ?? "No Title Available",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    '${movie.releaseDate ?? "No release date"}, ${movie.runtime != null ? "${movie.runtime} mins" : "No runtime"}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          movie.posterPath != null
                                              ? 'https://image.tmdb.org/t/p/w500${movie.posterPath}'
                                              : 'https://via.placeholder.com/100x150?text=No+Image',
                                          width: 100.w,
                                          height: 150.h,
                                          fit: BoxFit.contain,
                                          errorBuilder: (context, error, stackTrace) {
                                            return Center(child: Text('Image failed to load'));
                                          },
                                        ),
                                      ),
                                      SizedBox(width: 12.w),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(height: 10.h),
                                            Text(
                                              movie.title ?? "No Title Available",
                                              style: TextStyle(
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            SizedBox(height: 8.h),
                                            Text(
                                              '${movie.releaseDate ?? "No release date"}, ${movie.runtime != null ? "${movie.runtime} mins" : "No runtime"}',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Colors.grey,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Wrap(
                                              spacing: 6.w,
                                              runSpacing: 6.h,
                                              children: movie.genres!.map((genre) {
                                                return Chip(
                                                  label: Text(genre.name!),
                                                  backgroundColor: Colors.grey.shade400,
                                                );
                                              }).toList(),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              movie.overview ?? "No description available",
                                              style: TextStyle(color: Colors.grey.shade300, fontSize: 14.sp),
                                            ),
                                            SizedBox(height: 10.h),
                                            Row(
                                              children: [
                                                Icon(Icons.star, color: Colors.amber),
                                                SizedBox(width: 5.w),
                                                Text(
                                                  movie.voteAverage?.toString() ?? "No Rating",
                                                  style: TextStyle(fontSize: 16.sp, color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20.h),
                                  Divider(color: Colors.grey.shade800),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Placeholder for the error message if details aren't available
                      return Container(
                        height: 250.h, // Adjust height as needed to match the size of the details section
                        child: Center(child: Text("Unexpected state occurred", style: TextStyle(color: Colors.white, fontSize: 16.sp))),
                      );
                    }
                  },
                ),
              ),
              BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>(
                builder: (context, state) {
                  if (state is MovieSimilarDetailsLoadingState) {
                    return Container(
                      height: 200.h,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  } else if (state is MovieSimilarDetailsSuccessState) {
                    final similarDetails = state.details.results;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.w),
                          child: Text(
                            'More Like This',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          height: 200.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: similarDetails!.length,
                            itemBuilder: (context, index) {
                              final similarDetail = similarDetails[index];
                              return Padding(
                                padding: EdgeInsets.only(left: 16.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      similarDetail.posterPath != null
                                          ? 'https://image.tmdb.org/t/p/w500${similarDetail.posterPath}'
                                          : 'https://via.placeholder.com/120x160?text=No+Image',
                                      width: 120.w,
                                      height: 160.h,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Center(child: Text('Image failed to load'));
                                      },
                                    ),
                                    SizedBox(height: 8.h),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          similarDetail.voteAverage?.toString() ?? "No Rating",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20.h),
                      ],
                    );
                  } else if (state is MovieSimilarDetailsErrorState) {
                    return Center(child: Text(state.errorMsg));
                  } else {
                    return Center(child: Text("Unexpected state occurred"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}