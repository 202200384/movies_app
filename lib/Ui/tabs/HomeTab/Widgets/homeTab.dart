import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';
import 'package:movies_app/Ui/tabs/HomeTab/cubit/home_tab_states.dart';
import 'package:movies_app/Ui/tabs/HomeTab/cubit/home_tab_view_model.dart';
import 'TopRatedSection.dart';
import 'UpComingSection.dart';
import 'movieCard.dart';

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
                    viewModel.popularList == null ||
                        viewModel.popularList!.isEmpty
                        ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors
                            .whiteColorText, // Change color for visibility
                      ),
                    )
                        : MovieCard(movieCard: viewModel.popularList!.first,),
                    SizedBox(height: 10.h),
                    // Upcoming Section
                    viewModel.upComingList == null ||
                        viewModel.upComingList!.isEmpty
                        ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.whiteColorText,
                      ),
                    )
                        : upComingSection(
                      name: 'New Releases',
                      upComingList: viewModel.upComingList!,
                    ),
                    SizedBox(height: 10.h),
                    // Top Rated Section
                    viewModel.topRatedList == null ||
                        viewModel.topRatedList!.isEmpty
                        ? Center(
                      child: CircularProgressIndicator(
                        color: AppColors.whiteColorText,
                      ),
                    )
                        : TopRatedSection(
                      name: 'Recommended',
                      topRatedList: viewModel.topRatedList!,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}