import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Data/Response/TopRatedOrPopularResponse.dart';
import 'package:movies_app/Ui/Utils/my_assets.dart';


class MovieList extends StatefulWidget {
  final List<topRatedOrPopular> movieList;// List of movies

  final Function(int) onMovieTap;//Function to handle movie tap
  MovieList({Key? key, required this.movieList,required this.onMovieTap}) : super(key: key);

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  List<topRatedOrPopular> _movies = [];

  @override
  void initState() {
    super.initState();
    _movies = widget.movieList; // Initialize with the provided list

    // Set a timer to update the movie list every second
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _movies.shuffle();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: _movies.length, // Number of movies in the list
      itemBuilder: (context, index, realIndex) {
        return MovieCard(
          moviecard: _movies[index],
          onTap: (){
            widget.onMovieTap(_movies[index].id!.toInt());
          },// Pass each movie to MovieCard
        );
      },
      options: CarouselOptions(
        height: 300.h,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        viewportFraction: 0.8,
        aspectRatio: 16 / 9,
        initialPage: 0,
      ),
    );
  }
}

class MovieCard extends StatefulWidget {
  final topRatedOrPopular? moviecard;
  final VoidCallback onTap;
  MovieCard({Key? key, required this.moviecard,required this.onTap}) : super(key: key);

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool _isFavorite = false;

  void _saveIconState() {
    // Implement save logic here
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: double.infinity,
        height: 275.h,
        child: Stack(
          children: [
            // Movie Poster and Background
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 70.h,
              child: Opacity(
                opacity: 0.8,
                child: Image.network(
                  'https://image.tmdb.org/t/p/w500${widget.moviecard?.backdropPath}',
                  width: double.infinity,
                  height: 300.h,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      MyAssets.movieDora,
                      width: double.infinity,
                      height: 250.h,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            // Play Button and Movie Info
            Positioned(
              top: 50.h,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      // Navigation logic
                    },
                    child: Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        MyAssets.playButton,
                        width: 60.w,
                        height: 60.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            // Movie title and release date
            Positioned(
              right: 10.w,
              top: 210.h,
              child: Container(
                width: 250.w,
                height: 100.h,
                padding: EdgeInsets.symmetric(vertical: 5.h),
                child: Column(
                  children: [
                    // Movie Title
                    Text(
                      widget.moviecard?.title ?? 'Unknown Title',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                    // Movie Date and Details
                    Text(
                      '${widget.moviecard?.releaseDate ?? ''} • PG-13 • 2h 7m',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            // Smaller image at the bottom-left
            Positioned(
              top: 95.h,
              bottom: 0.h,
              left: 10.w,
              child: Container(
                margin: EdgeInsets.all(10),
                height: 140.h,
                width: 100.w,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://image.tmdb.org/t/p/w500${widget.moviecard?.posterPath ?? ""}',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Bookmark Icon
            Positioned(
              left: 15.w,
              top: 105.h,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isFavorite = !_isFavorite; // Toggle state
                    _saveIconState(); // Save state
                  });
                },
                child: Image.asset(
                  _isFavorite
                      ? MyAssets.addBookMark
                      : MyAssets.bookMark,
                  width: 30.w,
                  height: 40.h,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}