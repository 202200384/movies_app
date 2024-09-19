import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/movie_details_screen.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';
import 'package:movies_app/Ui/tabs/HomeTab/cubit/home_tab_states.dart';
import 'package:movies_app/Ui/tabs/HomeTab/cubit/home_tab_view_model.dart';
import 'TopRatedSection.dart';
import 'UpComingSection.dart';


class HomeTab extends StatefulWidget {
  static const String routeName = "homeTab";
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HometabState();
}

class _HometabState extends State<HomeTab> {
  HomeTabViewModel viewModel = HomeTabViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTabViewModel, homeTabStates>(
        bloc: viewModel
          ..getAllTopRated()
          ..getAllPopular()
          ..getAllUpComing(),
        builder: (BuildContext context, state) {
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
                    // Popular Section
                    Container(
                      height: 275.h, // Define height for Popular section
                      alignment: Alignment.center,
                      child: viewModel.popularList == null ||
                          viewModel.popularList!.isEmpty
                          ? Center(
                        child: CircularProgressIndicator(
                          color: AppColors
                              .whiteColorText, // Customize the color
                        ),
                      )
                          : CarouselSlider.builder(
                        itemCount: viewModel.popularList!.length,
                        itemBuilder: (context, index, realIndex) {
                          final movie = viewModel.popularList![index];
                          return GestureDetector(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(
                                      builder:(context)=>MovieDetailsScreen(movieId:movie.id!.toInt())));
                            },
                            child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            fit: BoxFit.cover,),
                          );
                        },
                        options: CarouselOptions(
                          height: 275
                              .h, // Use the same height as the container
                          enlargeCenterPage: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 2),
                          viewportFraction: 0.8,
                          aspectRatio: 16 / 9,
                          initialPage: 0,
                        ),
                      ),
                    ),

                    // SizedBox(height: 5.h),

                    // Upcoming Section
                    Container(
                      height: 215.h, // Define height for Upcoming section
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

                    // Top Rated Section
                    Container(
                      height: 240.h,
                      color: AppColors
                          .greySearchBarColor, // Define height for Top Rated section
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
        });
  }
}