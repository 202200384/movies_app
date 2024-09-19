import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/Cubit/movie_details_view_model.dart';
import 'package:movies_app/Ui/MovieDetails(homeTab)/Cubit/movie_states.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';
import 'package:movies_app/Ui/Utils/my_assets.dart';

class MovieDetailsScreen extends StatelessWidget {
  final int movieId;
  MovieDetailsScreen({required this.movieId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create:(context)=>MovieDetailsViewModel()..getAllDetails(movieId)..getAllSimilarDetails(movieId),
      child:SafeArea(child: Scaffold(
          appBar: AppBar(
            title: Text('Movie Details'),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back)),
            actions: [
              IconButton(
                onPressed:(){},
                icon:Icon(Icons.share),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<MovieDetailsViewModel,MovieDetailsStates>(
                    builder:(context,state){
                      if(state is MovieDetailsLoadingState){
                        return Center(child: CircularProgressIndicator(),);
                      }else if(state is MovieDetailsSuccessState){
                        final movie = state.details;
                        return Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                               Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                 fit: BoxFit.cover,),

                                Positioned(left: 176.w,right: 176.w,bottom: 78.h,top: 79.h,
                                  child: CircleAvatar(
                                    backgroundColor: AppColors.whiteColorText,
                                    child: IconButton(
                                        onPressed:(){},
                                        icon:Icon(Icons.play_arrow)),
                                  ),),


                            Padding(padding:EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                     Text(movie.title ??"No TiTle Available",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),)
                                  ,
                                  SizedBox(height: 3.h,),
                                  Text('${movie.releaseDate ?? "No release data"},'
                                      '${movie.runtime != null ?"${movie.runtime}mins":"No runTime Available"}',
                                    style: TextStyle(color: AppColors.greyColor),
                                  ),
                                  SizedBox(height: 3.h,),
                                  Row(
                                    children:movie.genres!.map((genre){
                                      return Padding(padding: EdgeInsets.only(right: 6.w),
                                          child:ElevatedButton(
                                            onPressed: (){},
                                            child:Text(genre.name!),
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: AppColors.greyColor,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(8)
                                                )
                                            ),
                                          ));
                                    }).toList(),
                                  ),
                                  SizedBox(height: 3.h,),
                                  Text(movie.overview ??"No description available",
                                    style: TextStyle(color: AppColors.greyColor),),
                                  SizedBox(height: 3.h,),
                                  Row(
                                    children: [
                                      Icon(Icons.star,
                                        color: AppColors.yellow,
                                      ),
                                      SizedBox(width: 4.w,),
                                      Text(movie.voteAverage?.toString() ??"No Rating",
                                        style: TextStyle(fontSize: 18.sp),)
                                    ],
                                  )
                                ],
                      ) ),]),
                            SizedBox(height:20.h),
                            Divider(),
                          ],);
                      }else if(state is MovieDetailsErrorState){
                        return Center(child: Text(state.errorMsg),);
                      }else{
                        return Center(child: Text("Unexpected state occured"),);
                      }
                    }),
                BlocBuilder<MovieDetailsViewModel,MovieDetailsStates>(
                    builder:(context,state){
                      if (state is MovieSimilarDetailsLoadingState){
                        return Center(child: CircularProgressIndicator(),);
                      }else if(state is MovieSimilarDetailsSuccessState){
                        final similarDetails = state.details.results;
                        if(similarDetails !=null && similarDetails.isNotEmpty){
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(padding: EdgeInsets.all(16),
                                child: Text('More Like This',style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold
                                ),),),
                              Container(
                                height: 150,
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: similarDetails.length,
                                    itemBuilder: (context,index){
                                      final similarDetail = similarDetails[index];
                                      return Padding(padding: EdgeInsets.only(left: 16),
                                        child: Column(
                                          children: [
                                            Image.network('https://image.tmdb.org/t/p/w500${similarDetail.posterPath??""}',
                                              width: 100.w,
                                              height: 120.h,
                                              fit: BoxFit.cover,
                                            ),
                                            SizedBox(height: 8.h,),
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                  color: AppColors.yellow,
                                                  size: 16,),
                                                SizedBox(width: 4.w,),
                                                Text(similarDetail.voteAverage?.toString() ??"No Rating"),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              SizedBox(height: 20.h,),
                            ],
                          );}else{
                          return Center(child: Text('No Similar Movies Found'),);
                        }
                      }else if(state is MovieSimilarDetailsErrorState){
                        return Center(child: Text(state.errorMsg),);

                      }else{
                        return Center(child: Text("Unexpected state occured"),);
                      }
                    })
              ],
            ),
          )
      ))

    );
  }
}
