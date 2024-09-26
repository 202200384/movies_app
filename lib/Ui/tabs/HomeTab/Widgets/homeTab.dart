import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/movie_details_screen.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';
import 'package:movies_app/Ui/Utils/my_assets.dart';
import 'package:movies_app/Ui/tabs/HomeTab/cubit/home_tab_states.dart';
import 'package:movies_app/Ui/tabs/HomeTab/cubit/home_tab_view_model.dart';
import 'TopRatedSection.dart';
import 'UpComingSection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeTab extends StatefulWidget {
  static const String routeName = "homeTab";
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HometabState();
}

class _HometabState extends State<HomeTab> {
  HomeTabViewModel viewModel = HomeTabViewModel();
  List<bool> _favoriteStates = [];

  @override
  void initState() {
    super.initState();
    _loadFavoriteStates();
  }

  void _loadFavoriteStates() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<bool> states = [];
    for (var movie in viewModel.popularList ?? []) {
      states.add(prefs.getBool('isFavorite_${movie.id}') ?? false);
    }
    setState(() {
      _favoriteStates = states;
    });
  }

  void _saveFavoriteState(int movieId, bool isFavorite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isFavorite_$movieId', isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTabViewModel, homeTabStates>(
      bloc: viewModel
        ..getAllTopRated()
        ..getAllPopular()
        ..getAllUpComing(),
      builder: (BuildContext context, state) {
        if (viewModel.popularList == null || viewModel.popularList!.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }


        if (_favoriteStates.length != viewModel.popularList!.length) {
          _favoriteStates = List<bool>.filled(viewModel.popularList!.length, false);
          _loadFavoriteStates();
        }

        return Scaffold(
          backgroundColor: AppColors.blackColor,
          appBar: AppBar(
            backgroundColor: AppColors.blackColor,
            toolbarHeight: 5.h, // Reduced toolbar height
          ),
          body: Padding(
            padding: EdgeInsets.all(8.0.w),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  Container(
                    height: 380.h,
                    alignment: Alignment.center,
                    child: CarouselSlider.builder(
                      itemCount: viewModel.popularList!.length,
                      itemBuilder: (context, index, realIndex) {
                        final movie = viewModel.popularList![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                    movieId: movie.id!.toInt()),
                              ),
                            );
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 200.h,
                                child: Image.network(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 198.h, left: 150.w),
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        movie.title ?? "Unknown Title",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 5.h),
                                      Text(
                                        "${movie.releaseDate?.substring(0, 5) ?? "Unknown year"} "
                                            "${movie.adult != null && movie.adult! ? "R" : "PG-13"} "
                                            "${(movie.runtime != null && movie.runtime! > 0) ?
                                        "${(movie.runtime! ~/ 60)}h ${(movie.runtime! % 60)}m" : "N/A"}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 140.h, left: 10.w),
                                child: Stack(
                                  alignment: Alignment.topLeft,
                                  children: [
                                    Container(
                                      width: 80.w,
                                      height: 120.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white, width: 2),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.5),
                                            blurRadius: 5,
                                            offset: Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Image.network(
                                        'https://image.tmdb.org/t/p/w200${movie.posterPath}',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _favoriteStates[index] = !_favoriteStates[index]; // Toggle state
                                          _saveFavoriteState(movie.id!.toInt(), _favoriteStates[index]); // Save state
                                        });
                                      },
                                      child: Image.asset(
                                        _favoriteStates[index]
                                            ? MyAssets.addBookMark
                                            : MyAssets.bookMark,
                                        width: 30.w,
                                        height: 30.h,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: 275.h,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                        viewportFraction: 0.8,
                        aspectRatio: 16 / 9,
                        initialPage: 0,
                      ),
                    ),
                  ),


                  Container(
                    height: 215.h,
                    alignment: Alignment.center,
                    child: viewModel.upComingList == null ||
                        viewModel.upComingList!.isEmpty
                        ? CircularProgressIndicator(
                      color: AppColors.whiteColorText,
                    )
                        : upComingSection(
                      name: 'New Releases',
                      upComingList: viewModel.upComingList!,
                    ),
                  ),
                  SizedBox(height: 25.h),


                  Container(
                    height: 240.h,
                    color: AppColors.greySearchBarColor,
                    alignment: Alignment.center,
                    child: viewModel.topRatedList == null ||
                        viewModel.topRatedList!.isEmpty
                        ? CircularProgressIndicator(
                      color: AppColors.whiteColorText,
                    )
                        : TopRatedSection(
                      name: 'Recommended',
                      topRatedList: viewModel.topRatedList!,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}